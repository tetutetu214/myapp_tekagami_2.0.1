FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /myapp_tekagami_2.0.1
WORKDIR /myapp_tekagami_2.0.1
COPY Gemfile /myapp_tekagami_2.0.1/Gemfile
COPY Gemfile.lock /myapp_tekagami_2.0.1/Gemfile.lock
RUN bundle install
COPY . /myapp_tekagami_2.0.1

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]