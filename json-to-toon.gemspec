# frozen_string_literal: true

require_relative 'lib/json_to_toon/version'

Gem::Specification.new do |spec|
  spec.name = 'json-to-toon'
  spec.version = JsonToToon::VERSION

  spec.authors = ['Daniele Frisanco']
  spec.email = ['daniele.frisanco@gmail.com']

  spec.summary       = "Transforms JSON into the custom, human-readable Toon Format."
  spec.description   = "Transforms JSON into the custom, human-readable Toon Format. Features deep nesting support and optimized tabular array display."
  spec.homepage      = 'https://github.com/danielefrisanco/json-to-toon'
  spec.license       = 'MIT'

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.files         = Dir.glob("{lib}/**/*") + ["LICENSE.txt", "README.md"]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '~> 2.6'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.61'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
