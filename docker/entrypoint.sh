#!/bin/sh

if [ -z ${SECRET_KEY_BASE+x} ]; then
  echo "Generating SECRET_KEY_BASE environment variable."
  echo "Please attention, all old sessions will become invalid."
  echo "You can set SECRET_KEY_BASE environment variable on docker service,"
  echo "to avoid generate SECRET_KEY_BASE every time when service start up."
  export SECRET_KEY_BASE=$(bin/rails secret)
fi

exec "$@"

# #!/bin/bash
# set -e

# # Remove a potentially pre-existing server.pid for Rails.
# rm -f /rambot/tmp/pids/server.pid

# rails assets:precompile
# rails db:prepare
# # rails link_webhook
# whenever --update-crontab

# # Then exec the container's main process (what's set as CMD in the Dockerfile).
# exec "$@"
