# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_correios'
  s.version     = '1.0.4'
  s.summary     = %q{A spree extensions to add Brazil's Correio calculators}
  s.required_ruby_version = '>= 1.9.2'

  s.authors     = ["Stefano Diem Benatti"]
  s.email       = ["stefano.diem@gmail.com"]
  s.homepage    = "http://github.com/heavenstudio/spree_correios"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core'
  s.add_dependency 'correios-frete'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
end
