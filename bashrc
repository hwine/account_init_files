# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if $(which /usr/bin/lesspipe &>/dev/null) ; then
    eval "$(SHELL=/bin/sh lesspipe)"
elif type -p lesspipe.sh &>/dev/null ; then
    export LESSOPEN="|lesspipe.sh %s"
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
# work stuff
export MOZ_USER=${MOZ_USER:-hwine}
export PASTEBIN_NAME=${PASTEBIN_NAME:-hwine}

if $(which nvim &>/dev/null); then
    export VISUAL=nvim
    export EDITOR=nvim
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

alias ll=ls\ -lFG
alias ls=ls\ -FG

if [ -r /usr/share/vim/vim73/macros/less.sh ]; then
    lessc() { /usr/share/vim/vim73/macros/less.sh "$@"; }
else
    lessc() { less "$@"; }
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

function tmux() { local c=ssh-agent ; pgrep $c &>/dev/null && c= ; command $c tmux "$@" ; }
export -f tmux
function jsonlint() { python -c "import json; json.load(open('$1'))"; }
function lf(){ \ls -t | head -1 ;}
function host ()
{
    # based on
    # http://curtisfree.com/blog/2012/12/02/simple_yet_thorough_hostname_resolution_in_mac_os_x/
    # also searches domains not visible in /etc/resolv.conf
    local mac_version=/usr/bin/dscacheutil
    test -x $mac_version && $mac_version -q host -a name "$@" || command host "$@"
}
ssh-remove-host() {
    ssh-keygen -R $1
    # don't forget to use the "real" host command for output stability
    for h in $(command host $1 | grep 'has address' | cut -d\  -f4); do
        ssh-keygen -R $h
    done 
}

[ -r ~/bin/rprompt ] && PROMPT_COMMAND='source ~/bin/rprompt'

if [ -r ~/tools/Mercurial/hgtab/hgtab-bash.sh ] ; then
    source ~/tools/Mercurial/hgtab/hgtab-bash.sh
fi

if $(which brew &>/dev/null); then
    source $(brew --prefix)/etc/bash_completion
fi
# to avoid "about to be deprecated" message when activating venv
# actually, keep for now, need to rewrite prompt functions first
export PIP_REQUIRE_VIRTUALENV=true

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end


# Misc local files (*.rc for bashrc time, *.sh for bash_profile time)
for f in ~/.local/etc/profile.d/*.rc; do
    source $f
done
