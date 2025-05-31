#!/bin/bash

# Configuration - Set your script paths here
GRUB_SCRIPT="/path/to/your/arch-btrfs-grub-script.sh"
SYSTEMD_BOOT_SCRIPT="/path/to/your/arch-btrfs-systemd-boot-script.sh"

# Function to display the ASCII art and header
display_header() {
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
    sleep 1.5
}

# Function to display menu and get user choice
show_menu() {
    echo -e "\n\033[1mSelect script to execute:\033[0m"
    echo -e "\033[38;2;255;255;0m1. Arch Btrfs Uefi Grub\033[0m"
    echo -e "   (\033[0;36m${GRUB_SCRIPT}\033[0m)"
    echo -e "\033[38;2;255;255;0m2. Arch Btrfs Uefi Systemd-boot\033[0m"
    echo -e "   (\033[0;36m${SYSTEMD_BOOT_SCRIPT}\033[0m)"
    echo -e "\n\033[1mEnter your choice (1-2): \033[0m"
}

# Function to execute selected script
execute_script() {
    local script_path=$1
    local script_name=$2
    
    if [ ! -f "$script_path" ]; then
        echo -e "\033[1;31mError: Script not found at $script_path\033[0m"
        exit 1
    fi
    
    if [ ! -x "$script_path" ]; then
        echo -e "\033[1;33mWarning: Script not executable. Attempting to make it executable...\033[0m"
        chmod +x "$script_path" || {
            echo -e "\033[1;31mFailed to make script executable. Please check permissions.\033[0m"
            exit 1
        }
    fi
    
    echo -e "\n\033[1;32mExecuting $script_name...\033[0m"
    echo -e "\033[0;36m======================================================================\033[0m"
    bash "$script_path"
    local exit_code=$?
    echo -e "\033[0;36m======================================================================\033[0m"
    
    if [ $exit_code -eq 0 ]; then
        echo -e "\033[1;32m$script_name completed successfully!\033[0m"
    else
        echo -e "\033[1;31m$script_name failed with exit code $exit_code\033[0m"
    fi
}

# Main script
display_header

show_menu

read -r choice
case $choice in
    1)
        execute_script "$GRUB_SCRIPT" "Arch Btrfs Uefi Grub"
        ;;
    2)
        execute_script "$SYSTEMD_BOOT_SCRIPT" "Arch Btrfs Uefi Systemd-boot"
        ;;
    *)
        echo -e "\033[1;31mInvalid choice. Exiting.\033[0m"
        exit 1
        ;;
esac
