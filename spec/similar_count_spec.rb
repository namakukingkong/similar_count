# frozen_string_literal: true

require 'similar_count/scanner'
require 'digest'
require 'tmpdir'
RSpec.describe SimilarCount::Scanner do
  it 'has a version number' do
    expect(SimilarCount::VERSION).not_to be nil
  end

  describe '.file_hash' do
    let(:file_path) { 'spec/fixtures/test_file.txt' }

    before do
      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, 'abcdef')
    end

    after do
      File.delete(file_path) if File.exist?(file_path)
      FileUtils.rmdir(File.dirname(file_path)) if Dir.exist?(File.dirname(file_path))
    end

    it 'returns the correct hash for a given file' do
      hash = SimilarCount::Scanner.file_hash(file_path)
      expect(hash).to eq(Digest::SHA256.hexdigest('abcdef'))
    end
  end

  describe '.scan_directory' do
    let(:dir_path) { 'spec/fixtures/test_directory' }
    let(:file1_path) { File.join(dir_path, 'file1.txt') }
    let(:file2_path) { File.join(dir_path, 'file2.txt') }
    let(:file3_path) { File.join(dir_path, 'file3.txt') }
    let(:file4_path) { File.join(dir_path, 'file4.txt') }
    let(:file5_path) { File.join(dir_path, 'file5.txt') }

    before do
      FileUtils.mkdir_p(dir_path)
      File.write(file1_path, 'abcdef')
      File.write(file2_path, 'abcdef')
      File.write(file3_path, 'abcdef')
      File.write(file4_path, 'ghijkl')
      File.write(file5_path, 'ghijkl')
    end

    after do
      File.delete(file1_path) if File.exist?(file1_path)
      File.delete(file2_path) if File.exist?(file2_path)
      File.delete(file3_path) if File.exist?(file3_path)
      File.delete(file4_path) if File.exist?(file4_path)
      File.delete(file5_path) if File.exist?(file5_path)
      Dir.rmdir(dir_path) if Dir.exist?(dir_path)
    end

    it 'returns the most frequent content and its count' do
      result = SimilarCount::Scanner.scan_directory(dir_path)
      expect(result[:max_count]).to eq(3)
      expect(result[:text]).to eq('abcdef 3')
      expect(result[:content]).to eq('abcdef')
      expect(result[:max_hash]).to eq(Digest::SHA256.hexdigest('abcdef'))
      expect(result[:files_with_max_content]).to eq(['spec/fixtures/test_directory/file1.txt', 'spec/fixtures/test_directory/file2.txt', 'spec/fixtures/test_directory/file3.txt'])
    end

    it 'returns nil and count 0 if no files are found' do
      Dir.mktmpdir do |empty_dir|
        result = SimilarCount::Scanner.scan_directory(empty_dir)
        expect(result[:max_count]).to eq(0)
        expect(result[:text]).to eq('')
        expect(result[:content]).to eq('')
        expect(result[:max_hash]).to eq('')
        expect(result[:files_with_max_content]).to eq([])
      end
    end
  end
end
