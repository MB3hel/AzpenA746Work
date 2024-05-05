
# Linux Build

**NOTE: Does not work.**

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

You will be prompted at some point for which kernel modules to build / configuration for kernel modules. Some prompts will be auto answered by the build script. Answer the ones that are not as shown below (should all be default values)

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

After the build finishes, the kernel will be at `linux-3.4/output/zImage`.


This can be used with an SD card created with a mainline kernel by adding this `zImage` to the boot partition as `zImage.aw` and using a `boot.scr` compiled from `boot.aw.cmd` with the following contents

```
setenv bootm_boot_mode sec

fatload mmc 0 0x46000000 zImage.aw
fatload mmc 0 0x43000000 script.bin
fatload mmc 0 0x49000000 sun8i-a33-q8-tablet.dtb

setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk1p2 rootwait panic=10 ${extra}

bootz 0x46000000 - 0x49000000
```

Use the following to compile it

```
sudo mkimage -C none -A arm -T script -d /mnt/boot/boot.aw.cmd /mnt/boot/boot.scr
```

You also need to copy the `script.bin` extracted from stock android to the boot partition of the SD card.


**Result:** This does something, but doesn't boot properly or output anything on uart.