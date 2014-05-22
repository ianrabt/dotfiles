#!/bin/bash

if [ ! -x /usr/bin/cmus-remote ]
then
        echo "UNABLE TO FIND CMUS INSTALL"
        exit
fi

# check if CMUS is running
if ps aux | grep "cmus" >/dev/null
then

        STATUS=$( cmus-remote -Q 2>/dev/null | grep "status " | cut -d " " -f 2-)
        if [ -z "$STATUS" ];
        then
                echo "music"
        else
                echo "$STATUS"
        fi
else
        echo "music"
        exit
fi
