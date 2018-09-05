#!/bin/bash

set -ue
echo "Delete partition 13/14/15/16 and resize system"
echo "swap on /dev/sdd5 and write to fstab"
read -r -p "Are you sure? [Y/N]" response
response=${response,,}
if [[ $response =~ ^(no|n| ) ]] || [[ -z $response ]]; then
	exit 0
fi
echo "removing 13/14/15"
parted -s /dev/sdd rm 13 || true
parted -s /dev/sdd rm 14 || true
parted -s /dev/sdd rm 15 || true
parted -s /dev/sdd rm 16 || true

parted -s /dev/sdd resizepart 12 "100%"
mkswap /dev/sdd5
swapon /dev/sdd5

cat << EOF > /etc/fstab
/dev/sdd12 / ext4 defaults 0 1
/dev/sdd5 none swap defaults 0 0
EOF

echo "OK, all done, you might need to reboot"
