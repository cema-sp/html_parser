source 'https://rubygems.org'

ruby '2.3.3'

gem 'rails', '~> 5.0.1'
gem 'pg', '~> 0.18'

gem 'sucker_punch', '~> 2.0.2'
gem 'faraday', '~> 0.11.0'
gem 'nokogiri'

group :production do
  gem 'puma', '~> 3.0'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'minitest', '~> 5.10.1'
  gem 'minitest-spec-rails', '~> 5.4.0'
  gem 'database_cleaner', '~> 1.5.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
