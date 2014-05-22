#!/bin/bash
# author: ianrtaylor

# view the current ALSA Master volume level

# gets the current volume as a percent
VOLUME=$(amixer get Master | grep "Front Left:" | awk '{print $5}' | cut -d "[" -f2 | sed 's/]//g')

# gets either "[on]" or "[off]", depending on mute status
MUTE=$(amixer get Master | grep "Front Left:" | awk '{print $6}')

if [[ $MUTE == "[off]" ]]         # is otherwise "[on]"
then
        echo MM
else
        echo $VOLUME
fi
