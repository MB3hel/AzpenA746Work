#!/usr/bin/env bash

if [ $# -ne 1 ]; then
    echo "Usage: pack-recovery.sh image_file"
    exit 1
fi

if [ ! -f kernel ]; then
    echo "kernel not found"
    exit 1
fi

# Pack ramdisk
cd ramdisk_extracted
find . | cpio -o -c -R root:root | gzip -9 > ../ramdisk
cd ..


# Make image
mkbootimg -o "$1" --kernel kernel --ramdisk ramdisk

