# Azpen A746 Linux

There are several references in the `references` folder.


## Hardware Notes:

- The Allwinner A33 SoC is referred to by "sun8i", however it is a "later" sun8i chip. "Early" sun8i is A23. There are some significant differences. Ex: [dram controller](https://linux-sunxi.org/DRAM_Controller). This means that the meminfo tool from sunxi-tools won't actually work here.

## Downloads & Links

- TODO: SD card image (if I ever get that far...)
- Android SDK (only need lichee.tar.gz): [external link](https://linux-sunxi.org/A33#Android_SDK)


## Legacy Kernel & u-boot

### Build System & Prerequisites

### Build Legacy sunxi u-boot

TODO: Use fex to generate dram file. Add device config. Build u-boot.


### Build Legacy 3.4 sunxi Kerenel

TODO: Build kernel & required modules. May require some more specific hardware info to be determined to know what config to use.


### Setup SD Card

TODO: Follow [this](https://linux-sunxi.org/Bootable_SD_card)


### Create rootfs

TODO: Use debootstrap



## Mainline Kernel & u-boot

*Notes on the process; I haven't done much with this yet.*

STEPS:
    - Generate a working device tree (most info should be in fex, but may require some work...)
        - A very similar tablet (Azpen A741) identifies itself as `astar-m86` via adb ([source](https://linux-sunxi.org/Azpen_A741)). Perhaps this is a starting point?
    - Add a u-boot defconfig (most required info should be in fex file)
    - Build u-boot
    - Figure out what to do with device tree for mainline kernel, build it, determine if any drivers are missing, if so attempt to port of fix them...Potentially lots of work
