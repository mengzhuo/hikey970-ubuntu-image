#!/bin/bash

set -ue

useradd -g sudo -m -s /bin/zsh hi
echo hi:hikey970 | chpasswd
echo "#made by mzh" >> /home/hi/.zshrc

passwd -d root

echo "clean the house"
rm -rf /debootstrap
apt clean
apt autoclean

echo "make sure I don't have ssh keys"
rm -f /etc/ssh/ssh_host_*

echo "hikey970" > /etc/hostname
echo "127.0.0.1 hikey970" >> /etc/hosts

echo "making initramfs"
cp /root/initramfs-hooks/resize2fs /usr/share/initramfs-tools/hooks/ 
mkinitramfs -o "/boot/initramfs-v4.9"

echo "self destroy, bye bye"
rm /root/init.sh
