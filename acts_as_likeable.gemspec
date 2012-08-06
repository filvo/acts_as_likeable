# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_likeable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Filvo Interactive"]
  gem.email         = ["info@filvo.com"]
  gem.description   = %q{Acts as Likeable}
  gem.summary       = %q{Add Like functionality similar to Facebook}
  gem.homepage      = "https://github.com/filvo/acts_as_likeable"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "acts_as_likeable"
  gem.require_paths = ["lib"]
  gem.version       = ActsAsLikeable::VERSION

  gem.add_development_dependency 'rails', '~> 3.0'
end
