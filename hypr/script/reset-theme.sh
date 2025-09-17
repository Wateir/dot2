STYLE_FILE="$HOME/.config/waybar/style.css"
HYPR_FILE="$HOME/.config/hypr/hyprland.conf"

sed -i 's#theme/full.css#theme/aero.css#' "$STYLE_FILE"
sed -i 's/full.conf/aero.conf/' "$HYPR_FILE"
echo "Switched to aero theme"
