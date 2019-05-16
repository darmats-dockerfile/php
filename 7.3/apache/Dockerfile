FROM php:7.3-apache

RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget git ${PHPIZE_DEPS} libzip-dev \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN set -ex \
    && docker-php-ext-install zip pdo_mysql

RUN set -ex \
    && a2enmod rewrite

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
