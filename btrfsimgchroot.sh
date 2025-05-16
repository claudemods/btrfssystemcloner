#!/bin/bash

# Get image path
read -e -p "Enter path to .img file: " IMAGE_PATH

# Verify image exists
[ ! -f "$IMAGE_PATH" ] && { echo "Error: Image not found!" >&2; exit 1; }

# Setup loop device and mount
LOOP_DEV=$(sudo losetup -f -P --show "$IMAGE_PATH")
sudo mount -o "${LOOP_DEV}p1" /mnt/root/boot/efi
sudo mount -o subvol=@ "${LOOP_DEV}p2" /mnt

# Chroot using arch-chroot
sudo arch-chroot /mnt

# Cleanup
sudo umount -R /mnt
sudo losetup -d "$LOOP_DEV"
