#!/bin/sh

# Generates an i3lock bg based on a screenshot.

imgLock="$HOME/images/icons/lock.png"
imgTemp="/tmp/i3lockss.png"
imgFinal="/tmp/lockFinal$(date +"%H%M%S").png"
maim "$imgTemp"
#[ -e "$imgLock" ] && convert "$imgTemp" -paint 1 -swirl -30 "$imgLock" -gravity center -composite "$imgFinal"
#[ -e "$imgLock" ] && convert "$imgTemp" "$imgLock" -gravity center -composite -monochrome "$imgFinal"
#[ -e "$imgLock" ] && convert "$imgTemp" -edge 3 "$imgLock" -gravity center -composite "$imgFinal"
#[ -e "$imgLock" ] && convert "$imgTemp" -colors 8 "$imgFinal"
[ -e "$imgLock" ] && convert "$imgTemp" -canny 1x1 "$imgFinal"
i3lock -i "$imgFinal" -f || i3lock -i "$imgTemp" -f
