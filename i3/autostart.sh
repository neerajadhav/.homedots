#!/bin/sh

picom &

# File to monitor
bg_file="$HOME/.config/nitrogen/bg-saved.cfg"

# Check if the required tools are installed
command -v inotifywait >/dev/null 2>&1 || { echo "inotifywait is required but not installed. Exiting."; exit 1; }
command -v wal >/dev/null 2>&1 || { echo "wal is required but not installed. Exiting."; exit 1; }
command -v betterlockscreen >/dev/null 2>&1 || { echo "betterlockscreen is required but not installed. Exiting."; exit 1; }

# Function to handle the change in wallpaper
handle_wallpaper_change() {
    # Extract the wallpaper path from the bg-saved.cfg file
    wallpaper=$(grep -oP '(?<=^file=).+' "$bg_file")

    # Check if wallpaper exists
    if [[ -f "$wallpaper" ]]; then
        echo "Wallpaper changed to: $wallpaper"
        wal -i "$wallpaper"
        betterlockscreen -u "$wallpaper"
    else
        echo "Error: Wallpaper file '$wallpaper' not found."
    fi
}

# Initial check if the bg-saved.cfg exists
if [[ ! -f "$bg_file" ]]; then
    echo "Error: The file '$bg_file' does not exist."
    exit 1
fi

# Monitor the bg-saved.cfg file for changes
echo "Monitoring changes in $bg_file..."
inotifywait -m -e modify "$bg_file" | while read -r _ _ _; do
    handle_wallpaper_change
done
