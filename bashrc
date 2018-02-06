echo "bash_profile \$HOME='$HOME', ~='$(ls -d ~)'" >>/tmp/new.log
set -o vi

export MOZ_USER=${MOZ_USER:-hwine}
export PASTEBIN_NAME=${PASTEBIN_NAME:-hwine}
export VISUAL=nvim
export EDITOR=nvim

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

function tmux() { export TERM=screen-256color-bce ; command tmux "$@" ; }
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

# switching to using `pew` as the accessor, for the pyenv managed
# versions DANGER DANGER
# Switch to use approach from
#   https://medium.com/@henriquebastos/the-definitive-guide-to-setup-my-python-workspace-628d68552e14
export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/repos
eval "$(pyenv init -)"
# pyenv virtualenvwrapper_lazy


if [ -r ~/tools/Mercurial/hgtab/hgtab-bash.sh ] ; then
    source ~/tools/Mercurial/hgtab/hgtab-bash.sh
fi

source $(brew --prefix)/etc/bash_completion
# to avoid "about to be deprecated" message when activating venv
# actually, keep for now, need to rewrite prompt functions first
export PYENV_VIRTUALENV_DISABLE_PROMPT=0
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

# pipenv & pew bash completion start
if $(which pew &>/dev/null) ; then
    source $(pew shell_config)
fi
if $(which pipenv &>/dev/null); then
    eval $(env _PIPENV_COMPLETE=source-bash pipenv)
fi
# pipenv & pew bash completion end

# Misc local files
for f in ~/.local/etc/profile.d/*; do
    source $f
done
