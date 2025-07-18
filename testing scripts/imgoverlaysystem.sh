#!/bin/bash
set -euo pipefail

# Hardcoded image path
IMAGE_PATH="/path/to/your/specific/image.img"

# Verify image exists
[ ! -f "$IMAGE_PATH" ] && { echo "Error: Image not found at $IMAGE_PATH!" >&2; exit 1; }

# Setup loop device
LOOP_DEV=$(sudo losetup -f -P --show "$IMAGE_PATH")

# Create mount points
sudo mkdir -p /mnt/primary
sudo mkdir -p /mnt/primary/boot/efi

# Mount operations
sudo mount -o subvol=@ "${LOOP_DEV}p2" /mnt/primary || {
    echo "ERROR: Failed to mount @ on ${LOOP_DEV}p2" >&2
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

sudo mount -o subvol=@home "${LOOP_DEV}p2" /mnt/primary || {
    echo "ERROR: Failed to mount @ on ${LOOP_DEV}p2" >&2
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

sudo mount -o subvol=@root "${LOOP_DEV}p2" /mnt/primary || {
    echo "ERROR: Failed to mount @ on ${LOOP_DEV}p2" >&2
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

sudo mount "${LOOP_DEV}p1" /mnt/primary/boot/efi || {
    echo "ERROR: EFI mount failed on ${LOOP_DEV}p1" >&2
    sudo umount /mnt/primary
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

# Bind mounts (ALL of them)
sudo mount --bind /dev /mnt/primary/dev
sudo mount --bind /proc /mnt/primary/proc
sudo mount --bind /sys /mnt/primary/sys
sudo mount --bind /run /mnt/primary/run
sudo mount --bind /dev/pts /mnt/primary/dev/pts

# Create a symlink in your home directory instead of root
ln -s /mnt/primary /
