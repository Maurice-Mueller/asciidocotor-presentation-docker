FROM debian:buster-slim

ARG revealjs_version=3.8.0
ARG decktape_version=2.9.3

# fix for using slim (does not include man directory)
RUN mkdir -p /usr/share/man/man1

RUN apt-get update
RUN apt-get install -y wget unzip ruby curl make g++

# for plantuml
RUN apt-get install -y default-jre-headless
RUN apt-get install -y graphviz

# for chrome headless
RUN apt-get install -y gconf-service \
libasound2 \
libatk1.0-0 \
libatk-bridge2.0-0 \
libc6 \
libcairo2 \
libcups2 \
libdbus-1-3 \
libexpat1 \
libfontconfig1 \
libgcc1 \
libgconf-2-4 \
libgdk-pixbuf2.0-0 \
libglib2.0-0 \
libgtk-3-0 \
libnspr4 \
libpango-1.0-0 \
libpangocairo-1.0-0 \
libstdc++6 \
libx11-6 \
libx11-xcb1 \
libxcb1 \
libxcomposite1 \
libxcursor1 \
libxdamage1 \
libxext6 \
libxfixes3 \
libxi6 \
libxrandr2 \
libxrender1 \
libxss1 \
libxtst6 \
ca-certificates \
fonts-liberation \
libappindicator1 \
libnss3 \
lsb-release \
xdg-utils \
wget

RUN apt-get autoremove -y

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN gem install bundler

RUN mkdir -p /asciidoc/lib

WORKDIR /asciidoc/lib

RUN wget https://github.com/hakimel/reveal.js/archive/$revealjs_version.zip -O revealjs.zip

RUN wget https://github.com/astefanutti/decktape/archive/v$decktape_version.zip -O decktape.zip

RUN unzip revealjs.zip
RUN unzip decktape.zip
RUN rm -f revealjs.zip decktape.zip
RUN mv reveal.js-$revealjs_version revealjs
RUN mv decktape-$decktape_version decktape

WORKDIR /asciidoc/lib/decktape
RUN npm install

WORKDIR /asciidoc

RUN mkdir revealjs_config

COPY Gemfile Gemfile
RUN bundle install

RUN mkdir /presentations

RUN chmod 777 -R /presentations
RUN chmod 777 -R /asciidoc


COPY common.rb common.rb
RUN chmod 777 common.rb

COPY config.rb config.rb
RUN chmod 777 config.rb

COPY extensions.rb extensions.rb
RUN chmod 777 extensions.rb

COPY build.rb build.rb
RUN chmod 777 build.rb

COPY Rakefile Rakefile
RUN chmod 777 Rakefile

COPY revealjs.css revealjs_config/revealjs.css
RUN chmod 777 -R revealjs_config/


ENTRYPOINT ["bundle", "exec", "rake"]
