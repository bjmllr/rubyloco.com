# How to use this file, for the absolute beginner to containers
#
# Install docker toolbox (skip the "getting started guide" for now)
#
#     https://www.docker.com/docker-toolbox
#
# It will install the Docker Quickstart Terminal for you.  This is a
# script that starts a Linux VM on VirtualBox for use as a docker host,
# then sets environment variables so that the docker client CLI will
# use that server.  When it's done, it will tell you the IP address of
# your VM.  Make a note of this address.
#
# Download this project.
#
#     git clone https://github.com/bjmllr/rubyloco.com
#     cd rubyloco.com
#     git checkout docker
#
# Build an image (this takes a while).
#
#     docker build -t rubyloco.com .
#
# Create and run a container as a foreground service (^C to end).
#
#     docker run -p 4567:4567 -ti --rm rubyloco.com
#
# Test it in your browser (replacing 192.168.99.100 with the IP noted above).
#
#     http://192.168.99.100:4567
#
# To see the effects of changes to the project source code, re-run the
# `docker build` and `docker run` commands just as before.

FROM debian:8

# set up working directory
RUN mkdir -p /rubyloco.com
WORKDIR /rubyloco.com

# install dependencies via apt, including build dependencies required for
# native extensions
RUN apt-get update && \
    apt-get install -y ruby git nodejs bundler rake \
                       ruby-dev libssl-dev build-essential

# install gems only if gem files have changed
COPY Gemfile Gemfile.lock ./
RUN bundle install --path vendor

# add project files
COPY . ./

# by default, start the middleman preview service on its default port
EXPOSE 4567
CMD ["bundle", "exec", "middleman", "server"]
