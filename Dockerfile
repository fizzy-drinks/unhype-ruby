FROM ruby:3

RUN apt-get install git 

COPY . .

RUN bundle install

EXPOSE 3000

CMD bundle exec star
