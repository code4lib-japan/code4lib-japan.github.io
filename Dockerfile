FROM ruby:2.6-alpine

WORKDIR /srv/jekyll

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN apk --update  add --virtual build_deps \
    build-base ruby-dev \
    && apk add --no-cache libxml2-dev libxslt-dev \
    && bundle config build.nokogiri --use-system-libraries \
       --with-xml2-config=/usr/bin/xml2-config \
       --with-xslt-config=/usr/bin/xslt-config \
    && bundle install \
    && apk del build_deps \
    && apk add git

CMD bundle exec jekyll serve  -d ./_site --watch --force_polling -H 0.0.0.0 -P 4000

EXPOSE 4000
