#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
export XDG_MENU_PREFIX=gnome-

xscreensaver -no-splash &
xsetroot -cursor_name left_ptr &

#start-pulseaudio-x11 &
#compton --opengl --vsync opengl-swc --paint-on-overlay -b -f -D 6 -l-13 -t-13 -cCz -o 0.25 &

# Here herbstluft wm is kept as default
session=${1:-hlwm}

case $session in
        openbox) exec openbox-session;;
        gnome) exec gnome-session;;
        i3wm) exec i3;;
        openbox) exec openbox-session;;
        hlwm) exec herbstluftwm;;
		xmonad) exec xmonad;;
        # No known session, try to run it as command
        *) exec $1;;                
esac
