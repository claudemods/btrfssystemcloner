
v1.04.2-v1.04.3 18-06-2025 

from further tests trying to get cachyos's handheld edition's system into a compressed btrfs system disk image e.g .img

evan with correct uuids in fstab and systemd-boot files it still will not boot after artwork

maybe theres files for steam that use uuids i will look and see but for now 

im stuck and cannot find a fix for cachyos handheld edition so im unable to compress the system from around 15gb to say 10gb

with 1 fault being an ongoing issue and the aim to support holoiso/steamos i will keep trying fedora/ubuntu/holoiso

whilst i search files and open source my ubuntu iso creator


v1.04.2 btrfssystemclonerc++

features in the new btrfssystemclonerc++ include:

support for drives  /dev/sdxx, /dev/nvme0n1xx, /dev/mmcblk0xx and added fstab generation

boot directory now gets dd over and then i simply just update the .confs with command e.g grub-mkconfig -o ......

set .img size by number e.g 11 = 11gb

setup for grub/systemd-boot grub works fine from last channges however systemd-boot is broken due to wrong uuids in /boot .confs

option to compression or not compress the .img

and the checksums will automatically generate for .img and .img.xz depending on the option given
