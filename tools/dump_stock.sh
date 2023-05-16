#!/bin/sh
# adb push dump_stock.sh /data/local/tmp
# adb shell (or run in terminal app on tablet)
#   su
#   cd /data/local/tmp
#   sh dump_stock.sh


echo "nanda"; dd if=/dev/block/nanda | gzip > /mnt/extsd/nanda.img.gz; echo ""
echo "nandb"; dd if=/dev/block/nandb | gzip > /mnt/extsd/nandb.img.gz; echo ""
echo "nandc"; dd if=/dev/block/nandc | gzip > /mnt/extsd/nandc.img.gz; echo ""
echo "nandd"; dd if=/dev/block/nandd | gzip > /mnt/extsd/nandd.img.gz; echo ""
echo "nande"; dd if=/dev/block/nande | gzip > /mnt/extsd/nande.img.gz; echo ""
echo "nandf"; dd if=/dev/block/nandf | gzip > /mnt/extsd/nandf.img.gz; echo ""
echo "nandg"; dd if=/dev/block/nandg | gzip > /mnt/extsd/nandg.img.gz; echo ""
echo "nandh"; dd if=/dev/block/nandh | gzip > /mnt/extsd/nandh.img.gz; echo ""
echo "nandi"; dd if=/dev/block/nandi | gzip > /mnt/extsd/nandi.img.gz; echo ""
echo "nandj"; dd if=/dev/block/nandj | gzip > /mnt/extsd/nandj.img.gz; echo ""

