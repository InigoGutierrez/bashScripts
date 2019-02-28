#!/bin/sh

MARKFILE='/tmp/screenRec.mark'
# Terminate ffmpeg processes
for process in $(pgrep -x ffmpeg)
do
	kill "$process" && notify-send -t 1000 "ffmpeg $process stopped."
done
# Terminate screenRecord.sh processes
for process in $(pgrep -x screenRecord.sh)
do
	kill "$process" && notify-send -t 1000 "Recording $process stopped."
done
rm $MARKFILE
pkill -SIGRTMIN+13 i3blocks
