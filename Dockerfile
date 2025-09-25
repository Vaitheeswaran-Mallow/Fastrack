# Use Ruby base image (pick your version)
FROM ruby:3.2

# Install system dependencies for gems and Node/Yarn
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile first to leverage caching
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the rest of the app
COPY . .

# Expose Rails port
EXPOSE 3000

# Default command: start Rails server
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
