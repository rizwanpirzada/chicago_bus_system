# Base image
FROM ruby:3.2.0
# Set working directory
WORKDIR /app
# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./
# Install gems
RUN bundle install
# Copy the rest of the application code
COPY . .

# Set environment variables
ENV RAILS_ENV=development \
    DATABASE_URL=postgres://admin:password@localhost:5432/chicago_bus_system_development

ENTRYPOINT ["bin/docker-entrypoint"]

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
