# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'katsudo/version'

Gem::Specification.new do |gem|
  gem.name          = "katsudo"
  gem.version       = Katsudo::VERSION
  gem.authors       = ["Valery Kvon"]
  gem.email         = ["addagger@gmail.com"]
  gem.homepage      = %q{http://vkvon.ru/projects/katsudo}
  gem.description   = %q{User activity for Rails}
  gem.summary       = %q{Stores activity traces + Flashing subsystem}

	gem.add_dependency "active_tools"
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
