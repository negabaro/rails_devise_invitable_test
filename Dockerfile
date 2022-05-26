FROM ruby:2.6.5-alpine

ENV LANG C.UTF-8
ENV APP_ROOT /app
ENV BUNDLE_APP_CONFIG=/shared/vendor/bundle
WORKDIR $APP_ROOT
# Minimal requirements to run a Rails app
RUN apk add --no-cache --update build-base \
    linux-headers \
    git \
    postgresql-dev \
    sqlite-dev \
    mysql-dev \
    nodejs \
    yarn \
    tzdata

RUN apk add bash vim less

COPY attachment/data_freedesktop.org.xml.in  /usr/local/share/mime/packages/freedesktop.org.xml

# RUN gem install rails

COPY Gemfile* ./

RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3 --path=/shared/vendor/bundle
COPY ./ ./

RUN node -v
RUN yarn -v

RUN rm -rf yarn.lock ;\
    yarn install

RUN bundle exec bin/webpack



RUN apk add supervisor
RUN mkdir -p tmp/pids
ADD ./attachment /attachment
RUN cp -arp /attachment/supervisor/supervisord.d /etc/supervisord.d ;\
    cp -arp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime ;\
    cp -arp /attachment/supervisor/supervisord.conf /etc/supervisord.conf ;\
    cp -arp /attachment/cmd/ready.sh /ready.sh ;\
    rm -rf /var/cache/apk/*

CMD sh /ready.sh && /usr/bin/supervisord -c /etc/supervisord.conf
