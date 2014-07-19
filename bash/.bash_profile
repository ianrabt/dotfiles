#
# ~/.bash_profile
#

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd
clear

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Environment variables
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
PATH="/usr/lib/ccache/bin/:$PATH:$HOME/bin"
export PATH
EDITOR='vim'
export EDITOR
