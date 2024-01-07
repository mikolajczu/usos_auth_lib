require_relative "lib/usos_auth_lib/version"

Gem::Specification.new do |spec|
  spec.name        = "usos_auth_lib"
  spec.version     = UsosAuthLib::VERSION
  spec.authors     = ["mikolajczu"]
  spec.email       = ["mikeyczu@gmail.com"]
  spec.homepage    = "https://github.com/mikolajczu/usos_auth_lib"
  spec.summary     = "Summary of UsosAuthLib."
  spec.description = "Description of UsosAuthLib."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.2"
  spec.add_development_dependency "rspec-rails"
end
