export HISTCONTROL=ignoreboth
if test $SHLVL -le 3; then
    # 1 is first shell, 2 is first shell in screen, 3 is first shell in tmux
    # be sure not to export
    IGNOREEOF=3
fi

export PATH

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
