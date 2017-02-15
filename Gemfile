source 'https://rubygems.org'

RAILS_VERSION = '~> 4.2.7.1'

send :ruby, ENV['GEMFILE_RUBY_VERSION'] if ENV['GEMFILE_RUBY_VERSION']

gem 'actionmailer', '>= 4.2.7.1', RAILS_VERSION
gem 'actionpack', '>= 4.2.7.1', RAILS_VERSION
gem 'railties', '>= 4.2.7.1', RAILS_VERSION

gem 'moped', '~> 2.0.5'
gem 'mongoid', '~> 4.0.2'

gem 'mongoid_rails_migrations', '>= 1.0.1'
gem 'devise', '>= 3.5.4'
gem 'haml'
gem 'htmlentities'
gem 'rack-ssl', :require => 'rack/ssl'   # force SSL

gem 'useragent'
gem 'decent_exposure'
gem 'actionmailer_inline_css', '>= 1.5.3'
gem 'kaminari', '>= 0.14.1'
gem 'rack-ssl-enforcer', :require => false
gem 'rails_autolink', '>= 1.1.6'
# Please don't update hoptoad_notifier to airbrake.
# It's for internal use only, and we monkeypatch certain methods
gem 'hoptoad_notifier', "~> 2.4"
gem 'draper', '>= 1.4.0'

gem 'errbit_plugin', github: 'errbit/errbit_plugin'
gem 'errbit_github_plugin', github: 'errbit/errbit_github_plugin'

gem 'dotenv-rails'

# Notification services
# ---------------------------------------
gem 'campy'
# Hipchat
gem 'hipchat'
# Google Talk
gem 'xmpp4r', :require => ["xmpp4r", "xmpp4r/muc"]
# Hoiio (SMS)
gem 'hoi'
# Pushover (iOS Push notifications)
gem 'rushover', '>= 0.3.0'
# Hubot
gem 'httparty'
# Flowdock
gem 'flowdock'

# Authentication
# ---------------------------------------
# GitHub OAuth
gem 'omniauth-github'

#### GDS additions ####
# GDS Signon
gem 'omniauth-gds', '~> 3.1'
gem 'plek', '1.7.0'
gem 'warden-oauth2', '0.0.1'

gem 'logstasher', '0.4.8'
gem 'statsd-ruby', '1.3.0'
#### End GDS additions ####

gem 'ri_cal'
gem 'yajl-ruby', platform: 'ruby'
gem 'json', platform: 'jruby'

group :development, :test do
  gem 'airbrake', :require => false
  gem 'pry-rails'
  gem 'pry-byebug', platforms: [:mri]
  gem 'quiet_assets', '>= 1.0.2'
end

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rbenv',   require: false

  # better errors
  gem 'better_errors'
  gem 'binding_of_caller', platform: 'ruby'
  gem 'meta_request', '>= 0.2.8'
end

group :test do
  gem 'rspec'
  gem 'rspec-rails', '~> 3.4.1', require: false
  gem 'rspec-activemodel-mocks'
  gem 'rspec-its'
  gem 'mongoid-rspec', '>= 2.0.0', require: false
  gem 'fabrication'
  gem 'capybara', '>= 2.4.4'
  gem 'poltergeist', '>= 1.5.1'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'timecop'
  ## GDS change: don't require test-unit as it triggers auto-running which breaks CI
  gem 'test-unit', require: false
  gem 'coveralls', '>= 0.7.0', require: false
  #### GDS additions ####
  gem 'webmock'
  #### End GDS additions ####
end

group :heroku, :production do
  gem 'rails_12factor', require: !!ENV["HEROKU"]
  gem 'unicorn', require: false, platform: 'ruby'
end

gem 'uglifier', '>= 2.7.2'
gem 'sass'
gem 'sass-rails', '>= 5.0.6'
gem 'coffee-rails', '>= 4.1.0'
# We can't upgrade because not compatible to jquery >= 1.9.
# To do that, we need fix the rails.js
gem 'jquery-rails', '~> 3.1.3'
gem 'pjax_rails', '>= 0.3.4'
gem 'underscore-rails'
