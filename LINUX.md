# Azpen A746 Linux


## Kernel & u-boot Information

There are three types of setups you might have on an Allwinner sunxi device

- Allwinner SDK (lichee) kernel (3.4) & u-boot: This u-boot uses the boot0 binary and some other nonsense. I can't find much about it, but that seems to be what stock android uses here.
- Linux-Sunxi Kernel (3.4) and u-boot: Kernel based on Allwinner sources for A10 / A13 (I think). Does not support A33. Same for the legacy u-boot-sunxi. No A33 support and not worth trying to add. Could probalby be done, but dram handling for sun8i devices (such as A33) isn't implemented and that would be a lot of work for a legacy project.
- Mainline u-boot and kernel: Just like it sounds. Most things should be supported on this device. Possibly not graphics acceleration or GPU accelerated decoding / encoding.

The mainline u-boot is really the most viable option. The mainline kernel is probably more useful than the old allwinner kernel (3.4) too. I don't think the linux-sunxi 3.4 kernel supports the A33. Thus, focus is on mainline for now.


## Mainline Kernel & u-boot

### Device Tree Creation

Will skip for now and try using the generic a33 q8 tablet device tree. This seems to work well enough for a wide range of a33 tablets. Hopefully it will provide basic functionality for this tablet.


### Building u-boot

*Tested on Ubuntu 22.04 LTS (amd64)*

```sh
# Install required tools
sudo apt install swig python3-dev device-tree-compiler gcc-arm-linux-gnueabihf

# Get u-boot source
git clone git://git.denx.de/u-boot.git
cd u-boot
git checkout v2023.04

# Built u-boot (armhf)
make CROSS_COMPILE=arm-linux-gnueabihf- q8_a33_tablet_1024x600_defconfig
make CROSS_COMPILE=arm-linux-gnueabihf-
```

The resultant file of interest is `u-boot-sunxi-with-spl.bin`


### Building kernel

```sh
wget https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-6.3.tar.gz
tar --extract --gzip -f linux-6.3.tar.gz
cd linux-6.3

# Make directory for resultant files
mkdir ../linux-6.3-out/

# Configure
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- sunxi_defconfig
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig

# Kernel
ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4 zImage
cp arch/arm/boot/zImage ../linux-6.3-out/

# Device tree files
ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4 dtbs
cp arch/arm/boot/dts/sun8i-a33-q8-tablet.dtb ../linux-6.3-out
cp arch/arm/boot/dts/sun8i-a33-q8-tablet.dts ../linux-6.3-out

# Modules
ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j4 modules
ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=../linux-6.3-out/ make modules modules_install

# Headers
make INSTALL_HDR_PATH=../linux-6.3-out/ ARCH=arm headers_install
```

The resulting files will be in the `linux-6.3-out` directory.


### Building SD Card

*Note: the SD card is assumed to be `/dev/mmcblk0` in the following instructions. Change as needed.*

Clean the sd card (this will also destroy partition table).

```sh
# Make sure all partitions of the card are unmounted before running this command
sudo dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=1
```

Make a partition table on the card

```sh
sudo parted /dev/mmcblk0 mktable msdos
```

Create and format partitions:

- One "boot" partition (16MB, FAT16)
- One "root" partition (rest of card, ext4)

```sh
sudo parted /dev/mmcblk0 mkpart primary fat16 1MiB 17MiB
sudo parted /dev/mmcblk0 mkpart primary ext4 17MiB 100%

sudo mkfs.vfat /dev/mmcblk0p1
sudo mkfs.ext4 /dev/mmcblk0p2
```

Install bootloader to card

```sh
sudo dd if=u-boot/u-boot-sunxi-with-spl.bin of=/dev/mmcblk0 bs=1024 seek=8
```

Setup boot partition

```sh
# Mount boot partition
sudo mkdir /mnt/boot
sudo mount /dev/mmcblk0p1 /mnt/boot

# Copy required files
# Note: dts file is optional, just for end users to reference sources for the dtb file)
sudo cp linux-6.3-out/sun8i-a33-q8-tablet.dtb /mnt/boot/
sudo cp linux-6.3-out/sun8i-a33-q8-tablet.dts /mnt/boot/
sudo cp linux-6.3-out/zImage /mnt/boot/
```

Make boot script (`/mnt/boot/boot.cmd`)

```
fatload mmc 0 0x46000000 zImage
fatload mmc 0 0x49000000 sun8i-a33-q8-tablet.dtb

setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rootwait panic=10 ${extra}

bootz 0x46000000 - 0x49000000
```

*Note: the sd card seems to USUALLY be detected as `/dev/mmcblk1` on this board. Sometimes though, boot will fail because it is detected as `/dev/mmcblk0`.*

Compile boot script

```sh
sudo mkimage -C none -A arm -T script -d /mnt/boot/boot.cmd /mnt/boot/boot.scr
```

Umount the boot partition

```sh
sudo umount /mnt/boot
```

Finally, setup a rootfs (debian 11 via debootstrap used here). First, mount the root partition

```sh
sudo mkdir /mnt/root
sudo mount /dev/mmcblk0p2 /mnt/root
```

Then, run debootstrap to create the rootfs

```sh
sudo debootstrap --arch=armhf bullseye /mnt/root
```

Make sure to set a password for the `root` user in the new rootfs. This requires chrooting to the system. On an non-arm system this requires `qemu-user-static` package.

```sh
sudo chroot /mnt/root

# Now in chroot environment
passwd
# Set root password when prompted

# Leave chroot environment
exit
```

Finally, unmount the root partition and hope the card actually boots on the device.

```sh
sudo umount /mnt/root
```


This boots successfully on the device!


## Current Status

**Working:**

- Device boots from SD card
- Poweroff and reboot commands


**Not Working:**

- WiFi
- NAND
- Power button


**Unknown:**

- Power management
- LCD
- Camera
- Microphone
- Speaker
- 3.5mm audio jack
- USB OTG host
- Volume keys
- LCD backlight
