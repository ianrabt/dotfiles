#!/bin/bash

# check if CMUS is running
if ps aux | grep "cmus" >/dev/null
then

        POSITION=$( cmus-remote -Q 2>/dev/null | grep "position " | cut -d " " -f 2-)
        DURATION=$( cmus-remote -Q 2>/dev/null | grep "duration " | cut -d " " -f 2-)
        if [ -z "$DURATION" ];
        then
                echo "00:00 00:00"
        else
                echo "$POSITION $DURATION"
        fi
else
        echo "00:00 00:00"
        exit
fi

