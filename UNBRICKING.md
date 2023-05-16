# Unbricking

### FEL Mode

Allwinner devices have a low level "FEL" mode used to write the NAND. This can be triggered various ways. 

On this device (even if bootlooping) hold volume down (either key should work, but volume down seems important to break the bootloop). Then hold power (still holding volume down). Wait until the screen turns off for 5 seconds. Then release power (still holding vol down) and press the power button 10 times. Release the vol down button after a few seconds. The device should be in FEL mode.

FEL mode can also be triggered with a special SD card image. See [here](https://linux-sunxi.org/FEL) for details.

In FEL mode, the [Linux Sunxi Tools](https://github.com/linux-sunxi/sunxi-tools) may be helpful.

To unbrick, you would need a stock from from the manufacturer in Allwinner format. This could be flashed with [LiveSuit](https://linux-sunxi.org/LiveSuit) (maybe) or PhoenixSuit. Azpen's "Upgrade Tool for Allwinner" is Phoenix.

*I do not currently have a ROM from Azpen, but it may be possible to pack my dumped ROM correctly. [This](https://linux-sunxi.org/LiveSuit_images) page is a good place to start. There are pack tools in the lichee archive in the Allwinner Android SDK.*



### Fastboot

Fastboot can be accessed using `adb reboot bootloader`, but I have yet to find a key combo to access it (probably not possible). Theoretically, one could flash a partition in fastboot. But this seems useless in practice if we can't get to fastboot.



### uBoot Console

If we could access the uBoot console, we could probably manually boot to fastboot using `fastboot usb 0`. There are UART pads on this tablet's board (requires opening tablet). This is untested, but persumably similar to A741 (info [here](https://linux-sunxi.org/Azpen_A741)). However, the console may not accept input due to sharing with the SD card (again, untested).

Theoretically, FEL could also be used to flash a custom uboot build to work around this (differnet UART port), but we'd need to be able to build uboot for this device. Currently not sure what that would entail. It is possible a generic A33 1024x600 build would work. But again, UNTESTED!


### SD Card Boot

It is likely (untested) that this device would boot from SD card before booting NAND. Thus, a properly constructed SD card may allow booting of a linux or android environment. `dd` could then be used to manually flash the stock rom dumped from my device.

[This process](https://linux-sunxi.org/Boot_Android_from_SdCard) may be usable with my dumped stock rom to make a bootable android SD card to unbrick. But would need to build uboot.

It may also be possible to make a bootable Linux SD card. However, either of these methods would require a u-boot build (WIP currently). One extracted from NAND could maybe work, but I can't get a full nand backup either...
