#!/bin/sh

# Toggles the touchpad

 device="ETPS/2 Elantech Touchpad"
#device="PS/2 Generic Mouse"
[ "$(xinput --list-props "$device" | grep -e "Device Enabled (.*):.*1")" ] && xinput disable "$device" || xinput enable "$device"
