### Hikey970 Ubuntu Image

This is a Ubuntu system image for Hikey970 SBC ONLY

#### Usage

```
fastboot flash system ubuntu_*.sparse.img
```

Login

```
username: hi
password: key970
```

Expend disk (no reboot required)

```
$ resize2fs /dev/sdd12 # max usage of disk
```
