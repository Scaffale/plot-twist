#!/bin/sh

# Prepare Database
echo "Preparing DB"
RAILS_ENV=production bin/rails db:prepare
RAILS_ENV=production bin/rails db:seed

bundle exec passenger start --port=80 --app-type rack --environment production

# bundle exec puma -C config/puma.rb
