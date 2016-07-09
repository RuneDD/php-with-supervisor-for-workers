# PHP 7 with Supervisor for running Workers
FROM php:cli
MAINTAINER Carlos Buenosvinos <carlos.buenosvinos@gmail.com>

RUN apt-get update && apt-get install -y supervisor && apt-get clean
RUN docker-php-ext-install -j$(nproc) bcmath
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /usr/src/app

COPY supervisord.conf /etc/supervisor/conf.d/000-supervisord.conf

VOLUME ["/etc/supervisor/conf.d"]
VOLUME ["/usr/src/app"]

EXPOSE 9001

CMD ["/usr/bin/supervisord"]