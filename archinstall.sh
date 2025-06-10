#!/bin/bash

loadkeys br-abnt2

DISCO="/dev/sda" 
parted -s "$DISCO" mklabel gpt

parted -s "$DISCO" mkpart ESP fat32 1MiB 501MiB
parted -s "$DISCO" set 1 esp on

parted -s "$DISCO" mkpart primary linux-swap 501MiB 4550MiB

parted -s "$DISCO" mkpart primary 4550MiB 100%

mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi

mount /dev/sda1 /mnt/boot/efi

swapon /dev/sda2
