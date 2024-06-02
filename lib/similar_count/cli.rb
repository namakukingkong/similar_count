require 'thor'
module SimilarCount
  class CLI < Thor
    desc 'scan DIRECTORY', 'Scan the DIRECTORY for files with the same content'
    def scan(directory)
      result = SimilarCount::Scanner.scan_directory(directory)
      if result[:content]
        puts "Content: #{result[:content]}, Count: #{result[:count]}"
      else
        puts 'No files found.'
      end
    end
  end
end
