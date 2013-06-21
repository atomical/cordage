$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cordage/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cordage'
  s.version     = Cordage::VERSION
  s.authors     = ['Adam Hallett']
  s.email       = ['adam.t.hallett@gmail.com']
  s.homepage    = 'http://github.com/atomical/cordage'
  s.summary     = 'Flexible record based associations in ActiveFedora models.'
  s.description = 'Flexible record based associations in ActiveFedora models.'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
end
