#!/bin/sh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

dmenu_run -i -l 10 -p 'NixOS' -fn 'Ubuntu Mono:bold:pixelsize=15' -nb "$color0" -nf "$color15" -sb "$color3" -sf "$color15"
