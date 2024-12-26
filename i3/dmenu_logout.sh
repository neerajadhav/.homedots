#!/bin/sh

# Set environment
#export I3_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/i3"

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

# Load dmenu config
[ -f "$HOME/.dmenurc" ] && . "$HOME/.dmenurc" || DMENU='dmenu -i'

# Menu items
items="Logout
Poweroff
Reboot
Hibernate
Suspend"

# Open menu
selection=$(printf '%s' "$items" | $DMENU -i -l 10 -p 'Power Menu' -fn 'Ubuntu Mono:bold:pixelsize=15' -nb "$color0" -nf "$color15" -sb "$color3" -sf "$color15")

# selection=$(printf '%s' "$items" | dmenu -i -l 10 -p 'Power Menu' -fn 'Ubuntu Mono:bold:pixelsize=15')

case $selection in
Logout)
    i3-msg exit
    ;;
Poweroff)
    systemctl poweroff
    ;;
Reboot)
    systemctl reboot
    ;;
Hibernate)
    systemctl hibernate
    ;;
Suspend)
    systemctl suspend
    ;;
esac

exit
