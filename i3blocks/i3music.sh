#!/bin/sh

case $BLOCK_BUTTON in
	1) pgrep -x cmus >/dev/null && cmus-remote -r ;;
	2) pgrep -x cmus >/dev/null && cmus-remote -u ;;
	3) pgrep -x cmus >/dev/null && cmus-remote -n ;;
esac

symbol=🎵
ampersand="I"
pgrep -x cmus >/dev/null || exit 0
stat="$(cmus-remote -Q | grep "^status " | awk '{print $2}' | sed "s/&/$ampersand/")"
artist="$(cmus-remote -Q | grep "^tag artist " | cut -d' ' -f3- | sed "s/&/$ampersand/")"
title="$(cmus-remote -Q | grep "^tag title " | cut -d' ' -f3- | sed "s/&/$ampersand/")"
[ -z "$artist" ] && artist="(unknown)"
[ -z "$title" ] && title="$(basename "$(cmus-remote -Q | grep "^file" | cut -d' ' -f2- | sed "s/&/$ampersand/")")" # sed to fix & in title messing up script
if [ "$stat" = "playing" ]; then
	#echo "$symbol $artist ─ $title"
	echo "$symbol $artist ─ $title"
elif [ "$stat" = "paused" ]; then
	echo "$symbol ( $artist ─ $title )"
else
	echo "$symbol $stat"
fi
