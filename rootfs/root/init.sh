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

cat >> /etc/group << EOF
aid_inet:x:3003:root,systemd-resolve,_apt,systemd-network,systemd-timesync     
aid_net_raw:x:3004:root,systemd-resolve,_apt,systemd-network,systemd-timesync  
aid_net_admin:x:3005:root,systemd-resolve,_apt,systemd-network,systemd-timesync
EOF


echo "self destroy, bye bye"
rm /root/init.sh
