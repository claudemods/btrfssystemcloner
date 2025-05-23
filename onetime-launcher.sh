#!/bin/bash

# Clone the repo into projects directory
git clone https://github.com/claudemods/btrfssystemcloner.git

# set opt directory to be user owned

sudo chown $USER /opt

# make the needed folers 

mkdir /opt/Arch-Systemtool

# setup application and place .desktop icon ect.....
cp -r btrfssystemcloner/place-in-opt/btrfssystemcloner /opt

cp -r onetime-launcher.sh /opt/Arch-Systemtool

cp -r btrfssystemcloner.desktop /usr/share/applications

cp -r btrfssystemcloner.png /opt/Arch-Systemtool

# Delete the original clone
rm -rf btrfssystemcloner

chmod +x /opt/btrfssystemcloner/btrfssystemclonercachyos

chmod +x /usr/share/applications/btrfssystemcloner.desktop

# Run the fucking command
cd /opt/btrfssystemcloner && ./btrfssystemclonercachyos
