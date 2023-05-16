# Device Information & Teardown


## Stock Android Info

Device Codename: `along-6051` (from `build.prop` / adb shell)

From About Device menu:
- Model Number: `A746`
- Build Number: `AZPEN.20170802`
- FCC ID: `2ABKRA727`
- Android Version: `4.4.2`
- Firmware Version: `v2.0`


## From FEL mode:

`sunxi-fel ver`: `AWUSBFEX soc=00001667(A33) 00000001 ver=0001 44 08 scratchpad=00007e00 00000000 00000000`
`sunxi-fel sid`: `0461872a:87185201:9c9747a7:00000000`
`sunxi-fel read 0x01c23800`: `0x0461872a`


## Specs & Hardware Info

General Specs (from manufacturer)
- CPU: Allwinner A33 (1.3 GHz)
- RAM: 512MB
- Storage: 8GB
- Screen 7 inch ~~840x480~~ 1024x600 (manufacturer website states wrong screen resolution)


CPU Details:
- Allwinner A33 SoC chip
- 32-bit `armhf` (`armv7`)
- Quad core Cortex A7
- This is a `sun8i` chip, however, it uses a different dram controller than early `sun8i` (A23). 
- Chip markings: `G8080BA   69W1`
- Uses `AXP223` Power Management IC (PMIC). Chip markings: `HA146BC       6B31`

Memory Details:
- SK hynix chips
- Marking on second row (first row is sk hynix label): `45TQ2G83CFR`
- Marking on third row: `H9C         311V`
- Marking on fourth row: `DWLDAB07H2`
- Two of the above chips present on PCB (assumed to be 2x 256MB)

Storage Details:
- 8GB NAND chip (details unknown)
- TODO: Details

Battery Details:
- TODO

LCD Panel Details:
- TODO

GPS Details:
- TODO

Accelerometer Details:
- TODO

WiFi Details:
- TODO

Bluetooth Details:
- TODO

Vibrator Details:
- TODO



## PCB Pictures and Tablet Teardown

TODO

