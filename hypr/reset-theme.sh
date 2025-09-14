STYLE_FILE="$HOME/.config/waybar/style.css"
HYPR_FILE="$HOME/.config/hypr/hyprland.conf"

hyprctl hyprpaper reload , $HOME/Downloads/wallpaper.jpg
sleep 0.5
sed -i 's#theme/full.css#theme/aero.css#' "$STYLE_FILE"
sed -i 's/full.conf/aero.conf/' "$HYPR_FILE"
echo "Switched to aero theme"
