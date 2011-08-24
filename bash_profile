[ -r /etc/profile ] && . /etc/profile
[ -r ~/.bashrc ] && . ~/.bashrc

# strip sbin directories from path
# can't do - too many "normal" utils there
#export PATH=$(echo $PATH | sed -e 's!:[^:]*/sbin:!:!g')

export HISTCONTROL=ignoreboth

# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
#PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"

# add X11 paths if xterm
case $TERM in
xterm)
    PATH=$PATH:/usr/X11R6/bin
    ;;
esac

export PATH

# the above path trick on Tiger ensures Terminal doesn't get X11 in
# path, but we do want to use xterm-color (Terminal's default TERM) if
# we are under X, so don't change until after the path manipulations
test -n "$DISPLAY" && TERM=xterm-color || :

# For Leopard 10.5.4, X & xterm are horribly broken, so have to use
# terminal. However xterm-color is broken on terminal w.r.t. screen on
# linux, so force to normal xterm. However, can no longer test $DISPLAY
# to determine this, due to "launch X on demand" settins (it's always
# set to a socket). This gets messy, so just default to xterm everywhere
# for now (2008-08-03)
TERM=xterm

# Set the auth socket in .bash_profile, so it works with ShellHere.app
#if test -z "$SSH_AUTH_SOCK" -a -z "$SSH_TTY" ; then
if test -z "$SSH_TTY" ; then
    SSH_AUTH_SOCK=/tmp/502/SSHKeychain.socket
    export SSH_AUTH_SOCK
fi
