#!/bin/sh
# activate maintenance mode
php artisan down
# update source code
git pull
# update PHP dependencies
composer install --no-interaction --no-dev --prefer-dist
# --no-interaction Do not ask any interactive question
# --no-dev  Disables installation of require-dev packages.
# --prefer-dist  Forces installation from package dist even for dev versions.
# update database
php artisan migrate --force
# --force  Required to run when in production.
# stop maintenance mode
chmod -R 770 /var/www
chown -R :www-data /var/www
chcon -Rv --type=httpd_sys_rw_content_t /var/www/root
sudo chmod +x deploy.sh
php artisan up
