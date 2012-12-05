set -o vi

export MOZ_USER=${MOZ_USER:-hwine}

alias ll=ls\ -lF
alias ls=ls\ -F

if [ -r /usr/share/vim/vim73/macros/less.sh ]; then
    lessc() { /usr/share/vim/vim73/macros/less.sh "$@"; }
else
    lessc() { less "$@"; }
fi

if type -p lesspipe.sh &>/dev/null ; then
    export LESSOPEN="|lesspipe.sh %s"
fi

function jsonlint() { python -c "import json; json.load(open('$1'))"; }

[ -r ~/bin/rprompt ] && PROMPT_COMMAND='source ~/bin/rprompt'

if [ -r ~/bin/virtualenvwrapper.sh ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    source ~/bin/virtualenvwrapper.sh
elif [ -r ~/bin/virtualenvwrapper_bashrc ] ; then
    export WORKON_HOME=$HOME/.virtualenvs
    source ~/bin/virtualenvwrapper_bashrc
fi

if [ -r ~/tools/Mercurial/hgtab/hgtab-bash.sh ] ; then
    source ~/tools/Mercurial/hgtab/hgtab-bash.sh
fi

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
