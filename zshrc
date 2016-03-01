## antigen stuff
source ~/etc/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle virtualenv
antigen bundle virtualenvwrapper
antigen bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-history-substring-search

antigen theme https://gist.github.com/matsen/538ae7357d9a0ecbe714 gallifrey-ve

# Tell antigen that you're done.
antigen apply


## do everything else

function cond_source () {
  [ -f $1 ] && . $1
}

# shell is interactive?
if [[ $- =~ i ]]; then
  for what in aliases variables shell commands; do
    source      $HOME/.zsh/$what.sh
    cond_source $HOME/.zsh/local/$what.sh
  done
fi


_MODULE_INIT_PATH='/app/Modules/3.2.10/init/zsh'
if [ -f $_MODULE_INIT_PATH ]; then
  source $_MODULE_INIT_PATH
fi
unset $_MODULE_INIT_PATH

module -v use ${MATSENGRP}/modules
module -v use $HOME/modules
module load matsengrp-local
