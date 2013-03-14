# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nesta-plugin-related-by-category/version'

Gem::Specification.new do |gem|
  gem.name          = "nesta-plugin-related-by-category"
  gem.version       = Nesta::Plugin::RelatedByCategory::VERSION
  gem.authors       = ["James Abbott"]
  gem.email         = ["abbottjam@gmail.com"]
  gem.description   = %q{A plugin that finds related articles to a Nesta article, based on the relationship between its categories and other articles.}
  gem.summary       = %q{A plugin that finds related articles to a Nesta article, based on the relationship between its categories and other articles.}
  gem.homepage      = "https://github.com/abbottjam/nesta-plugin-related-by-category"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency("nesta", ">= 0.9.11")
  gem.add_development_dependency("rake")
end
