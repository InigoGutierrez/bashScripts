#!/bin/sh

case $BLOCK_BUTTON in
	1) notify-send -t 5000 "Highest RAM processes:
$(ps axch -o cmd:18,%mem --sort=-%mem | sed 10q)" ;;
esac

free -h | awk '/^Mem/ {print $3 "/" $2}'
