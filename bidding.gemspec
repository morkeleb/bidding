# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bidding/version'

Gem::Specification.new do |spec|
  spec.name          = "bidding"
  spec.version       = Bidding::VERSION
  spec.summary     = "A small library for handling commands"
  spec.description = "Lets you create commands that will parse from oneline strings, and execute them."
  spec.authors     = ["Morten Nielsen"]
  spec.email       = 'morten@morkeleb.com'
  spec.homepage    = 'https://github.com/morkeleb/bidding'
  spec.license       = "MIT"

  #spec.files         = `git ls-files -z`.split("\x0")
  spec.files       =  Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "rake"
end
