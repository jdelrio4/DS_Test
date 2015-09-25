# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)


Gem::Specification.new do |gem|
  gem.name          = "ds_test"
  gem.version       = "0.0.4"
  gem.authors       = ["DS QA"]
  gem.email         = ["jdelrio@despegar.com,smendoza@despegar.com"]
  gem.description   = %q{Test de Media}
  gem.summary       = %q{Test automatizados}
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "byebug"
  gem.add_development_dependency "cucumber"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "geminabox"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "bundler"

   
  gem.add_runtime_dependency 'hpricot'
  gem.add_runtime_dependency 'watir-webdriver'
  gem.add_runtime_dependency 'httparty'
  gem.add_runtime_dependency 'httpclient'
  gem.add_runtime_dependency 'henry-container'
  gem.add_runtime_dependency 'rest-client'
end
