#!/bin/bash

STYLE_FILE="$HOME/.config/waybar/style.css"
HYPR_FILE="$HOME/.config/hypr/hyprland.conf"

# Check current theme
if grep -q 'theme/aero.css' "$STYLE_FILE"; then
    # Switch to full.css
    sed -i 's#theme/aero.css#theme/full.css#' "$STYLE_FILE"
    sed -i 's/aero.conf/full.conf/' "$HYPR_FILE"
	sleep 0.5
	hyprctl hyprpaper reload , $HOME/Downloads/wallpaper-full.png
    
    echo "Switched to full theme"
else
    # Switch to aero.css
    hyprctl hyprpaper reload , $HOME/Downloads/wallpaper.jpg
    sleep 0.5
    sed -i 's#theme/full.css#theme/aero.css#' "$STYLE_FILE"
    sed -i 's/full.conf/aero.conf/' "$HYPR_FILE"
    echo "Switched to aero theme"
fi

# Optionally reload Waybar
pkill -SIGUSR2 waybar
