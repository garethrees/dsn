# frozen_string_literal: true

require_relative 'lib/dsn/version'

Gem::Specification.new do |spec|
  spec.name = 'dsn'
  spec.version = DSN::VERSION
  spec.authors = ['Gareth Rees']
  spec.email = ['gareth@garethrees.co.uk']
  spec.license = 'MIT'

  spec.summary = %(Ruby parser for RFC 3463 Delivery Status Notification codes)
  spec.homepage = 'https://github.com/garethrees/dsn'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '~> 5.0'
end
