#!/bin/sh

echo "Creating credentials"
EDITOR="mate --wait" bin/rails credentials:edit
chmod 777 /home/app/webapp/config/master.key

# Prepare Database
echo "Preparing DB"
RAILS_ENV=production bin/rails db:prepare
RAILS_ENV=production bin/rails db:seed

service nginx restart &

echo "Ready to go"
tail -f /home/app/webapp/log/production.log
# bundle exec passenger start --port=88 --app-type rack --environment production

# bundle exec puma -C config/puma.rb
