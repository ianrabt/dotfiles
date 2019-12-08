#!/bin/bash
layout=$(herbstclient layout '' @ | cut -f2 -d' ')
notify-send --expire-time=1000 -u low $layout "Availible: vertical, horizontal, max, grid"
