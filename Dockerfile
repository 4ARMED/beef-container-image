FROM ruby:2.6-alpine
LABEL maintainer="Marc Wickenden <marc@4armed.com>"

RUN apk --update --no-cache add \
		curl \
		git \
		build-base \
		openssl \
		readline-dev \
		zlib \
		zlib-dev \
		libressl-dev \
		yaml-dev \
		sqlite-dev \
		sqlite \
		libxml2-dev \
		libxslt-dev \
		autoconf \
		libc6-compat \
		ncurses5 \
		automake \
		libtool \
		bison \
		nodejs

WORKDIR /app
RUN git clone https://github.com/4armed/beef.git
WORKDIR /app/beef
RUN bundle install --without test development
RUN openssl req -new -newkey rsa:3072 -sha256 -x509 -days 3650 -nodes -out beef_cert.pem -keyout beef_key.pem -subj "/CN=localhost"

ENTRYPOINT ["./beef"]
