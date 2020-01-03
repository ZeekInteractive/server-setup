#!/bin/bash

maybe_add_line_to_file() {
    grep -qxsF "${1}" "${2}" || echo "${1}" >> "${2}"
}

end_message() {
    echo ""
    echo "Add the following to your ./ssh/config file for easy system access:"
    
    echo ""
    echo "Host alias"
    echo "  HostName" $(curl -s ifconfig.me)
    echo "  Port 5079"
    echo "  User username"
    echo ""

    echo "Setup script completed. Login as user to confirm system is working and then restart system with: 'sudo shutdown -r now'."
}