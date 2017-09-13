# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pandapay/version"

Gem::Specification.new do |spec|
  spec.name          = "pandapay_api"
  spec.version       = PandaPay::VERSION
  spec.authors       = ["Dalton Cole"]
  spec.email         = ["dalton@alphaparse.com"]

  spec.summary       = %q{Gem to wrap PandaPay API}
  spec.description   = %q{Gem to wrap PandaPay API}
  spec.homepage      = "https://www.pandapay.io/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.1'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.10"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "json", "~> 2.1"
  spec.add_dependency "faraday"
end
