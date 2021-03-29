# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "rspec_codewars_formatter"
  spec.version       = "0.1.0"
  spec.authors       = ["kazk"]
  spec.email         = []

  spec.summary       = "RSpec formatter for Codewars"
  spec.description   = "RSpec formatter for Codewars"
  spec.homepage      = "https://github.com/codewars/rspec_codewars_formatter"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/codewars/rspec_codewars_formatter"

  spec.files         = Dir["lib/**/*", "README.md", "LICENSE"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec-core", ">= 3", "< 4"
  spec.add_dependency "rspec-expectations", ">= 3", "< 4"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
