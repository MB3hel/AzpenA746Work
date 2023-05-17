# Azpen A746 Linux


## Kernel & u-boot Information

- The A33 is not supported in `u-boot-sunxi` or the `linux-sunxi` 3.4 kernel ([source](https://linux-sunxi.org/A33#Overview))
- Mainline kernel would require a device tree
- The stock android OS is built using Allwinner lichee kernel (3.4), thus it uses no device tree (uses `script.bin` -> `script.fex`)
- Stock u-boot is of unknown origin (possibly something from `lichee` tarball from A33 Android SDK)

<br />

- Adding support to `u-boot-sunxi` and `linux-sunxi` could be done (may be less work than making a device tree), but is not really worth the time for legacy stuff.
- Thus, really the first step for this device is a working device tree.


## Allwinner SDK (lichee) Kernel & u-boot

### Build Environment

The Allwinner kernel does not build on Ubuntu 14.04 and newer, but builds on Ubuntu 12.04. Thus, setup a chroot

```sh
# Setup chroot
sudo apt install schroot
sudo debootstrap --keyring=/usr/share/keyrings/ubuntu-archive-removed-keys.gpg --arch=amd64 precise /srv/chroot/precise-amd64
cat << EOF | sudo tee /etc/schroot/chroot.d/precise-amd64.conf
[precise-amd64]
description=Ubuntu 12.04 (amd64)
type=directory
directory=/srv/chroot/precise-amd64
users=$(whoami)
root-groups=root
profile=desktop
personality=linux
EOF
sudo schroot -c precise-amd64

# Now in chroot
apt-get install -y sudo
exit

# Now out of chroot
schroot -c precise-amd64

# Now in chroot as your user. sudo will work
# If sudo does not work see https://www.debian.org/releases/stable/armel/release-notes/ch-information.en.html#pam-default-password and change yescrypt to sha512 in the indicated file
```

All future commands will be run in this chroot unless otherwise specified.


```sh
# Extract lichee.tar.gz (IN A PATH WITH NO SPACES!!!)
tar zxvf lichee.tar.gz

# Add the extracted fex for this device
mkdir tools/pack/chips/sun8iw5p1/configs/along6051
cp /path/to/stock_android/script.fex tools/pack/chips/sun8iw5p1/configs/along6051/sys_config.fex

# Configure. Choose the following options
# Chip: 
#     0. sun8iw5p1
# Platform: 
#     2.linux
# Kernel:
#     0. linux-3.4
# Board
#     0. along6051
./build.sh config


# Fix build
mkdir linux-3.4/modules/mali/DX910-SW-99002-r4p0-00rel0/driver/src/devicedrv/ump/arch-ca8-virtex820-m400-1
cp ./linux-3.4/modules/mali/DX910-SW-99002-r3p2-01rel1/driver/src/devicedrv/ump/arch-ca8-virtex820-m400-1/config.h linux-3.4/modules/mali/DX910-SW-99002-r4p0-00rel0/driver/src/devicedrv/ump/arch-ca8-virtex820-m400-1/
sed -i 's/\$(CC) -Wall -Werror/\$(CC) -Wall/g' buildroot/package/makedevs/makedevs.mk

# Run the build
./build.sh
```

You will be prompted at some point for which kernel modules to build / configuration for kernel modules. Some prompts will be auto answered by the build script. Answer the ones that are not as shown below

```
*
* Restart config...
*
*
* softwinner 3G module driver
*
softwinner 3G module driver (SW_3G_MODULE) [N/m/y/?] (NEW) N
*
* AXP Power drivers
*
AXP Power drivers (AW_AXP) [Y/n/?] y
  AXP81X driver (AW_AXP81X) [N/y/?] (NEW) N
  AXP19 driver (AW_AXP19) [N/y/?] (NEW) N
  AXP15 driver (AW_AXP15) [N/y/?] n
  AXP initial charging environment set (AXP_CHARGEINIT) [Y/n] y
  AXP charging current set when suspendresumeshutdown (AXP_CHGCHANGE) [Y/n] y
  AXP use twi as transfer channel (AXP_TWI_USED) [N/y] n
*
* Hardware Monitoring support
*
Hardware Monitoring support (HWMON) [Y/n/m/?] y
  Hardware Monitoring Chip debugging messages (HWMON_DEBUG_CHIP) [N/y/?] n
  *
  * Native drivers
  *
  KIONIX KXTJ9 12bit 3-Axis Orientation/Motion Detection Sensor Support (SENSORS_KIONIX) [N/m/y/?] n
  MMA7660 3-Axis Orientation/Motion Detection Sensor Support (SENSORS_MMA7660) [N/m/y/?] n
  MMA865x 3-Axis Orientation/Motion Detection Sensor Support (SENSORS_MMA865x) [N/m/y/?] n
  MMA8452 3-Axis Orientation/Motion Detection Sensor Support (SENSORS_MMA8452) [N/m/y/?] n
  AFA750 3-Axis acceleration sensor support (SENSORS_AFA750) [N/m/y/?] n
  BMA250 acceleration sensor support (SENSORS_BMA250) [N/m/y/?] n
  STK831X acceleration sensor support (SENSORS_STK831X) [N/m/y/?] (NEW) n
  MXC622X acceleration sensor support (SENSORS_MXC622X) [N/m/y/?] (NEW) n
  DMARD10 acceleration sensor support (SENSORS_DMARD10) [N/m/y/?] (NEW) n
  MC320X acceleration sensor support (SENSORS_MC32X0) [N/m/y/?] (NEW) n
  LIS3DH acceleration sensor support (SENSORS_LIS3DH_ACC) [N/m/y/?] n
  LIS3DE acceleration sensor support (SENSORS_LIS3DE_ACC) [N/m/y/?] n
  Analog Devices AD7314 and compatibles (SENSORS_AD7314) [N/m/y/?] n
  Analog Devices AD7414 (SENSORS_AD7414) [N/m/y/?] n
  Analog Devices AD7416, AD7417 and AD7418 (SENSORS_AD7418) [N/m/y/?] n
  National Semiconductor ADCxxxSxxx (SENSORS_ADCXX) [N/m/y/?] n
  Analog Devices ADM1021 and compatibles (SENSORS_ADM1021) [N/m/y/?] n
  Analog Devices ADM1025 and compatibles (SENSORS_ADM1025) [N/m/y/?] n
  Analog Devices ADM1026 and compatibles (SENSORS_ADM1026) [N/m/y/?] n
  Analog Devices ADM1029 (SENSORS_ADM1029) [N/m/y/?] n
  Analog Devices ADM1031 and compatibles (SENSORS_ADM1031) [N/m/y/?] n
  Analog Devices ADM9240 and compatibles (SENSORS_ADM9240) [N/m/y/?] n
  Analog Devices ADT7411 (SENSORS_ADT7411) [N/m/y/?] n
  Analog Devices ADT7462 (SENSORS_ADT7462) [N/m/y/?] n
  Analog Devices ADT7470 (SENSORS_ADT7470) [N/m/y/?] n
  Analog Devices ADT7473, ADT7475, ADT7476 and ADT7490 (SENSORS_ADT7475) [N/m/y/?] n
  Andigilog aSC7621 (SENSORS_ASC7621) [N/m/y/?] n
  Attansic ATXP1 VID controller (SENSORS_ATXP1) [N/m/y/?] n
  Dallas Semiconductor DS620 (SENSORS_DS620) [N/m/y/?] n
  Dallas Semiconductor DS1621 and DS1625 (SENSORS_DS1621) [N/m/y/?] n
  Fintek F71805F/FG, F71806F/FG and F71872F/FG (SENSORS_F71805F) [N/m/y/?] n
  Fintek F71882FG and compatibles (SENSORS_F71882FG) [N/m/y/?] n
  Fintek F75375S/SP, F75373 and F75387 (SENSORS_F75375S) [N/m/y/?] n
  GMT G760A (SENSORS_G760A) [N/m/y/?] n
  Genesys Logic GL518SM (SENSORS_GL518SM) [N/m/y/?] n
  Genesys Logic GL520SM (SENSORS_GL520SM) [N/m/y/?] n
  GPIO fan (SENSORS_GPIO_FAN) [N/m/y/?] n
  ITE IT87xx and compatibles (SENSORS_IT87) [N/m/y/?] n
  JEDEC JC42.4 compliant memory module temperature sensors (SENSORS_JC42) [N/m/y/?] n
  Lineage Compact Power Line Power Entry Module (SENSORS_LINEAGE) [N/m/y/?] n
  National Semiconductor LM63 and compatibles (SENSORS_LM63) [N/m/y/?] n
  National Semiconductor LM70 / Texas Instruments TMP121 (SENSORS_LM70) [N/m/y/?] n
  National Semiconductor LM73 (SENSORS_LM73) [N/m/y/?] n
  National Semiconductor LM75 and compatibles (SENSORS_LM75) [N/m/y/?] n
  National Semiconductor LM77 (SENSORS_LM77) [N/m/y/?] n
  National Semiconductor LM78 and compatibles (SENSORS_LM78) [N/m/y/?] n
  National Semiconductor LM80 and LM96080 (SENSORS_LM80) [N/m/y/?] n
  National Semiconductor LM83 and compatibles (SENSORS_LM83) [N/m/y/?] n
  National Semiconductor LM85 and compatibles (SENSORS_LM85) [N/m/y/?] n
  National Semiconductor LM87 and compatibles (SENSORS_LM87) [N/m/y/?] n
  National Semiconductor LM90 and compatibles (SENSORS_LM90) [N/m/y/?] n
  National Semiconductor LM92 and compatibles (SENSORS_LM92) [N/m/y/?] n
  National Semiconductor LM93 and compatibles (SENSORS_LM93) [N/m/y/?] n
  Linear Technology LTC4151 (SENSORS_LTC4151) [N/m/y/?] n
  Linear Technology LTC4215 (SENSORS_LTC4215) [N/m/y/?] n
  Linear Technology LTC4245 (SENSORS_LTC4245) [N/m/y/?] n
  Linear Technology LTC4261 (SENSORS_LTC4261) [N/m/y/?] n
  National Semiconductor LM95241 and compatibles (SENSORS_LM95241) [N/m/y/?] n
  National Semiconductor LM95245 sensor chip (SENSORS_LM95245) [N/m/y/?] n
  Maxim MAX1111 Multichannel, Serial 8-bit ADC chip (SENSORS_MAX1111) [N/m/y/?] n
  Maxim MAX16065 System Manager and compatibles (SENSORS_MAX16065) [N/m/y/?] n
  Maxim MAX1619 sensor chip (SENSORS_MAX1619) [N/m/y/?] n
  Maxim MAX1668 and compatibles (SENSORS_MAX1668) [N/m/y/?] n
  Maxim MAX6639 sensor chip (SENSORS_MAX6639) [N/m/y/?] n
  Maxim MAX6642 sensor chip (SENSORS_MAX6642) [N/m/y/?] n
  Maxim MAX6650 sensor chip (SENSORS_MAX6650) [N/m/y/?] n
  Microchip MCP3021 (SENSORS_MCP3021) [N/m/y/?] n
  NTC thermistor support (SENSORS_NTC_THERMISTOR) [N/m/y/?] n
  National Semiconductor PC87360 family (SENSORS_PC87360) [N/m/y/?] n
  National Semiconductor PC87427 (SENSORS_PC87427) [N/m/y/?] n
  Philips PCF8591 ADC/DAC (SENSORS_PCF8591) [N/m/y/?] n
  Sensiron humidity and temperature sensors. SHT15 and compat. (SENSORS_SHT15) [N/m/y/?] n
  Sensiron humidity and temperature sensors. SHT21 and compat. (SENSORS_SHT21) [N/m/y/?] n
  Summit Microelectronics SMM665 (SENSORS_SMM665) [N/m/y/?] n
  SMSC DME1737, SCH311x and compatibles (SENSORS_DME1737) [N/m/y/?] n
  SMSC EMC1403/23 thermal sensor (SENSORS_EMC1403) [N/m/y/?] n
  SMSC EMC2103 (SENSORS_EMC2103) [N/m/y/?] n
  SMSC EMC6W201 (SENSORS_EMC6W201) [N/m/y/?] n
  SMSC LPC47M10x and compatibles (SENSORS_SMSC47M1) [N/m/y/?] n
  SMSC LPC47M192 and compatibles (SENSORS_SMSC47M192) [N/m/y/?] n
  SMSC LPC47B397-NC (SENSORS_SMSC47B397) [N/m/y/?] n
  SMSC SCH5627 (SENSORS_SCH5627) [N/m/y/?] n
  SMSC SCH5636 (SENSORS_SCH5636) [N/m/y/?] n
  Texas Instruments ADS1015 (SENSORS_ADS1015) [N/m/y/?] n
  Texas Instruments ADS7828 (SENSORS_ADS7828) [N/m/y/?] n
  Texas Instruments ADS7871 A/D converter (SENSORS_ADS7871) [N/m/y/?] n
  Texas Instruments AMC6821 (SENSORS_AMC6821) [N/m/y/?] n
  Texas Instruments THMC50 / Analog Devices ADM1022 (SENSORS_THMC50) [N/m/y/?] n
  Texas Instruments TMP102 (SENSORS_TMP102) [N/m/y/?] n
  Texas Instruments TMP401 and compatibles (SENSORS_TMP401) [N/m/y/?] n
  Texas Instruments TMP421 and compatible (SENSORS_TMP421) [N/m/y/?] n
  VIA VT1211 (SENSORS_VT1211) [N/m/y/?] n
  Winbond W83781D, W83782D, W83783S, Asus AS99127F (SENSORS_W83781D) [N/m/y/?] n
  Winbond W83791D (SENSORS_W83791D) [N/m/y/?] n
  Winbond W83792D (SENSORS_W83792D) [N/m/y/?] n
  Winbond W83793 (SENSORS_W83793) [N/m/y/?] n
  Winbond/Nuvoton W83795G/ADG (SENSORS_W83795) [N/m/y/?] n
  Winbond W83L785TS-S (SENSORS_W83L785TS) [N/m/y/?] n
  Winbond W83L786NG, W83L786NR (SENSORS_W83L786NG) [N/m/y/?] n
  Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF (SENSORS_W83627HF) [N/m/y/?] n
  Winbond W83627EHF/EHG/DHG/UHG, W83667HG, NCT6775F, NCT6776F (SENSORS_W83627EHF) [N/m/y/?] n
  *
  * INA219 drivers
  *
  ina219 power measurer (SENSORS_INA219) [N/m/y/?] n
*
* Ion Memory Manager
*
Ion Memory Manager (ION) [Y/n/m/?] y
  ion for sunxi (ION_SUNXI) [Y/n/?] y
    ion override for sunxi (ION_SUNXI_CARVEOUT_OVERRIDE) [N/y/?] (NEW) n
    memory size(in MB) for sunxi carveout ion heap. (ION_SUNXI_CARVEOUT_SIZE) [128] 128
    memory size(in MB) for sunxi carveout ion heap of 512M devices. (ION_SUNXI_CARVEOUT_SIZE_512M) [80] (NEW) 80
#
# configuration written to .config
#
```

After the build finishes, it will have generated the following in `out/sun8iw5p1/linux/common/`

- `arisc`: No idea what this is
- `boot.img`: This is an android `boot.img` for some reason.
- `rootfs.ext4`: Linux root filesystem (not actually ext4, but ext2)
- `vmlinux.tar.bz2`: Linux kernel (tar bz2 compressed)
- `buildroot/target/lib/modules/3.4.39/*.ko`: Kernel modules. These are already copied to the generated `rootfs.ext4` file

Then, you can hypothetically pack a LiveSuite image using

```sh
sudo apt-get install busybox-static
./build.sh pack
```

Image will be at `sun8iw5p1_linux_along6051.img`. But, this image is not right (missing partition file in my config probably).


However in `tools/pack/out` there are several useful files. Lots of various `.fex` files (these seem to be some form of binary, not what fex means in other contexts)

- `boot0_sdcard.fex` is boot0 image patched with compiled `sys_config.fex`. This can be written to SD card.
- `boot0_nand.fex` is same thing, but for nand. Can write to tablet using FEL.
- `u-boot.fex` Patched u-boot
- Various other files I will ignore for now

This can be written to an SD card

```sh
# Erase SD card first
sudo dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=1

# Write boot0 and u-boot
sudo dd if=boot0_sdcard.fex of=/dev/mmcblk0 bs=1k seek=8
sudo dd if=u-boot.fex of=/dev/mmcblk0 bs=1k seek=19096
```

Then, create a boot partition (FAT16 or 32) and root partition (ext4) on the SD card. **THE FIRST PARTITION MUST BE THE BOOT PARTITION!** This partition holds the kernel and other boot files (on stock android this is the "bootloader" partition / nanda).


Setup the following partitioning using cfdisk, gparted, etc. You will need to make a partition table first (msdos table).

```sh
Disk /dev/mmcblk0: 59.63 GiB, 64021856256 bytes, 125042688 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xa01bf589

Device         Boot Start       End   Sectors  Size Id Type
/dev/mmcblk0p1       2048     67583     65536   32M  b W95 FAT32
/dev/mmcblk0p2      67584 125042687 124975104 59.6G 83 Linux
```

Then make the filesystems

```sh
sudo mkfs.vfat /dev/mmcblk0p1
sudo mkfs.ext4 /dev/mmcblk0p2   # Can skip if using rootfs.ext4
```

Add required boot partition files

```sh
# Prepare kernel
cd /path/to/lichee/out/sun8iw5p1/linux/common/
sudo tar -vxjf vmlinux.tar.bz2
arm-linux-gnueabihf-objcopy -O binary vmlinux vmlinux.bin
mkimage -C none -A arm -T kernel -n "Linux Kernel" -d vmlinux.bin uImage

# Mount boot
sudo mkdir /mnt/boot
sudo mount /dev/mmcblk0p1 /mnt/boot/

# Copy kernel
sudo cp uImage /mnt/boot

# Make boot.cmd
cat << 'EOF' | tee boot.cmd
setenv bootm_boot_mode sec
setenv bootargs console=ttyS0,115200 root=/dev/mmcblk0p2 rootwait panic=10
load mmc 0:1 0x43000000 script.bin || load mmc 0:1 0x43000000 boot/script.bin
load mmc 0:1 0x42000000 uImage || load mmc 0:1 0x42000000 boot/uImage
bootm 0x42000000
EOF

# Convert to boot.scr
mkimage -C none -A arm -T script -d boot.cmd boot.scr

# Copy to boot partition
sudo cp boot.scr /mnt/boot/

# Unmount boot partition
sudo umount /mnt/boot
```


Write rootfs

```sh
cd /path/to/lichee/out/sun8iw5p1/linux/common/
myloop=$(sudo losetup -f -P --show ./rootfs.ext4)
echo $myloop    # Should be /dev/loop followed by a number
sudo dd if=${myloop} of=/dev/mmcblk0p2
sudo losetup -d $myloop
unset myloop
sudo e2fsck -f /dev/mmcblk0p2
sudo resize2fs /dev/mmcblk0p2
```

And then it doesn't boot from the SD card. It boots normal android. Not sure if it attempts the card or not. TBD




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

setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk0p2 rootwait panic=10 ${extra}

bootz 0x46000000 - 0x49000000
```

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

Finally, unmount the root partition and hope the card actually boots on the device.

```sh
sudo umount /mnt/root
```


### Current Status

Card boots. U-boot is shown. Probably boots the kernel (says starting kernel then screen goes black). But, I have no UART console. So I don't know what actaullly happens.

Next steps:

- GET UART!!!
- Or maybe just some startup script that writes a file to the card to prove to me that it is working

