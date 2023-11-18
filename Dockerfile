FROM ruby:3.2.2

LABEL maintainer="tearhear18@gmail.com"

WORKDIR /workspace
COPY Gemfile /workspace
COPY Gemfile.lock /workspace
RUN bundle install

COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

ENTRYPOINT ["docker-entrypoint.sh"]