#!/bin/bash
set -euo pipefail

# Hardcoded image path
IMAGE_PATH="/path/to/your/specific/image.img"

# Verify image exists
[ ! -f "$IMAGE_PATH" ] && { echo "Error: Image not found at $IMAGE_PATH!" >&2; exit 1; }

# Setup loop device
LOOP_DEV=$(sudo losetup -f -P --show "$IMAGE_PATH")

# Create mount points
sudo mkdir -p /mnt/img_root
sudo mkdir -p /mnt/img_root/boot/efi

# Mount operations
sudo mount -o subvol=@ "${LOOP_DEV}p2" /mnt/img_root || {
    echo "ERROR: Failed to mount @ on ${LOOP_DEV}p2" >&2
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

sudo mount "${LOOP_DEV}p1" /mnt/img_root/boot/efi || {
    echo "ERROR: EFI mount failed on ${LOOP_DEV}p1" >&2
    sudo umount /mnt/img_root
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

# Create a symlink in your home directory instead of root
mkdir -p ~/mounted_image
ln -s /mnt/img_root ~/mounted_image/root

echo "Access the mounted image at ~/mounted_image/root"
