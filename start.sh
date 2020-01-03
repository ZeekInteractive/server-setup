#!/bin/bash

# Load files
. src/utilities.sh
. src/system.sh
. src/users.sh
. src/applications.sh

# Set up base system
setup_base

# Add users
add_users_from_file

# Install necessary applications
install_applications

# Show success/completion message
end_message