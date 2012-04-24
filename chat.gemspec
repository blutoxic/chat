$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chat"
  s.version     = Chat::VERSION
  s.authors     = ["Luca Herzog"]
  s.email       = ["luca.herzog@swisscom.com"]
  s.homepage    = ""
  s.summary     = "Das ist ein Chat, welcher in ein Gem verpackt wurde, um ihn in das Dispositionstool IVO::Core
                  einzubinden."
  s.description = "Chat für IVO::Core."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  #s.add_dependency "rails", "~> 3.1.4"
   s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
