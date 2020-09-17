#!/bin/bash

install_applications() {
    install_base
    install_do_monitoring
    install_php
    install_composer
    install_node
}

install_base() {
    apt-get update
    apt-get -y install curl unzip nginx git
}

install_php() {
    apt-get update
    apt-get -y install software-properties-common
    add-apt-repository -y ppa:ondrej/php
    apt-get update

    apt-get -y install php7.4
    apt-get -y install php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip,cli,curl,xml,json,dev,opcache,readline,fpm}
}

install_composer() {
    EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    mv composer.phar /usr/bin/composer
    rm composer-setup.php
}

install_node() {
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    apt-get install -y nodejs
}

install_do_monitoring() {
    curl -sSL https://repos.insights.digitalocean.com/install.sh | sudo bash
}
