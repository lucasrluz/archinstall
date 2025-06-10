#!/bin/bash

# Teclado em português
loadkeys br-abnt2

# Layout do disco
DISCO="/dev/sda" 
parted -s "$DISCO" mklabel gpt

parted -s "$DISCO" mkpart ESP fat32 1MiB 501MiB
parted -s "$DISCO" set 1 esp on

parted -s "$DISCO" mkpart primary linux-swap 501MiB 4550MiB

parted -s "$DISCO" mkpart primary 4550MiB 100%

# Formatação das partições
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3

# Montagem do sistema de arquivo
mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi

mount /dev/sda1 /mnt/boot/efi

swapon /dev/sda2

# Instalação do sistema
pacstrap -K /mnt base linux linux-firmware

# Fstab
genfstab -U /mnt >> mnt/etc/fstab

# chroot
arch-chroot /mnt bash -c ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
arch-chroot /mnt bash -c locale-gen
arch-chroot /mnt bash -c echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
arch-chroot /mnt bash -c echo "archlinux" > /etc/hostname
arch-chroot /mnt bash -c echo "root" | passwd -s

# chroot > grub
arch-chroot /mnt bash -c pacman -S grub efibootmgr
arch-chroot /mnt bash -c grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
arch-chroot /mnt bash -c grub-mkconfig -o /boot/grub/grub.cfg



















