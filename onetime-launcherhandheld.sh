#!/bin/bash

# Clone the repo into projects directory
git clone https://github.com/claudemods/btrfssystemcloner.git

# Copy the whole damn folder to /opt
cp -r btrfssystemcloner/place-in-opt/btrfssystemclonercachyoshandheld

# Delete the original clone
rm -rf btrfssystemcloner

chmod +x /opt/btrfssystemcloner/btrfssystemclonercachyoshandheld

# Run the fucking command
cd /opt/btrfssystemcloner && ./btrfssystemclonercachyoshandheld
