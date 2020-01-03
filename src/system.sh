#!/bin/bash

setup_base() {
    export DEBIAN_FRONTEND=noninteractive
    
    maybe_add_line_to_file "%sudo   ALL=(ALL) NOPASSWD: ALL" /etc/sudoers.d/zeek-sudo
    groupadd www-data

    setup_firewall

    harden_ssh
}

setup_firewall() {
    # Open ssh port number
    ufw deny 22
    ufw allow 5079
}

harden_ssh() {
    # disable root login
    sed -i 's/#Port 22/Port 5079/g' /etc/ssh/sshd_config
    sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

    # restart sshd
    service ssh reload
}