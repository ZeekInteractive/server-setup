#!/bin/bash
DIR=$(pwd)
SRC="${DIR}/src"

# Load files
. ${SRC}/utilities.sh
. ${SRC}/system.sh
. ${SRC}/users.sh
. ${SRC}/applications.sh

# Set up base system
setup_base

# Add users
add_users_from_file

# Install necessary applications
install_applications

# Show success/completion message
end_message