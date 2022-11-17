#!/bin/sh

echo "preparing DB"
# Prepare Database
rails db:prepare db:seed
# RAILS_ENV=production rails db:prepare

bundle exec puma -C config/puma.rb
