# PHP 8.2 with Supervisor for running Workers
FROM php:8.2-cli

RUN docker-php-ext-install -j$(nproc) bcmath

RUN apt-get update && apt-get install -y supervisor && apt-get clean
RUN mkdir -p /var/log/supervisor /usr/src/app

COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME ["/etc/supervisor/conf.d", "/usr/src/app"]

EXPOSE 9001

CMD ["/usr/bin/supervisord"]