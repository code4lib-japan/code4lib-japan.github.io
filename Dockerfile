FROM ruby:2.5-alpine

ENV APPPATH /usr/local/website
RUN mkdir -p $APPPATH
WORKDIR $APPPATH

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN apk --update  add --virtual build_deps \
    build-base ruby-dev libc-dev linux-headers \
    && gem install --verbose --no-document bundler \
    && bundle install --verbose --path=/usr/local/bundle \
    && apk del build_deps \
    && apk add git

EXPOSE 4000 80