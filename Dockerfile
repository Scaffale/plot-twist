# syntax=docker/dockerfile:1
FROM ruby:3.1.0

LABEL maintainer="martino.giacchetti@gmail.com"
LABEL name="plot-twist"
LABEL description="Server to serve telegram-bot inline queries"

# ENV RAILS_ENV production
# ENV NODE_ENV production

RUN mkdir /plot-twist
ADD . /plot-twist
WORKDIR /plot-twist

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client ffmpeg && apt-get install -qq -y --no-install-recommends cron && rm -rf /var/lib/apt/lists/*

RUN bundle install
# RUN bundle install --without development test

RUN chmod +x docker/entrypoint.sh
RUN chmod +x docker/production_start.sh

ENTRYPOINT ["docker/entrypoint.sh"]

RUN bundle exec rails assets:precompile SECRET_KEY_BASE=fake_secure_for_compile

EXPOSE 443 80 88 8443 3000

HEALTHCHECK --start-period=60s CMD curl --fail http://localhost:3000 || exit 1

# Configure the main process to run when running the image
CMD ["docker/production_start.sh"]
# CMD ["rails", "server", "-b", "0.0.0.0"]
