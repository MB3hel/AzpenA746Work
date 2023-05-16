# Azpen A746 Linux


## Kernel & u-boot Information

- The A33 is not supported in `u-boot-sunxi` or the `linux-sunxi` 3.4 kernel ([source](https://linux-sunxi.org/A33#Overview))
- Mainline kernel would require a device tree
- The stock android OS is built using Allwinner lichee kernel (3.4), thus it uses no device tree (uses `script.bin` -> `script.fex`)
- Stock u-boot is of unknown origin (possibly something from `lichee` tarball from A33 Android SDK)

<br />

- Adding support to `u-boot-sunxi` and `linux-sunxi` could be done (may be less work than making a device tree), but is not really worth the time for legacy stuff.
- Thus, really the first step for this device is a working device tree.



## Device Tree Creation

TODO
