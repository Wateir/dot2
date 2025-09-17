#!/bin/bash

STYLE_FILE="$HOME/.config/waybar/style.css"
HYPR_FILE="$HOME/.config/hypr/hyprland.conf"

if grep -q 'theme/aero.css' "$STYLE_FILE"; then
    sed -i 's#theme/aero.css#theme/full.css#' "$STYLE_FILE"
    pkill -SIGUSR2 waybar
    sed -i 's/aero.conf/full.conf/' "$HYPR_FILE"    
    echo "Switched to full theme"
else
    sed -i 's#theme/full.css#theme/aero.css#' "$STYLE_FILE"
    pkill -SIGUSR2 waybar
    sed -i 's/full.conf/aero.conf/' "$HYPR_FILE"
    echo "Switched to aero theme"
fi
