FROM debian:bullseye

RUN apt update && apt install -y \
  curl gnupg2 gcc g++ make autoconf automake bison libgdbm-dev \
  libncurses5-dev libtool libyaml-dev libreadline-dev zlib1g-dev \
  libffi-dev pkg-config sqlite3 libsqlite3-dev libssl-dev git \
  libcurl4-openssl-dev

WORKDIR /usr/src
RUN curl -O https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.8.tar.gz && \
    tar -xzf ruby-2.7.8.tar.gz && \
    cd ruby-2.7.8 && \
    ./configure && \
    make -j$(nproc) && \
    make install

RUN ruby -v

RUN gem install bundler -v 2.3.27

RUN git clone https://github.com/beefproject/beef.git /opt/beef && \
    cd /opt/beef && \
    git checkout v0.5.0.0

# Patch Gemfile sqlite3 et supprimer le lockfile pour résoudre proprement
RUN sed -i 's/gem "sqlite3".*/gem "sqlite3", "~> 1.4.2"/' /opt/beef/Gemfile && \
    rm -f /opt/beef/Gemfile.lock

WORKDIR /opt/beef
RUN bundle config jobs 2 && bundle install

EXPOSE 3000

CMD ["bash", "/opt/beef/beef"]
