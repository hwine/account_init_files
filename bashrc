set -o vi

alias ll=ls\ -lF
alias ls=ls\ -F

if [ -r /usr/share/vim/vim73/macros/less.sh ]; then
    lessc() { /usr/share/vim/vim73/macros/less.sh "$@"; }
else
    lessc() { less "$@"; }
fi

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
