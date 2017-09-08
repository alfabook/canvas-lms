$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "alfabook_i18n/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "alfabook_i18n"
  s.version     = AlfabookI18n::VERSION
  s.authors     = ["Marco Bergantin"]
  s.email       = ["m.bergantin@alfabook.it"]
  s.homepage    = "http://www.alfabook.it"
  s.summary     = "AlfabookI18n."
  s.description = "Description of AlfabookI18n."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'i18n'
end
