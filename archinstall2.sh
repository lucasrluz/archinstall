#!/bin/bash

# chroot
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
locale-gen
echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
echo "archlinux" > /etc/hostname

# chroot > grub
pacman -S grub efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
