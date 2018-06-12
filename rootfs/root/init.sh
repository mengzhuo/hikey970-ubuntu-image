#!/bin/bash

set -ue

useradd -g sudo -m -s /bin/zsh hi
echo hi:hikey970 | chpasswd
echo "#made by mzh" >> /home/hi/.zshrc

passwd -d root

echo "clean the house"
rm -rf /debootstrap
apt autoclean

echo "make sure I don't have ssh keys"
rm -f /etc/ssh/ssh_host_*

echo "hikey970" > /etc/hostname
echo "hikey970 127.0.0.1" >> /etc/hosts

echo "self destroy, bye bye"
rm /root/init.sh
