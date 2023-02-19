FROM ruby:2

RUN apt-get update && \
    apt-get install -y net-tools

COPY /home/runner/work/GKE/GKE/gkeapp/app/Gemfile /app/Gemfile
RUN cd /app; bundle install
COPY /home/runner/work/GKE/GKE/gkeapp/app/app.rb /app/app.rb

EXPOSE 8080
CMD ["ruby", "/app/app.rb"]