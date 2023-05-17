# Stock Android Info

Lots of info extracted from stock Android OS

- `build.prop`: `/system/build.prop`
- `buildinfo`: Probably useless info from `sunxi-meminfo` from [sunxi-tools](https://github.com/linux-sunxi/sunxi-tools). Required modifications to `meminfo.c` to use the `sun8i` method for this device (identified as `sun9i`). This information is probably useless because A33's [dram controller](https://linux-sunxi.org/DRAM_Controller) is more like `sun9i` than early `sun8i`.
- `converted.dts`: Dts auto generated from `script.fex` using [FEX2DTS](https://github.com/SdtElectronics/FEX2DTS). No idea if this is valid or not.
- `default.prop`: `/default.prop`
- `dmesg.txt`: Output from `dmesg` after tablet has fully booted and waited for at least 5 minutes.
- `dmesg_with_wifi.txt`: Output from `dmesg` with wifi turned on
- `dmesg_with_camera.txt`: Output from `dmesg` with camera app opened
- `dumsys.txt` Output from `dumpsys`
- `info_from_stock.txt`: Output of various potentially useful commands
- `part_map.txt`: Partition map information extracted from `/dev/block/by-name`
- `script.bin`: Extracted from booted stock android using `sunxi-script_extractor` from [sunxi-tools](https://github.com/linux-sunxi/sunxi-tools)
- `script.fex`: `script.bin` converted to fex using `bin2fex` from [sunxi-tools](https://github.com/linux-sunxi/sunxi-tools)
