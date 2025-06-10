#!/bin/bash

DISCO="/dev/sda" 
parted -s "$DISCO" mklabel gpt
parted -s "$DISCO" mkpart ESP fat32 1MiB 501MiB
parted -s "$DISCO" set 1 esp on
parted -s "$DISCO" mkpart primary 501MiB 100%
