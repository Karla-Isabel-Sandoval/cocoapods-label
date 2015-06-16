# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-label/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-label'
  spec.version       = CocoapodsLabel::VERSION
  spec.authors       = ['Karla-Sandoval-Sandoval']
  spec.email         = ['k.isabel.sandoval@gmail.com']
  spec.description   = %q{A short description of cocoapods-label.}
  spec.summary       = %q{A longer description of cocoapods-label.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-label'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
