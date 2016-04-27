#!/usr/bin/env bash

PACKAGE='curl'

sudo apt-get install $PACKAGE

# Install composer.phar
echo -e '\033[1;32m [+] Install to composer.phar \033[0m'
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin/

# Rename composer.phar composer
echo -e '\033[1;32m [+] Rename composer.phar composer \033[0m'
sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer
