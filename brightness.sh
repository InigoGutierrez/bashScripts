#!/bin/bash

brightness_file=/sys/class/backlight/intel_backlight/brightness
maxbrightness_file=/sys/class/backlight/intel_backlight/max_brightness

permissions=$(ls -l $brightness_file | awk '{print $1}')
if [ $permissions != "-rw-rw-rw-" ]; then
	#urxvt -title floating -geometry 32x1 -e sudo ~/scripts/brightFirst.sh
	sudo ~/scripts/brightFirst.sh
fi

brightness=$(< $brightness_file)
maxbrightness=$(< $maxbrightness_file)
let target=$1+$brightness
if [ $target -gt $maxbrightness ]
then
	#echo "Value too big. Target: $target; max: $maxbrightness"
	echo $maxbrightness | tee $brightness_file
elif [ 0 -gt $target ]
then
	#echo "Value too low. Target: $target"
	echo "0" | tee $brightness_file
else
	echo $target | tee $brightness_file
	#echo "New brightness: $target/$maxbrightness"
fi

notify-send -h string:x-canonical-private-synchronous:vol -t 500 "$(~/scripts/i3blocks/i3brightness.sh)"
pkill -SIGRTMIN+11 i3blocks
