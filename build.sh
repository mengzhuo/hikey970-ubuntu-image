#!/bin/bash

set -ue

DISTRO=${DISTRO:-"bionic"}
GIT_VERSION=`git describe --tags`
VERSION=${VERSION:-$GIT_VERSION}
echo "Version:" $VERSION

REQUIRED="qemu-debootstrap img2simg mkfs.ext4"
MIRRORS=${MIRRORS:-}
SOFTWARE=${SOFTWARE:-"ssh,zsh,tmux,linux-firmware,vim-nox,net-tools,network-manager"}

echo "Fetch from... " $MIRRORS
echo "Install... " $SOFTWARE

echo "Dependency check"
for i in $REQUIRED; do
	command -v $i >/dev/null 2>&1 || { echo >&2 "require $i but it's not installed.  Aborting."; exit 1; }
	echo "[$i ... OK]"
done

echo "Clean tmp"
rm -rf build
mkdir build

qemu-debootstrap --arch arm64 --include=$SOFTWARE --components=main,multiverse,universe $DISTRO build/rootfs $MIRRORS

cp -r rootfs/boot/* build/rootfs/boot/
cp -r rootfs/etc/netplan/* build/rootfs/etc/netplan/
cp -r rootfs/etc/update-motd.d/* build/rootfs/etc/update-motd.d/
cp -r rootfs/root/init.sh build/rootfs/root/

echo "Initial system"
chroot build/rootfs /root/init.sh

dd if=/dev/zero of=build/rootfs.img bs=1M count=4096
mkfs.ext4 -F -L rootfs build/rootfs.img

mkdir build/loop
mount -o loop build/rootfs.img build/loop

echo "Copying root"
(cd build/rootfs;tar -cf - *) | tar -xf - -C build/loop

echo "Umount"
umount build/loop

echo "Building sparse"
img2simg build/rootfs.img build/ubuntu_$DISTRO.hikey970.$VERSION.sparse.img

echo "ALL COMPLETE"
ls -lha build/ubuntu_$DISTRO.hikey970.$VERSION.sparse.img
exit 0
