# same as 7.3-apache
FROM php:7.3-apache

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget git ${PHPIZE_DEPS} libzip-dev \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN set -ex \
    && docker-php-ext-install zip pdo_mysql opcache

RUN set -ex \
    && a2enmod rewrite && a2enmod headers

COPY install_composer.sh /tmp/

RUN set -ex \
    && sh /tmp/install_composer.sh \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer \
    && composer global require hirak/prestissimo

RUN set -ex \
    && echo "\
    alias cp='cp -i'\n\
    alias egrep='egrep --color=auto'\n\
    alias fgrep='fgrep --color=auto'\n\
    alias grep='grep --color=auto'\n\
    alias l.='ls -d .* --color=auto'\n\
    alias ls='ls --color=auto'\n\
    alias ll='ls -l --color=auto'\n\
    alias l='ll'\n\
    alias la='ls -la --color=auto'\n\
    alias lh='ls -lha --color=auto'\n\
    alias mv='mv -i'\n\
    alias rm='rm -i'\n\
    " >> /root/.bashrc

# for dev below
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

RUN set -ex \
    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN set -ex \
    && usermod -u 1000 www-data

# dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN set -ex \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# phpcs
RUN set -ex \
    && composer global require squizlabs/php_codesniffer

ENV PATH /root/.composer/vendor/bin:$PATH
