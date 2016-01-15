# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sales_taxes/version'

Gem::Specification.new do |spec|
  spec.name          = "sales_taxes"
  spec.version       = SalesTaxes::VERSION
  spec.authors       = ["William Lee"]
  spec.email         = ["williaml33@outlook.com"]
  spec.summary       = %q{Calcuate SalesTaxes}
  spec.description   = %q{an application that prints out the receipt details for these shopping baskets...}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'sales_taxes_cal'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
