# syntax=docker/dockerfile:1
FROM phusion/passenger-ruby31
# ubuntu 20.04

# ora sto cercando di usare la porta 88
# se fallisce cerco di andare con apache
# dubbio sempre su certbot, link a tutta la cartella forse è melgio che il singolo file

LABEL maintainer="martino.giacchetti@gmail.com"
LABEL name="plot-twist"
LABEL description="Server to serve telegram-bot inline queries"

ENV HOME /root
ENV RAILS_ENV production
ENV NODE_ENV production

RUN apt-get update -qq && apt-get upgrade -y && apt-get install -y nodejs postgresql-client ffmpeg && apt-get install -qq -y --no-install-recommends cron && rm -rf /var/lib/apt/lists/*
# RUN apt-get install -y ca-certificates

# https://github.com/phusion/passenger-docker#using-nginx-and-passenger
RUN rm -f /etc/service/nginx/down
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD nginx.conf /etc/nginx/nginx.conf
RUN mkdir /home/app/webapp
WORKDIR /home/app/webapp

# This copies your web app with the correct ownership.
COPY --chown=app:app . /home/app/webapp

# Configure nginx
ADD secret_key.conf /etc/nginx/main.d/secret_key.conf
ADD gzip_max.conf /etc/nginx/conf.d/gzip_max.conf

# SET ruby version
# RUN bash -lc 'rvm --default use ruby-3.1.3'

# RUN bundle install
RUN bundle install

RUN chmod +x docker/entrypoint.sh
RUN chmod +x docker/production_start.sh

ENTRYPOINT ["docker/entrypoint.sh"]

RUN bundle exec rails assets:precompile SECRET_KEY_BASE=fake_secure_for_compile

EXPOSE 80 443 88

HEALTHCHECK --start-period=60s CMD curl --fail http://localhost:80 || exit 1

# Update certificates
# RUN bash -lc 'rvm get stable'
# RUN update-ca-certificates

# Configure the main process to run when running the image
CMD ["docker/production_start.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
