#!/bin/env sh

DARK_THEME="'Adwaita-dark'"
LIGHT_THEME="'Adwaita'"

CURRENT_THEME="$(gsettings get org.gnome.desktop.interface gtk-theme)"

WALLPAPER_DIR="$HOME/bin/toggle-theme-wallpapers/"

if [ "$CURRENT_THEME" == "$LIGHT_THEME" ]
then
    gsettings set org.gnome.desktop.interface gtk-theme "$DARK_THEME"
    gsettings set org.gnome.desktop.background picture-uri "file://${WALLPAPER_DIR}dark.jpg"
elif [ "$CURRENT_THEME" == "$DARK_THEME" ]
then
    gsettings set org.gnome.desktop.interface gtk-theme "$LIGHT_THEME"
    gsettings set org.gnome.desktop.background picture-uri "file://${WALLPAPER_DIR}light.jpg"
else
    echo "an error has occurred"
    echo "$CURRENT_THEME"
    exit 1
fi
