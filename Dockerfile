FROM ruby:2.4

ENV LANG UTF-8
ENV RACK_ENV production

EXPOSE 8086

WORKDIR /data

CMD ["ruby","main.rb"]

COPY Gemfile /data/

RUN bundle install

COPY . /data/


