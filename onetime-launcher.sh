#!/bin/bash

# Function to run commands with cyan color
cyan_run() {
    echo -ne "\033[38;2;0;255;255m"  # Set cyan color
    "$@"
    echo -ne "\033[0m"  # Reset color
}

# Clone the repo into projects directory
cyan_run sudo git clone https://github.com/claudemods/btrfssystemcloner.git


# make the needed folders
cyan_run sudo mkdir /opt/Arch-Systemtool

# setup application and place .desktop icon etc.....
cyan_run sudo cp -r btrfssystemcloner/place-in-opt/btrfssystemcloner /opt
cyan_run sudo cp -r btrfssystemcloner/onetime-launcher.sh /opt/Arch-Systemtool/onetime-launcher.sh
cyan_run sudo cp -r btrfssystemcloner/btrfssystemcloner.desktop /usr/share/applications
cyan_run sudo cp -r btrfssystemcloner/btrfssystemcloner.png /opt/Arch-Systemtool/btrfssystemcloner.png


cyan_run sudo chmod +x /opt/btrfssystemcloner/btrfssystemclonercachyos
cyan_run sudo chmod +x /usr/share/applications/btrfssystemcloner.desktop
cyan_run sudo chmod +x /opt/Arch-Systemtool/onetime-launcher.sh


cyan_run sudo rm -rf btrfssystemcloner

# Run the command
echo -ne "\033[38;2;0;255;255m"
cd /opt/btrfssystemcloner && ./btrfssystemclonercachyos
echo -ne "\033[0m"
