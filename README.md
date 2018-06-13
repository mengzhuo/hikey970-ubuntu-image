# Hikey970 Ubuntu Image

This is a Ubuntu system image for Hikey970 SBC ONLY

## Download
[Release Page](https://github.com/mengzhuo/hikey970-ubuntu-image/releases)

## Usage

```
fastboot flash system ubuntu_*.sparse.img
```

Login

```
username: hi
password: hikey970
```

Expend disk (no reboot required)

```
$ resize2fs /dev/sdd12 # max usage of disk
```

## Build from source

Install required

```
apt install android-tools-fsutils qemu-user-static debootstrap
```

```
git clone https://github.com/mengzhuo/hikey970-ubuntu-image
cd hikey970-ubuntu-image
./build.sh

```
