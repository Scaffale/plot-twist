# syntax=docker/dockerfile:1
FROM phusion/passenger-ruby31

LABEL maintainer="martino.giacchetti@gmail.com"
LABEL name="plot-twist"
LABEL description="Server to serve telegram-bot inline queries"

ENV HOME /root
ENV RAILS_ENV production
ENV NODE_ENV production

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client ffmpeg && apt-get install -qq -y --no-install-recommends cron && rm -rf /var/lib/apt/lists/*

# https://github.com/phusion/passenger-docker#using-nginx-and-passenger
RUN rm -f /etc/service/nginx/down
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
RUN mkdir /home/app/webapp
WORKDIR /home/app/webapp

# This copies your web app with the correct ownership.
COPY --chown=app:app . /home/app/webapp

# RUN bundle install
RUN bundle install

RUN chmod +x docker/entrypoint.sh
RUN chmod +x docker/production_start.sh

ENTRYPOINT ["docker/entrypoint.sh"]

RUN bundle exec rails assets:precompile SECRET_KEY_BASE=fake_secure_for_compile

EXPOSE 80

HEALTHCHECK --start-period=60s CMD curl --fail http://localhost:80 || exit 1

# Configure the main process to run when running the image
CMD ["docker/production_start.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
