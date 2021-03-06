#!/bin/bash

# Feed script a url.

ext="${1##*.}"
mpvFiles="mkv mp4 gif"
imageFiles="png jpg jpeg jpe"
wgetFiles="mp3 pdf"

imgViewer="showURLimage.sh"

# Reproduce in terminal if no X server
[ -z "$(xset q 2>/dev/null)" ] && mpv -vo caca "$1"

# Check youtube link
if echo "$1" | grep "youtube" >/dev/null; then
		chosen=$(echo -e "mpv\nmpv (loop)\nmpv (float)\nmpv (terminal)\ndownload (y-dl)\nqutebrowser\nw3m" | dmenu -i)
		case "$chosen" in
			"mpv") nohup mpv "$1" >/dev/null & ;;
			"mpv (loop)") nohup mpv --loop "$1" >/dev/null & ;;
			"mpv (float)") mpvFloat.sh "$1" ;;
			"mpv (terminal)") mpv --loop -vo caca "$1" ;;
			"download (y-dl)") youtube-dlFloat.sh "$1" & ;;
			"qutebrowser") qutebrowser "$1" & ;;
			"w3m") urxvt -e w3m "$1" & ;;
		esac
# General checks
elif echo "$imageFiles" | grep -w "$ext" >/dev/null; then
			"$imgViewer" "$1" >/dev/null &
elif echo "$mpvFiles" | grep -w "$ext" >/dev/null; then
		chosen=$(echo -e "mpv\nmpv (loop)\nmpv (float)\nmpv (terminal)\nqutebrowser" | dmenu -i)
		case "$chosen" in
			mpv) nohup mpv "$1" >/dev/null & ;;
			"mpv (loop)") nohup mpv --loop "$1" >/dev/null & ;;
			"mpv (float)") mpvFloat.sh "$1" ;;
			"mpv (terminal)") mpv --loop -vo caca "$1" ;;
			"qutebrowser") qutebrowser "$1" & ;;
		esac
elif echo "$wgetFiles" | grep -w "$ext" >/dev/null; then
		nohup wget "$1" >~/log-wget.txt &
else
		chosen=$(echo -e "mpv\nmpv (loop)\nmpv (float)\nmpv (terminal)\nsxiv\ndownload (y-dl)\nqutebrowser\nw3m" | dmenu -i)
		case "$chosen" in
			mpv) nohup mpv "$1" >/dev/null & ;;
			"mpv (loop)") nohup mpv --loop "$1" >/dev/null & ;;
			"mpv (float)") mpvFloat.sh "$1" ;;
			"mpv (terminal)") mpv --loop -vo caca "$1" ;;
			"sxiv") "$imgViewer" "$1" >/dev/null & ;;
			"download (y-dl)") youtube-dlFloat.sh "$1" & ;;
			qutebrowser) qutebrowser "$1" & ;;
			w3m) urxvt -e w3m "$1" & ;;
		esac
fi
