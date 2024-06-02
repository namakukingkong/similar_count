require 'digest'
require 'find'

module SimilarCount
  class Scanner
    def self.file_hash(file_path)
      sha256 = Digest::SHA256.new
      File.open(file_path, 'rb') do |file|
        buffer = ''
        sha256.update(buffer) while file.read(4096, buffer)
      end
      sha256.hexdigest
    end

    def self.read_content(file_path)
      content = File.read(file_path)
      content
    rescue => e
      puts "Error reading #{file_path}: #{e.message}"
      nil
    end

    def self.scan_directory(path)
      hash_to_count = Hash.new(0)
      hash_to_files = Hash.new { |hash, key| hash[key] = [] }

      Find.find(path) do |file|
        next if File.directory?(file) # Skip directories

        begin
          content_hash = file_hash(file)
          hash_to_count[content_hash] += 1
          hash_to_files[content_hash] << file
        rescue => e
          puts "Error processing #{file}: #{e.message}"
        end
      end

      max_count              = hash_to_count.values.max.to_i
      max_hash               = hash_to_count.key(max_count) || ''
      files_with_max_content = hash_to_files[max_hash]
      content                = max_count > 0 ? read_content(files_with_max_content.first) : ''
      { text:                   max_count > 0 ? "#{content} #{max_count}" : '',
        content:                content,
        max_count:              max_count,
        max_hash:               max_hash,
        files_with_max_content: files_with_max_content }
    end
  end
end
