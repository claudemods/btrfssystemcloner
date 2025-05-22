#!/bin/bash

# Get drive path
read -e -p "Enter drive path (e.g., /dev/sda): " DRIVE_PATH

# Verify drive exists
[ ! -b "$DRIVE_PATH" ] && { echo "Error: Drive not found!" >&2; exit 1; }

# Create mount points
sudo mkdir -p /mnt/boot/efi
sudo mkdir -p /mnt

# Mount partitions (your original mounting approach)
sudo mount "${DRIVE_PATH}1" /mnt/boot/efi
sudo mount -o subvol=@ "${DRIVE_PATH}2" /mnt

# Mount critical virtual filesystems (FIX for your problems)
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
sudo mount --bind /run /mnt/run
sudo mount --bind /dev/pts /mnt/dev/pts
# Chroot (your original approach)
sudo chroot /mnt/

# Cleanup (modified to unmount everything properly)
sudo umount /mnt/run
sudo umount /mnt/sys
sudo umount /mnt//proc
sudo umount /mnt/dev
sudo umount -R /mnt
