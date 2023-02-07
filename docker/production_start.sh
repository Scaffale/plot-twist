#!/bin/sh

# Prepare Database
echo "Preparing DB"
RAILS_ENV=production bin/rails db:prepare

bundle exec passenger start --port=80 --app-type rack --environment production

# bundle exec puma -C config/puma.rb
