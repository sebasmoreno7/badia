# Badia · Rails articles and posts exercise

Historical Ruby on Rails application with article and post resources. Article pages are public to browse; the `ArticlesController` requires a Devise session to create or edit articles. The repository includes ERB views, Active Record models and a small set of RSpec model specs.

## Stack

Ruby 2.7.0, Rails 6.0, Devise, Webpacker, SQLite for development/test and a PostgreSQL production dependency are declared in the Gemfile. This is a learning project; no current deployment or passing test run is documented.

## Run locally

Install Ruby 2.7.0 and Bundler, then run `bundle install`, `bin/rails db:setup` and `bin/rails server`. Install JavaScript dependencies with Yarn if the assets require them. The setup has not been revalidated on current toolchains.
