FROM ruby:3

RUN apk add git 

COPY . .

RUN bundle install

CMD bundle exec star
