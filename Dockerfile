FROM litespeedtech/openlitespeed:1.9.4-lsphp85

LABEL maintainer="Marc Anton Dahmen <https://marcdahmen.de>"

ARG version
ENV AUTOMAD_VERSION=$version

RUN apt update && apt install -y curl

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/local/bin --filename=composer

COPY config/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY config/vhconf.conf /usr/local/lsws/conf/vhosts/Example/vhconf.conf
COPY config/php.ini /usr/local/lsws/lsphp85/etc/php/8.5/litespeed/php.ini

COPY init.sh /init.sh
RUN chmod +x /init.sh

WORKDIR /app
VOLUME /app

EXPOSE 8088

ENTRYPOINT ["/init.sh"]
