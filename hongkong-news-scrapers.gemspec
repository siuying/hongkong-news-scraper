# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hongkong/news/scrapers/version'

Gem::Specification.new do |spec|
  spec.name          = "hongkong-news-scrapers"
  spec.version       = Hongkong::News::Scrapers::VERSION
  spec.authors       = ["Francis Chong"]
  spec.email         = ["francis@ignition.hk"]

  spec.summary       = %q{Scrape Hong Kong news for good.}
  spec.description   = %q{Scrape Hong Kong news for good.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_dependency 'capybara', '~> 2.11.0'
  spec.add_dependency 'poltergeist'
  spec.add_dependency 'nokogiri'
end
