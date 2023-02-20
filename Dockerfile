# syntax=docker/dockerfile:1
FROM ruby:3.1.3
# FROM phusion/passenger-full
# ubuntu 20.04


LABEL maintainer="martino.giacchetti@gmail.com"
LABEL name="plot-twist"
LABEL description="Server to serve telegram-bot inline queries"

ENV HOME /root
ENV RAILS_ENV production
ENV NODE_ENV production

# Add our APT repository
# RUN sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7

RUN apt-get update -qq && \
 # apt-get upgrade -y && \
 apt-get install -y -qq --no-install-recommends \
 # nodejs \
 # postgresql-client \
 ffmpeg \
 cron \
 && \
# Install apache passenger & otehr
 # apt-get install -y dirmngr gnupg && \
 # apt-get install -y apt-transport-https ca-certificates && \
# Install Passenger + Apache module
 # apt-get install -y --allow-downgrades passenger=1:6.0.17-1~bionic1 && \
 # apt-get install -y apache2 && apt-get install -y libapache2-mod-passenger && \
 # rm -rf /var/lib/apt/lists/*
 echo "installed"
# RUN a2enmod passenger
# RUN apache2ctl restart

RUN mkdir -p /home/app/webapp
WORKDIR /home/app/webapp

# This copies your web app with the correct ownership.
COPY --chown=app:app . /home/app/webapp

# ADD thefuturebot.it.conf /etc/apache2/sites-enabled/thefuturebot.it.conf

# SET ruby version
# RUN bash -lc 'rvm --default use ruby-3.1.3'

# RUN bundle install
RUN bundle install

RUN chmod +x docker/entrypoint.sh
RUN chmod +x docker/production_start.sh

ENTRYPOINT ["docker/entrypoint.sh"]

RUN bundle exec rails assets:precompile SECRET_KEY_BASE=fake_secure_for_compile

EXPOSE 3000

HEALTHCHECK --start-period=60s CMD curl --fail http://localhost:80 || exit 1

# Configure the main process to run when running the image
CMD ["docker/production_start.sh"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
