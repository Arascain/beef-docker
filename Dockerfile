# -----------------------------------------------
# BeEF Dockerfile - Red Team Stable Edition 2025+
# Compatible with:
#  - Kali 2025+, Debian 12+, Parrot OS
#  - BeEF v0.5.0.0 (stable Ruby 2.7.x support)
# -----------------------------------------------

FROM debian:bullseye

LABEL maintainer="Red Team Build by ChatGPT 🤖"
LABEL version="2025.1"

# --- Install system dependencies ---
RUN apt update && apt install -y \
  curl gnupg2 gcc g++ make autoconf automake bison libgdbm-dev \
  libncurses5-dev libtool libyaml-dev libreadline-dev zlib1g-dev \
  libffi-dev pkg-config sqlite3 libsqlite3-dev libssl-dev git \
  libcurl4-openssl-dev

# --- Download & Compile Ruby 2.7.8 ---
WORKDIR /usr/src
RUN curl -O https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.8.tar.gz && \
    tar -xzf ruby-2.7.8.tar.gz && \
    cd ruby-2.7.8 && \
    ./configure && \
    make -j$(nproc) && \
    make install

# --- Verify Ruby version ---
RUN ruby -v

# --- Install compatible Bundler ---
RUN gem install bundler -v 2.3.27

# --- Clone stable BeEF version ---
RUN git clone https://github.com/beefproject/beef.git /opt/beef && \
    cd /opt/beef && \
    git checkout v0.5.0.0

# --- Patch Gemfile for sqlite3 compatibility with Ruby 2.7 ---
RUN sed -i 's/gem "sqlite3".*/gem "sqlite3", "~> 1.4.2"/' /opt/beef/Gemfile

# --- Install BeEF dependencies ---
WORKDIR /opt/beef
RUN bundle config jobs 2 && bundle install

# --- Expose BeEF default port ---
EXPOSE 3000

# --- Default startup command ---
CMD ["bash", "/opt/beef/beef"]
