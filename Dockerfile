ARG PGSQL_VERSION
FROM postgres:$PGSQL_VERSION-alpine AS postgres
RUN apk add --no-cache runit
RUN apk --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/main add \
      icu-libs \
      &&\
    apk --no-cache --repository https://dl-cdn.alpinelinux.org/alpine/edge/community add \
    # Current packages don't exist in other repositories
    libavif \
    && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted gnu-libiconv \
        # Packages
        tini \
        php81 \
        php81-dev \
        php81-common \
        php81-gd \
        php81-xmlreader \
        php81-bcmath \
        php81-ctype \
        php81-curl \
        php81-exif \
        php81-iconv \
        php81-intl \
        php81-mbstring \
        php81-opcache \
        php81-openssl \
        php81-pcntl \
        php81-phar \
        php81-session \
        php81-xml \
        php81-xsl \
        php81-zip \
        php81-zlib \
        php81-dom \
        php81-fpm \
        php81-sodium \
        php81-tokenizer \
        php81-fileinfo \
        php81-simplexml \
        # Iconv Fix
        php81-pecl-apcu \
        ncurses \
        xz \
    && ln -s /usr/bin/php81 /usr/bin/php
COPY start.sh /usr/local/bin/start.sh
COPY postgres.runit /etc/service/postgres/run
COPY sync-pull.runit /etc/service/sync-pull/run
COPY sync-push.runit /etc/service/sync-push/run
VOLUME /dumps
WORKDIR /sync
COPY . /sync
ENV PATH="/sync:${PATH}"
RUN chmod +x /sync/sync /etc/service/*/run
CMD ["start.sh"]