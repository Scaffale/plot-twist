#!/bin/sh

echo "preparing DB"
# Prepare Database
RAILS_ENV=production rails db:prepare

bundle exec puma -C config/puma.rb
