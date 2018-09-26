#
# ~/.bash_profile
#

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd
clear

# source .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Environment variables:
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
export PATH="/usr/lib/ccache/bin/:$PATH:$HOME/bin"
export EDITOR='vim'

# notify systemd/User of the new path
systemctl --user import-environment PATH
