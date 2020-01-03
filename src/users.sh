#!/bin/bash

add_user_with_key() {
    adduser --disabled-password --gecos GECOS $1
    usermod -aG sudo $1
    usermod -aG www-data $1

    sudo -u $1 mkdir -m 700 /home/$1/.ssh
    sudo -u $1 touch /home/$1/.ssh/authorized_keys

    maybe_add_line_to_file $2 /home/$1/.ssh/authorized_keys
    chmod 600 /home/$1/.ssh/authorized_keys
}

add_user_generate_key() {
    adduser --disabled-password --gecos GECOS $1
    usermod -aG www-data $1

    sudo -u $1 mkdir -m 700 /home/$1/.ssh
    sudo -u $1 touch /home/$1/.ssh/authorized_keys

    sudo -u $1 ssh-keygen -t ed25519
    chmod 600 /home/$1/.ssh/authorized_keys
}

add_users_from_file() {
    if [ ! -f config/users.txt ]; then
        echo "No users.txt file found, aborting setup script."
        exit 1
    fi

    cat config/users.txt | while read line || [[ -n $line ]];
    do
        USER=$(echo "$line" | cut -d= -f1)
        KEY=$(echo "$line" | cut -d= -f2)

        echo "Creating user: $USER with key: $KEY"
        add_user_with_key $USER $KEY
    done

    echo "Users added."
}