FROM ruby:3.0.1-slim-buster

WORKDIR /home/app

ENV PORT 3000

EXPOSE $PORT


RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
    libsqlite3-dev \
&& apt-get clean \
&& rm -rf /var/cache/apt/archives/* \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
&& truncate -s 0 /var/log/*log

# Add NodeJS to sources list
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# Add Yarn to the sources list
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -yq --no-install-recommends \
  nodejs \
  yarn \
&& apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    truncate -s 0 /var/log/*log

RUN gem install bundler

RUN gem install rails

ENTRYPOINT [ "/bin/bash" ]
