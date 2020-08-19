#!/bin/bash

# This basic script will switch between flat (no acceleration) profile to default (default acceleration profile) for mouse on Gnome
# Personally I linked this to a command which is bound to a key combination to quickly switch between profiles when playing FPS games

# Grab current mouse accel profile
PROFILE=`gsettings get org.gnome.desktop.peripherals.mouse accel-profile`

# Check for active profile, then switch to the other
if [ $PROFILE == "'default'" ]
then
	notify-send --hint=int:transient:1 -u low -t 1000 "Flat profile selected."
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat
else
	notify-send --hint=int:transient:1 -u low -t 1000 "Default profile selected."
	gsettings set org.gnome.desktop.peripherals.mouse accel-profile default
fi
