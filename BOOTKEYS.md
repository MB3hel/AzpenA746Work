# Boot Key Sequences

## Enter Recovery

- Power fully off (not reboot)
- Hold Vol+
- Press and hold power for 5 seconds
- Release power (keep holding vol+)
- Wait until recovery is visible
- Release Vol+

### Enter Fastboot MOde

- No known keycombo. Can access through `adb reboot bootloader` though. Only useful if you can boot into android itself unfortunately.

### Enter FEL Mode

- Power off device (fully)
- Hold Vol+ key (either key should work)
- Press power button 10 times
- Wait 30 seconds (or less sometimes)
- Device will show up to computer in FEL mode (`lsusb`)

### Android Safe Mode

- Hold volume down after boot logo shows up