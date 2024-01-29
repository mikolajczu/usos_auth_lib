require_relative 'lib/usos_auth_lib/version'

Gem::Specification.new do |spec|
  spec.name        = 'usos_auth_lib'
  spec.version     = UsosAuthLib::VERSION
  spec.authors     = ['mikolajczu']
  spec.email       = ['mikeyczu@gmail.com']
  spec.homepage    = 'https://github.com/mikolajczu/usos_auth_lib'
  spec.summary     = '
    UsosAuthLib: Simplify user authentication in Ruby applications with
    this powerful gem tailored for seamless integration with the USOS API.
    Streamline your workflow and elevate your projects effortlessly.
  '
  spec.description = '
    Enhance your Ruby applications with UsosAuthLib, a robust gem for streamlined user authentication
    via the USOS API. Simplify your workflow, contribute to the community,
    and power up your Ruby projects effortlessly with UsosAuthLib.
  '
  spec.license = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'oauth'
  spec.add_dependency 'rails', '>= 7.1.2'
  spec.add_development_dependency 'rspec-rails'
end
