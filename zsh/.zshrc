# history settings
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
PATH="$PATH:$HOME/.local/bin:$HOME/.emacs.d/bin"
setopt appendhistory
setopt histignorespace # ignore commands starting with space

# use Emacs keybindings
bindkey -e

# fix home, end, etc:

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[ShiftTab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[ShiftTab]}"  ]] && bindkey -- "${key[ShiftTab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start {
        echoti smkx
    }
    function zle_application_mode_stop {
        echoti rmkx
    }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# completion settings
zstyle :compinstall filename '/home/itaylor/.zshrc'
zstyle ':completion:*' menu select # use menu for completions
setopt COMPLETE_ALIASES # enable completion for aliased commands

autoload -Uz compinit
compinit

# some quality of life additions
setopt autocd
setopt interactivecomments  # allow comments in interactive shells

# aliases
alias ls='ls -hF --color=auto'
alias lr='ls -R'
alias ll='ls -l'
alias la='ls -a'

alias grep='grep --color=auto'
alias ..='cd ..'

alias st='start-tmux'
alias  t='tmux'
alias ta='tmux attach'

alias trash='gio trash' # convenient way to send files to trash
            # instead of permanently deleting them.
# set the brightness to the minimum
alias dim='light -r -S 1'
alias redshift-oneshot='redshift -O 4250'
alias lisp='rlwrap sbcl'

# Safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias school="ranger '$HOME/School/Google Drive'"

function emacsc {
    nohup emacsclient -c $@ > /dev/null &
}

# MOTD -- prints some predefined messages upon terminal startup
if [ -f ~/motd ]
then
    echo -n '  '
    cat ~/motd | shuf -n 1
    echo
fi

# graphical settings

# set terminal title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
    print -Pn -- '\e]2;%n@%m %~\a'
    [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
    print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
    [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
    add-zsh-hook -Uz precmd xterm_title_precmd
    add-zsh-hook -Uz preexec xterm_title_preexec
fi


# this helps with TRAMP (Emacs)
if [[ "$TERM" == "dumb" ]]
then
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    PROMPT='$ '
else
    PROMPT=$'%@ %B%F{cyan}%n%f%F{blue}@%M%f%b [%F{cyan}%1~%f] %B%#%b '
    # Syntax highlighting (must be at end of file)
    HIGHLIGHT_FILE='/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
    if [ -f "$HIGHLIGHT_FILE" ]
    then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
fi
