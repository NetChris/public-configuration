#!/bin/bash

# Usage: raspbian-image-mount.sh <image-filename> <W95|Linux>
# W95 = Boot Partition / Linux = Root Partition
# 2019-01-05 - Taken from:
# https://www.raspberrypi.org/forums/viewtopic.php?p=1192933#p1192933
# For full documentation, see:
# https://gitlab.com/NetChris/public/configuration/wikis/bash/utility/raspbian-image-mount.sh

IMG="$1"
PART="$2"
MNT="/mnt/$PART"

INFO="$(fdisk -lu "${IMG}")"
START="$(grep "${PART}" <<< "${INFO}" | awk '{print $2}')"
SIZE="$(grep "${PART}" <<< "${INFO}" | awk '{print $4}')"
LOOP="$(losetup -f --show -o $((${START} * 512)) --sizelimit $((${SIZE} * 512)) "${IMG}")"
mkdir -p $MNT
mount "${LOOP}" $MNT
echo ""
echo "${IMG} mounted on $MNT"
echo ""
echo "When done, run:"
echo "umount $MNT"
echo "losetup -d ${LOOP}"
echo ""
