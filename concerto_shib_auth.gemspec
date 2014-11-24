$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "concerto_shib_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "concerto_shib_auth"
  s.version     = ConcertoShibAuth::VERSION
  s.authors     = ["Joshua Foster, based from Gabe Perez"]
  s.email       = ["jfosterrit@gmail.com"]
  s.homepage    = "http://www.concerto-signage.org"
  s.summary     = "Provides user authentication using Shibboleth"
  s.description = "Authorize Concerto users with Shibboleth"
#  s.license     = "Apache-2.0"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"
  s.add_dependency "omniauth-shibboleth"
  s.add_dependency "concerto_identity"

end
