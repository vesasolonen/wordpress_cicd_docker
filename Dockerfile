# Docker base image
#FROM debian:buster-slim
FROM php:5.6-apache
# Komennot jotka ajetaan imagen luomisen
# yhteydessä
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install apache2 \
    && apt-get -y install unzip wget \
    && cd /var/www/html \
    && wget -c http://wordpress.org/latest.zip \ 
    && unzip latest.zip \
    && chown -R www-data:www-data wordpress \
    && rm latest.zip
RUN docker-php-ext-install mysqli pdo pdo_mysql  
COPY wp-config.php /var/www/html/wordpress
COPY your_domain.com.conf /etc/apache2/sites-available
RUN ln -s /etc/apache2/sites-available/your_domain.com.conf /etc/apache2/sites-enabled/your_domain.com.conf
# Tarjoaa palvelun portissa 80 
EXPOSE 80
# Komento joka ajetaan kontin käynnistyessä
# CMD ["nginx", "-g", "daemon off;"]
#CMD [&amp;quot;apache2ctl&amp;quot; ,&amp;quot; -DFOREGROUND&amp;quot;]
CMD ["apache2-foreground"]
