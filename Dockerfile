# syntax=docker/dockerfile:1
FROM ruby:3.1.3

LABEL maintainer="martino.giacchetti@gmail.com"
LABEL name="plot-twist"
LABEL description="Server to serve telegram-bot inline queries"

ENV HOME /root
ENV RAILS_ENV production

RUN apt-get update -qq && \
 apt-get install -y -qq --no-install-recommends \
 ffmpeg \
 cron

RUN mkdir -p /home/app/webapp
WORKDIR /home/app/webapp

# This copies your web app with the correct ownership.
COPY --chown=app:app . /home/app/webapp

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
