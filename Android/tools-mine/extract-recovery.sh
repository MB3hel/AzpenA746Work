#!/usr/bin/env bash

set -e

DIR=$(realpath $(dirname "$0"))

if [ $# -ne 2 ]; then
    echo "Usage: extract-recovery.sh image_file directory"
    exit 1
fi

DEST="$2"
SRC="$1"

if [ ! -f "$SRC" ]; then
    echo "Image file does not exist."
    exit 1
fi

rm -rf "$DEST"
mkdir -p "$DEST"
python3 $DIR/unpack_bootimg.py --boot_img "$SRC" --out "$DEST"

cd "$DEST"

# Unpack ramdisk
mkdir ramdisk_extracted
cd ramdisk_extracted
zcat ../ramdisk | cpio -idmv
cd ..

mv ramdisk ramdisk.orig
cd ..

cp "$DIR/pack-recovery.sh" "$DEST/pack-recovery.sh"
chmod +x "$DEST/pack-recovery.sh"

