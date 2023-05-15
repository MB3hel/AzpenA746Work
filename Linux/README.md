# Azpen A746 Linux

There are several references in the `references` folder.


## Downloads & Links

- TODO: SD card image (if I ever get that far...)
- Android SDK (only need lichee.tar.gz): [external link](https://linux-sunxi.org/A33#Android_SDK)



## Allwinner Kernel & U-Boot

### Lichee Build (Kernel & U-Boot)

This requires `lichee.tar.gz` from the Allwinner A33 Android SDK.

Build tested on Ubuntu 12.04 LTS (amd64). Built in chroot environment. You will probably have to run debootstrap with `--keyring=/usr/share/keyrings/ubuntu-archive-removed-keys.gpg`

I have not had success building with newer Ubuntu's due to use of `gets` in something. I haven't bothered tracking it down yet.

```sh
# NOTE: Make sure to extract lichee to a path that does not contain spaces!
tar zxvf lichee.tar.gz
cd lichee
./build.sh config
```

Select the following

- Chip: `0. sun8iw5p1`
- Platform: `2. linux`
- Kernel: `0. linux-3.4`
- Boards: `0. evb`

*Note: the `evb` board is used because the `script.fex` extracted from the tablet seems to indicate this device. However, the partition table indicates a slightly different configuration. It may instead be necessary to create a tablet-specific config based on `evb` in `tools/pack/chips/sun8iw5p1/configs/` using the extracted `script.fex` as `sys_config.fex`.

After configuring the script will exit.  Various dependencies may have to be installed for the build to work. 

Install known dependencies (may be incomplete):

```sh
sudo apt-get install build-essential texinfo python2.7 bison flex gettext wget zip unzip zlib1g zlib1g-dev uboot-mkimage
```

Enable 32-bit support (some binaries in lichee are 32-bit)

```sh
sudo apt-get install multiarch-support
echo "foreign-architecture i386" | sudo tee /etc/dpkg/dpkg.cfg.d/multiarch
sudo apt-get update
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386
```


Fix some things so the build works

```sh
# Fix error building this kernel module (use config from old version of module)
cp -r linux-3.4/modules/mali/DX910-SW-99002-r3p2-01rel2/driver/src/devicedrv/ump/arch-ca8-virtex820-m400-1 linux-3.4/modules/mali/DX910-SW-99002-r4p0-00rel0/driver/src/devicedrv/ump/


# Fix errors building makedevs (don't treat errors as warnings)
sed -i 's/\$(CC) -Wall -Werror/\$(CC) -Wall/g' buildroot/package/makedevs/makedevs.mk
```


Run `./build.sh` to actually build. When prompted about kernel options, use default values.




### Rootfs

TODO


### Kernel modules

TODO: Any modules need to be added to rootfs? From android? Built from sources?


### Making Bootable SD Card

TODO: Mostly follow [this](https://linux-sunxi.org/Bootable_SD_card)




## Legacy Sunxi Kernel & U-Boot

TODO: Is this significantly different from Allwinner stuff? Kernel same, uboot different? Not entirely sure.



## Mainline Kernel & U-Boot

TODO: I'd have to make / validate device tree overlays...
