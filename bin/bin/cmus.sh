#!/bin/bash

if [ ! -x /usr/bin/cmus-remote ]
then
        echo "UNABLE TO FIND CMUS INSTALL"
        exit
fi

ARTIST=$( cmus-remote -Q 2>/dev/null | grep " artist " | cut -d " " -f 3- )
TITLE=$( cmus-remote -Q 2>/dev/null | grep " title " | cut -d " " -f 3- )
ALBUM=$( cmus-remote -Q 2>/dev/null | grep " album " | cut -d " " -f 3- )


if [ -z "$ARTIST" ]; # checks if anything is playing
then
        echo "nothing playing"
else
        if [ $[ ${#ARTIST} + ${#ALBUM} + ${#TITLE} ] -gt 90 ]
        then
                if [ ${#ARTIST} -gt 25 ]
                then
                        ARTIST=$(echo $ARTIST | cut -c-15 )
                        ARTIST=$ARTIST'...'
                fi
        
                if [ ${#ALBUM} -gt 35 ]
                then
                        ALBUM=$(echo $ALBUM | cut -c-15 )
                        ALBUM=$ALBUM'...'
                        fi

                if [ ${#TITLE} -gt 40 ]
                then
                        TITLE=$(echo $TITLE | cut -c-25 )
                        TITLE=$TITLE'...'
                fi
        fi

		echo "$ARTIST - $ALBUM - $TITLE"
fi

