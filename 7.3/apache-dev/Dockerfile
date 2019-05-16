FROM darmats/php:7.3-apache

RUN set -ex \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

RUN set -ex \
    && echo "\
xdebug.var_display_max_children = -1 \n\
xdebug.var_display_max_data = -1 \n\
xdebug.var_display_max_depth = -1 \n\
" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY entrypoint.sh /
RUN set -ex \
    && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
WORKDIR /var/www/html

RUN set -ex \
    && usermod -u 1000 www-data
