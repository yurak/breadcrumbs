$:.push File.expand_path('../lib', __FILE__)

require 'breadcrumbs/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'breadcrumbs'
  s.version     = Breadcrumbs::VERSION
  s.authors     = ['Yura Kuzhiy']
  s.email       = ['yurakuzhiy@gmail.com']
  s.summary     = 'Breadcrumbs builder and helper methods for views'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'actionpack'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'pry'
end
