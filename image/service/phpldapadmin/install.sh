#!/bin/bash -e
# this script is run during the image build

cat /container/service/phpldapadmin/assets/php7.0-fpm/pool.conf >> /etc/php/7.2/fpm/pool.d/www.conf
rm /container/service/phpldapadmin/assets/php7.0-fpm/pool.conf

cp -f /container/service/phpldapadmin/assets/php7.0-fpm/opcache.ini /etc/php/7.2/fpm/conf.d/opcache.ini
rm /container/service/phpldapadmin/assets/php7.0-fpm/opcache.ini

mkdir -p /var/www/tmp
chown www-data:www-data /var/www/tmp

# remove apache default host
a2dissite 000-default
rm -rf /var/www/html

# Add apache modules
a2enmod deflate expires

# delete unnecessary files
rm -rf /var/www/phpldapadmin_bootstrap/doc

# Copy folder of lib files that are php 7.2 ready
cp -f --target-directory=/var/www/phpldapadmin_bootstrap/lib/ /container/service/phpldapadmin/assets/lib_fix/*
