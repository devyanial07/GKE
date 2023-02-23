FROM ruby:2

RUN apt-get update && \
    apt-get install -y net-tools

COPY webapp/Gemfile /app/Gemfile
COPY webapp/app.rb /app/app.rb

RUN cd /app; bundle install


EXPOSE 8080
#RUN ["chmod","+x", "/app/Gemfile"]
#RUN ["chmod","+x", "/app/app.rb"]

CMD ["ruby", "/app/app.rb"]