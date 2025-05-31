#!/bin/bash

# Function to detect the Linux distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo "Could not detect Linux distribution."
        exit 1
    fi
}

# Display the ASCII art in red for 3.5 seconds
display_ascii() {
    clear
    echo -e "\033[38;2;255;0;0m"  # Set color to red (RGB)
    cat << "EOF"
░█████╗░██╗░░░░░░█████╗░██╗░░░██╗██████╗░███████╗███╗░░░███╗░█████╗░██████╗░░██████╗
██╔══██╗██║░░░░░██╔══██╗██║░░░██║██╔══██╗██╔════╝████╗░████║██╔══██╗██╔══██╗██╔════╝
██║░░╚═╝██║░░░░░███████║██║░░░██║██║░░██║█████╗░░██╔████╔██║██║░░██║██║░░██║╚█████╗░
██║░░██╗██║░░░░░██╔══██║██║░░░██║██║░░██║██╔══╝░░██║╚██╔╝██║██║░░██║██║░░██║░╚═══██╗
╚█████╔╝███████╗██║░░██║╚██████╔╝██████╔╝███████╗██║░╚═╝░██║╚█████╔╝██████╔╝██████╔╝
░╚════╝░╚══════╝╚═╝░░░░░░╚═════╝░╚═════╝░╚══════╝╚═╝░░░░░╚═╝░╚════╝░╚═════╝░╚═════╝░
EOF
    echo -e "\033[38;2;0;255;255mBtrfs System Clone 1.04.3 31/05/2025\033[0m"
    sleep 3.5
}

# Main script
detect_distro
display_ascii

# Execute commands based on the detected distribution
case $DISTRO in
    debian|ubuntu)
        echo "Running commands for Debian/Ubuntu"
        # Add your Debian/Ubuntu commands here
        ;;
    arch)
        echo "Running commands for Arch Linux"
        # Add your Arch Linux commands here
        ;;
    fedora)
        echo "Running commands for Fedora"
        # Add your Fedora commands here
        ;;
    *)
        echo "Unsupported distribution: $DISTRO"
        exit 1
        ;;
esac

# Reset text color
echo -e "\033[0m"
