#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function start-tmux() {
	if which tmux 2>&1 >/dev/null; then
		# if no session is started, start a new session
		test -z ${TMUX} && tmux

		# when quitting tmux, try to attach
		while test -z ${TMUX}; do
			tmux attach || break
		done
	fi
}

# FUNCTIONS:

function cl(){
	clear
	date #| tr -d '\n'
}

helpme(){
	echo "wifi   - (ip link; sudo wifi-menu) to start a wireless connection"
	echo "startx - start an xserver with the i3 tiling window manager"
	echo "cmus   - C* Music Player (play music without an X session running)"
	echo $'\nuse the power button or \'shutdown\' to power off'
}

journal () {
# if file doesn't exist, create it
        if [[ ! -f $HOME/.notes ]]; then
                touch $HOME/.notes
        fi

        if [[ $# -eq 0 ]]; then
                # no arguments, print file
		echo "~/.journal is the text file in which the journal is saved."
		echo "cat ~/.journal?"
	elif [[ "$1" == "-n" ]]; then
		echo >> $HOME/.journal
                date >> $HOME/.journal
                vim $HOME/.journal
        else
                # add all arguments to file
		echo >> $HOME/.journal
		date >> $HOME/.journal
                echo "$@" >> $HOME/.journal
        fi
}


note () {
# if file doesn't exist, create it
	if [[ ! -f $HOME/.notes ]]; then
		touch $HOME/.notes
	fi
	
	if [[ $# -eq 0 ]]; then
		# no arguments, print file
		cat $HOME/.notes
	elif [[ "$1" == "-c" ]]; then
	         # clear file
	         echo "" > $HOME/.notes
	elif [[ "$1" == "--help" ]]; then
		echo 'note string : add new note'
		echo 'note        : view notes'
		echo 'note -c     : clear file'
	else
		# add all arguments to file
		echo "$@" >> $HOME/.notes
	fi
}

todo() {
	if [[ ! -f $HOME/.todo ]]; then
	        touch $HOME/.todo
	fi

    if [[ $# -eq 0 ]]; then
		cat $HOME/.todo
	elif [[ "$1" == "-l" ]]; then
	        cat -n $HOME/.todo
	elif [[ "$1" == "-c" ]]; then
		echo "" > $HOME/.todo
	elif [[ "$1" == "-r" ]]; then
	        cat -n $HOME/.todo
	        echo -ne "----------------------------\nType a number to remove: "
	        read NUMBER
	        sed -ie ${NUMBER}d $HOME/.todo
	else
		echo "$@" >> $HOME/.todo
	fi
}

function trset() {
	[ -n "$XTERM_VERSION" ] && transset-df -a .75 >/dev/null
}

translate() {
	wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=${2:-en}|${3:-es}" | sed -E -n 's/[[:alnum:]": {}]+"translatedText":"([^"]+)".*/\1/p';
	echo ''
	return 0;
} 

myip () {
	lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | awk '{ print $4 }' | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' 
}

#clock - A bash clock that can run in your terminal window.
clock () {
	while true
		do clear
		echo "+===========+"
		echo "|$(date +"%r")|"
		echo "+===========+"
		sleep 1
	done
}


# ALIASES:

alias ls='ls -hF --color=auto'
alias lr='ls -R'
alias la='ls -a'

alias wifi='ip link; sudo wifi-menu'

alias tset='transset-df -a'

alias grep='grep --color=auto'
alias ..='cd ..'

alias st='start-tmux'
alias  t='tmux'
alias ta='tmux attach'

# share current dir over local host; prints IP and port.
alias share='ip addr | grep inet; python -m http.server'

# Safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# OTHER STUFF:

function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/ "
}

set-PS1 () {
    #PS1="\[\e[1m\][\[\e[0;36m\]\t\[\e[0;1m\]][\[\e[1;36m\]\u\[\e[1;34m\]@\h\[\e[0;0m\]:\[\e[36m\]\W\[\e[0;1m\]]\$\[\e[0m\] "
    #PS1="\[\e[01;30m\]\n$(if [[ -z $i ]] ; then i=$(tput cols) ; while (( i-- > 9 )) ; do echo -n '—' ; done ; echo -n " " ; unset i ; fi)\T\n\[\e[01;36m\]\u\[\e[0m\]\[\e[01;34m\]@\h \[\e[0m\]\[\e[00;37m\][\[\e[0m\]\[\e[00;36m\]\W\[\e[0m\]\[\e[00;37m\]] \[\e[00;1m\]\$ \[\e[0m\]"
    PS1='\n\[\e[01;30m\]\T \[\e[01;36m\]\u\[\e[0m\]\[\e[01;34m\]@\h \[\e[0m\]\[\e[00;37m\][\[\e[0m\]\[\e[00;36m\]\W\[\e[0m\]\[\e[00;37m\]] $(parse_git_branch)\[\e[00;1m\]\$ \[\e[0m\]'
}
set-PS1
#PROMPT_COMMAND=set-PS1
$HOME/bin/setcolors
date #| tr -d '\n'
source /usr/share/doc/pkgfile/command-not-found.bash
cd ~
