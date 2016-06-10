export HISTCONTROL=ignoreboth
if test $SHLVL -le 4; then
    # 1 is first shell, 2 is first shell in screen, 4 is first shell in tmux
    # be sure not to export
    IGNOREEOF=3
fi

export PATH

update_path() {
    if test -d "$1" ; then
        case ":$PATH:" in
        *:$1:*) ;; # already in
        *) export PATH="$1:$PATH" ;;
        esac
    fi
}
# homebrew
update_path /usr/local/bin

# new "standard"
update_path "$HOME/.local/bin"

# my stuff
update_path $HOME/bin 

# wait to do this until path is set
#[ -r /etc/profile ] && . /etc/profile
[ -r ~/.bashrc ] && . ~/.bashrc

if test "${OSTYPE}" != "${OSTYPE#darwin}" ; then
    function mdhere () { mdfind -onlyin . "$@" ; }
    export mdhere
fi
export GOPATH=$HOME/go
