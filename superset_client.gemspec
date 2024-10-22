# frozen_string_literal: true

require_relative "lib/superset_client/version"

Gem::Specification.new do |spec|
  spec.name = "superset_client"
  spec.version = SupersetClient::VERSION
  spec.authors = ["Jono Chang"]
  spec.email = ["jonathan.chang@silverpond.com.au"]

  spec.summary = "Ruby client for Apache Superset API"
  spec.description = "A Ruby client library for interacting with Apache Superset REST API"
  spec.homepage = "https://github.com/silverpond/superset_client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.glob("{lib}/**/*") + %w[LICENSE.txt README.md]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 2.0"
  spec.add_dependency "faraday-cookie_jar", "~> 0.0.7"

  spec.add_development_dependency "pry", "~> 0.14"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "rubocop", "~> 1.50"
  spec.add_development_dependency "rubocop-rspec", "~> 2.22"
  spec.add_development_dependency "webmock", "~> 3.18"
  spec.metadata["rubygems_mfa_required"] = "true"
end
