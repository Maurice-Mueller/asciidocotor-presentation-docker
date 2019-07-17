FROM debian:latest

ARG revealjs_version=3.8.0
ARG decktape_version=2.9.3

RUN apt-get update
RUN apt-get install -y wget unzip ruby-full curl make g++
RUN apt-get install -y default-jre
RUN apt-get install -y graphviz

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

WORKDIR /asciidoc

COPY Gemfile Gemfile
RUN bundle install

COPY common.rb common.rb
COPY config.rb config.rb
COPY extensions.rb extensions.rb
COPY build.rb build.rb
COPY Rakefile Rakefile

RUN mkdir /asciip

RUN chmod 777 -R /asciip
RUN chmod 777 -R /asciidoc

ENTRYPOINT ["bundle", "exec", "rake"]
