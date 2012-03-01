source 'http://rubygems.org'

group :test do
  gem 'ffaker'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'guard-rspec'
  gem 'growl'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gemspec

gem 'spree', git: 'https://github.com/spree/spree.git', branch: '1-0-stable'
