#!/usr/bin/env bash

# Update the distro

sudo pacman -Syuu --noconfirm

# Install docker

sudo pacman -S docker --noconfirm

# Docker needs loop module

echo loop > /etc/modules-load.d/loop.conf
modprobe loop

# Allow vagrant to run docker

usermod -G docker vagrant

# Enable docker
systemctl enable docker

# Install packer

PKGBUILD_URL=https://raw.githubusercontent.com/nhz-io/PKGBUILD/hashicorp-packer-bin/hashicorp-packer/PKGBUILD

sudo -u vagrant bash<<_
mkdir hashicorp-packer-bin
cd hashicorp-packer-bin
curl $PKGBUILD_URL -o PKGBUILD
makepkg -i --noconfirm
cd ..
rm -rf hashicorp-packer-bin
_