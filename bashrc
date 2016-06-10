set -o vi

export MOZ_USER=${MOZ_USER:-hwine}
export PASTEBIN_NAME=${PASTEBIN_NAME:-hwine}
export VISUAL=vim

alias ll=ls\ -lFG
alias ls=ls\ -FG

if [ -r /usr/share/vim/vim73/macros/less.sh ]; then
    lessc() { /usr/share/vim/vim73/macros/less.sh "$@"; }
else
    lessc() { less "$@"; }
fi

if type -p lesspipe.sh &>/dev/null ; then
    export LESSOPEN="|lesspipe.sh %s"
fi

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

if [ -r ~/bin/virtualenvwrapper.sh ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    source ~/bin/virtualenvwrapper.sh
elif [ -r ~/bin/virtualenvwrapper_bashrc ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    source ~/bin/virtualenvwrapper_bashrc
fi

if [ -r ~/bin/na.sh ] ; then
    # from https://github.com/ttscoff/na
    source ~/bin/na.sh
fi

if [ -r ~/tools/Mercurial/hgtab/hgtab-bash.sh ] ; then
    source ~/tools/Mercurial/hgtab/hgtab-bash.sh
fi

source $(brew --prefix)/etc/bash_completion
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# to avoid "about to be deprecated" message when activating venv
# actually, keep for now, need to rewrite prompt functions first
export PYENV_VIRTUALENV_DISABLE_PROMPT=0
