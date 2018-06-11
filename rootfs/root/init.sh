#!/bin/bash

set -ue

useradd -g sudo -m -s /bin/zsh hi
echo hi:key970 | chpasswd
echo "#made by mzh" >> /home/hi/.zshrc

passwd -d root

echo "clean the house"
rm -rf /debootstrap
apt autoclean

echo "make sure I don't have ssh keys"
rm -f /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

echo "key970" > /etc/hostname
echo "key970" >> /etc/hosts

echo "self destroy, bye bye"
rm /root/init.sh
