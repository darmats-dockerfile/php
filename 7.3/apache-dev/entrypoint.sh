#!/bin/sh

if [ -n "${APACHE_DOCUMENT_ROOT}" ]; then
    rmdir /var/www/html \
    && ln -s ${APACHE_DOCUMENT_ROOT} /var/www/html
fi

CMD=apache2-foreground
if [ $# -ne 0 ]; then
    CMD=$@;
fi
docker-php-entrypoint ${CMD}
