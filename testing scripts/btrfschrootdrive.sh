#!/bin/bash

# Get drive path
read -e -p "Enter drive path (e.g., /dev/sda): " DRIVE_PATH

# Verify drive exists
[ ! -b "$DRIVE_PATH" ] && { echo "Error: Drive not found!" >&2; exit 1; }

# Create mount points
sudo mkdir -p /mnt/root/boot/efi
sudo mkdir -p /mnt/root

# Mount partitions (your original mounting approach)
sudo mount "${DRIVE_PATH}1" /mnt/root/boot/efi
sudo mount -o subvol=@ "${DRIVE_PATH}2" /mnt/root

# Mount critical virtual filesystems (FIX for your problems)
sudo mount --bind /dev /mnt/root/dev
sudo mount --bind /proc /mnt/root/proc
sudo mount --bind /sys /mnt/root/sys
sudo mount --bind /run /mnt/root/run
sudo mount --bind /dev/pts /mnt/root/dev/pts
# Chroot (your original approach)
sudo chroot /mnt/root

# Cleanup (modified to unmount everything properly)
sudo umount /mnt/root/run
sudo umount /mnt/root/sys
sudo umount /mnt/root/proc
sudo umount /mnt/root/dev
sudo umount -R /mnt/root
