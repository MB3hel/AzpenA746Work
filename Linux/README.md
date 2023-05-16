# Azpen A746 Linux

There are several references in the `references` folder.


## Downloads & Links

- TODO: SD card image (if I ever get that far...)
- Android SDK (only need lichee.tar.gz): [external link](https://linux-sunxi.org/A33#Android_SDK)


## Build System & Prerequisites

- Ubuntu 22.04 LTS (amd64)
- `sudo apt install bison flex swig python3-dev device-tree-compiler`


## Build u-boot

*Building mainline u-boot as I didn't feel like figuring out all the stuff required to build legacy u-boot. Use of mainline u-boot is also recommended in general if the device is supported.*

- Get sources
    ```sh
    git clone git://git.denx.de/u-boot.git
    cd u-boot
    git checkout v2023.04   # Change this to newer version if desired
    ```
- Add to `boards.cfg` in sunxi grouping of lines
    ```
    Active  arm         armv7          sunxi       -               sunxi               ALONG-6051                           sun8i:A33_ALONG_6051,SPL
    ```
- Create `configs/along_6051_tablet_defconfig`
    ```
    CONFIG_ARM=y
    CONFIG_ARCH_SUNXI=y
    CONFIG_DEFAULT_DEVICE_TREE="sun8i-a33-along-6051-tablet"
    CONFIG_SPL=y
    CONFIG_MACH_SUN8I_A33=y
    CONFIG_DRAM_CLK=504
    CONFIG_DRAM_ZQ=15291
    CONFIG_USB0_VBUS_PIN="power4"
    CONFIG_USB0_VBUS_DET="axp_ctrl"
    CONFIG_USB0_ID_DET="PH8"
    CONFIG_AXP_GPIO=y

    CONFIG_VIDEO_LCD_MODE="x:1024,y:600,depth:18,pclk_khz:52000,le:138,ri:162,up:22,lo:10,hs:20,vs:3,sync:3,vmode:0"
    CONFIG_VIDEO_LCD_DCLK_PHASE=0
    CONFIG_VIDEO_LCD_POWER="power2"
    CONFIG_VIDEO_LCD_BL_EN="PH6"

    # Not certain about this one... This is lcd_gpio_0 in fex
    # CONFIG_VIDEO_LCD_BL_PWM="PH7"

    # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
    CONFIG_AXP_DLDO1_VOLT=3300
    CONFIG_CONS_INDEX=5
    CONFIG_USB_MUSB_HOST=y
    ```
- Create `arch/arm/dts/sun8i-a33-along-6051-tablet.dts`
    ```
    # Content of converted fex file
    ```
- Configure and build
    ```
    make CROSS_COMPILE=arm-linux-gnueabihf- along_6051_tablet_defconfig
    # OPTIONAL: make CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
    make CROSS_COMPILE=arm-linux-gnueabihf-
    ```



## Build Legacy 3.4 sunxi Kerenel

TODO


### Setup SD Card

TODO


### Create rootfs

TODO
