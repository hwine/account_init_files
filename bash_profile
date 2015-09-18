export HISTCONTROL=ignoreboth
if test $SHLVL -le 3; then
    # 1 is first shell, 2 is first shell in screen, 3 is first shell in tmux
    # be sure not to export
    IGNOREEOF=3
fi

## add X11 paths if xterm
#case $TERM in
#xterm)
#    PATH=$PATH:/usr/X11R6/bin
#    ;;
#esac

export PATH

# the above path trick on Tiger ensures Terminal doesn't get X11 in
# path, but we do want to use xterm-color (Terminal's default TERM) if
# we are under X, so don't change until after the path manipulations
test -n "$DISPLAY" && TERM=xterm-color || :

# For Leopard 10.5.4, X & xterm are horribly broken, so have to use
# terminal. However xterm-color is broken on terminal w.r.t. screen on
# linux, so force to normal xterm. However, can no longer test $DISPLAY
# to determine this, due to "launch X on demand" settings (it's always
# set to a socket). This gets messy, so just default to xterm everywhere
# for now (2008-08-03)
TERM=xterm

# homebrew
if test -d /usr/local/bin ; then
    case ":$PATH:" in
    *:/usr/local/bin:*) ;; # already in
    *) export PATH=/usr/local/bin:$PATH ;;
    esac
fi

if test -d $HOME/bin ; then
    case ":$PATH:" in
    *:$HOME/bin:*) ;; # already in
    *) export PATH=$HOME/bin:$PATH ;;
    esac
fi
# In case machine has macports installed
# note that macports _does_ need to go first, or inconsistencies arise
if test -d /opt/local/bin ; then
    case ":$PATH:" in
    *:/opt/local/bin:*) ;; # already in
    *) export PATH=/opt/local/bin:/opt/local/sbin:$PATH ;;
    esac
fi

# wait to do this until path is set
#[ -r /etc/profile ] && . /etc/profile
[ -r ~/.bashrc ] && . ~/.bashrc

export DOCKER_HOST=tcp://localhost:4244

if test "${OSTYPE}" != "${OSTYPE#darwin}" ; then
    function mdhere () { mdfind -onlyin . "$@" ; }
    export mdhere
fi
export GOPATH=$HOME/go
