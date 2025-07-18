#!/bin/bash
set -euo pipefail

# Hardcoded image path
IMAGE_PATH="/path/to/your/specific/image.img"

# Verify image exists
[ ! -f "$IMAGE_PATH" ] && { echo "Error: Image not found at $IMAGE_PATH!" >&2; exit 1; }

# Setup loop device
LOOP_DEV=$(sudo losetup -f -P --show "$IMAGE_PATH")

# Create mount points
sudo mkdir -p /mnt
sudo mkdir -p /mnt/boot/efi

# Mount operations
sudo mount -o subvol=@ "${LOOP_DEV}p2" /mnt || {
    echo "ERROR: Failed to mount @ on ${LOOP_DEV}p2" >&2
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

sudo mount "${LOOP_DEV}p1" /mnt/boot/efi || {
    echo "ERROR: EFI mount failed on ${LOOP_DEV}p1" >&2
    sudo umount /mnt
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

# Bind mounts
sudo mount --bind /dev /mnt/dev
sudo mount --bind /proc /mnt/proc
sudo mount --bind /sys /mnt/sys
sudo mount --bind /run /mnt/run

echo "Successfully mounted $IMAGE_PATH"
