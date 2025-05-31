FROM debian:bullseye

RUN apt update && apt install -y \
  curl gnupg2 gcc g++ make autoconf automake bison libgdbm-dev \
  libncurses5-dev libtool libyaml-dev libreadline-dev zlib1g-dev \
  libffi-dev pkg-config sqlite3 libsqlite3-dev libssl-dev git \
  libcurl4-openssl-dev nodejs npm locales unzip

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
    git checkout beef-0.4.7.3

RUN sed -i 's/user: "beef"/user: "admin"/' /opt/beef/config.yaml && \
    sed -i 's/passwd: "beef"/passwd: "ChangeMe123!"/' /opt/beef/config.yaml

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8

# Bloc GeoIP optionnel
# RUN mkdir -p /opt/GeoIP && \
#     curl -L -o /opt/GeoIP/GeoLite2-City.tar.gz "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=YOUR_LICENSE_KEY&suffix=tar.gz" && \
#     tar --strip-components=1 -xvzf /opt/GeoIP/GeoLite2-City.tar.gz -C /opt/GeoIP

WORKDIR /opt/beef

RUN bundle config jobs 2 && bundle install && rake beef:minify

EXPOSE 3000

CMD ["ruby", "/opt/beef/beef"]
