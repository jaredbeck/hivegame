# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hivegame/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jared Beck"]
  gem.email         = ["jared@jaredbeck.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hivegame"
  gem.require_paths = ["lib"]
  gem.version       = Hivegame::VERSION

  gem.add_runtime_dependency "rgl"
  gem.add_runtime_dependency "activesupport"
  gem.add_development_dependency "rspec"
end
