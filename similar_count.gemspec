# frozen_string_literal: true

require_relative 'lib/similar_count/version'

Gem::Specification.new do |spec|
  spec.name          = 'similar_count'
  spec.version       = SimilarCount::VERSION
  spec.authors       = ['kotarominami']
  spec.email         = ['namakukingkong@gmail.com']

  spec.summary       = 'A gem to count files with the same content in a directory'
  spec.description   = 'This gem scans a directory to find files with the same content and returns the most frequent content and its count.'
  spec.homepage      = 'http://example.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_dependency 'thor', '~> 0.20.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.93.1'
  spec.add_development_dependency 'rubocop-performance', '~> 1.9.2'
end
