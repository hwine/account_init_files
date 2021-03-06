echo "bash_profile \$HOME='$HOME', ~='$(ls -d ~)'" >>/tmp/new.log
export HISTCONTROL=ignoreboth
umask 022
export DISPLAY=:0
if ! $(pgrep ssh-agent &>/dev/null); then
    eval "$(ssh-agent)"
fi
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

if test "${OSTYPE}" != "${OSTYPE#darwin}" ; then
    function mdhere () { mdfind -onlyin . "$@" ; }
    export mdhere
fi
export GOPATH=$HOME/go

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Misc local files (*.rc for bashrc time, *.sh for bash_profile time)
for f in ~/.local/etc/profile.d/*.sh; do
    source $f
done

# wait to do this until path is set
#[ -r /etc/profile ] && . /etc/profile
[ -r ~/.bashrc ] && . ~/.bashrc
if [ -r "/usr/local/opt/nvm/nvm.sh" -a -z "$NVM_DIR" ]; then
    export NVM_DIR="$HOME/.nvm"
    . "/usr/local/opt/nvm/nvm.sh"
fi

# Misc local files (*.rc for bashrc time, *.sh for bash_profile time)
for f in ~/.local/etc/profile.d/*.rc; do
    source $f
done

export PATH="$HOME/.cargo/bin:$PATH"
