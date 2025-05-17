#!/bin/bash
set -euo pipefail

# Get image path
read -e -p "Enter path to .img file: " IMAGE_PATH
[ ! -f "$IMAGE_PATH" ] && { echo "Error: Image not found!" >&2; exit 1; }

# Setup loop device
LOOP_DEV=$(sudo losetup -f -P --show "$IMAGE_PATH")

# Create mount points (EXACTLY as you want them)
sudo mkdir -p /mnt/root
sudo mkdir -p /mnt/root/boot/efi

# Mount operations (EXACTLY as you specified)
sudo mount -o subvol=@root "${LOOP_DEV}p2" /mnt/root || {
    echo "FUCKING ERROR: Failed to mount @root on ${LOOP_DEV}p2" >&2
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

sudo mount "${LOOP_DEV}p1" /mnt/root/boot/efi || {
    echo "FUCKING ERROR: EFI mount failed on ${LOOP_DEV}p1" >&2
    sudo umount /mnt/root
    sudo losetup -d "$LOOP_DEV"
    exit 1
}

# Bind mounts (ALL of them)
sudo mount --bind /dev /mnt/root/dev
sudo mount --bind /proc /mnt/root/proc
sudo mount --bind /sys /mnt/root/sys
sudo mount --bind /run /mnt/root/run

# Chroot operations (EXACTLY as you want)
sudo chroot /mnt/root /bin/bash -c "
    # Check mounts are there
    if ! mountpoint -q /boot/efi; then
        echo 'ERROR: /boot/efi not mounted' >&2
        exit 1
    fi

    # Install GRUB properly
    grub-install \
        --target=x86_64-efi \
        --efi-directory=/boot/efi \
        --bootloader-id=GRUB \
        --recheck || {
            echo 'ERROR: grub-install failed' >&2
            exit 1
        }

    # Add UEFI boot entry
    if command -v efibootmgr >/dev/null; then
        efibootmgr --create \
            --disk ${LOOP_DEV} \
            --part 1 \
            --loader /EFI/GRUB/grubx64.efi \
            --label 'GRUB' \
            --bootnum || echo 'WARNING: efibootmgr failed' >&2
    fi

    # Generate config
    grub-mkconfig -o /boot/grub/grub.cfg || {
        echo 'ERROR: grub-mkconfig failed' >&2
        exit 1
    }

    # Rebuild initramfs
    mkinitcpio -P || {
        echo 'ERROR: mkinitcpio failed' >&2
        exit 1
    }
"

# Cleanup (but leave mounts if you want)
echo "Unmounting everything..."
sudo umount -R /mnt/root
sudo losetup -d "$LOOP_DEV"

echo "DONE. GRUB installed successfully to ${IMAGE_PATH}"
