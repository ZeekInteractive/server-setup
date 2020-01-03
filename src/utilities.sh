#!/bin/bash

maybe_add_line_to_file() {
    grep -qxsF "$1" "$2" || echo "$1" >> "$2"
}

end_message() {
    "Setup script completed. Login as user to confirm system is working and then restart system with: 'sudo shutdown -r now'."
}