FROM ruby:2.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/

RUN gem install bundler
RUN bundle install

COPY . /usr/src/app

CMD [ "ruby", "lib/control.rb" ]