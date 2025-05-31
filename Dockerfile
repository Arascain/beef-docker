FROM debian:bullseye

# Installer les dépendances système + dépendances curb
RUN apt update && apt install -y \
  curl gnupg2 gcc g++ make autoconf automake bison libgdbm-dev \
  libncurses5-dev libtool libyaml-dev libreadline-dev zlib1g-dev \
  libffi-dev pkg-config sqlite3 libsqlite3-dev libssl-dev git \
  libcurl4-openssl-dev

# Télécharger et compiler Ruby 2.7.8
WORKDIR /usr/src
RUN curl -O https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.8.tar.gz && \
    tar -xzf ruby-2.7.8.tar.gz && \
    cd ruby-2.7.8 && \
    ./configure && \
    make && \
    make install

# Vérification Ruby
RUN ruby -v

# Installer bundler compatible
RUN gem install bundler -v 2.3.27

# Cloner BeEF version stable compatible Ruby 2.7
RUN git clone https://github.com/beefproject/beef.git /opt/beef && \
    cd /opt/beef && \
    git checkout v0.5.0.0

# Installer les gems nécessaires
WORKDIR /opt/beef
RUN bundle install

# Exposer le port BeEF
EXPOSE 3000

# Commande de démarrage
CMD ["bash", "/opt/beef/beef"]
