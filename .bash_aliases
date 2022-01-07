alias pg='psql -U postgres'
alias redis='redis-server'
alias wf='cat /mnt/c/Code/workflow.txt'
alias cpdotfiles='echo Copy .vimrc && cp ~/.vimrc /mnt/c/Code/dotfiles/ &&
  echo Copy .bash_aliases && cp ~/.bash_aliases /mnt/c/Code/dotfiles/ &&
  echo Copy .psqlrc && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
  echo Copy .pspgconf && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
  echo &&
  cd /mnt/c/Code/dotfiles/ &&
  git status &&
  git diff'
