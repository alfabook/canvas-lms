$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "alfabook_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "alfabook_api"
  s.version     = AlfabookApi::VERSION
  s.authors     = ["Marco Melis"]
  s.email       = ["m.melis@alfabook.it"]
  s.homepage    = "http://www.alfabook.it"
  s.summary     = "API enrichments"
  s.description = "Set of api services used by external alfabook systems."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails'
  s.add_development_dependency 'sqlite3'
end
