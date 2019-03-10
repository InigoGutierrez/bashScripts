#!/bin/sh

# Generates an i3lock bg based on a screenshot.

imgLock="$HOME/images/padlock.png"
imgFinal="/tmp/lockFinal$(date +"%H%M%S").png"
maim /tmp/i3lockss.png
convert /tmp/i3lockss.png -paint 1 -swirl -20 "$imgLock" -gravity center -composite "$imgFinal"
i3lock -i "$imgFinal" -f