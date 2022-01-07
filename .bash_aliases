alias pg='psql -U postgres'
alias redis='redis-server'
alias wf='cat /mnt/c/Code/workflow.txt'
alias cpdotfiles='echo Copy .vimrc && cp ~/.vimrc /mnt/c/Code/dotfiles/ &&
  echo Copy .bash_aliases && cp ~/.bash_aliases /mnt/c/Code/dotfiles/ &&
<<<<<<< HEAD
  echo Copy .gitconfig && cp ~/.gitconfig /mnt/c/Code/dotfiles/ &&
=======
  echo Copy .gitconfig && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
>>>>>>> 589bc777d4d42a6d177ade64bfff06f17f3ccee0
  echo Copy .psqlrc && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
  echo Copy .pspgconf && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
  cd /mnt/c/Code/dotfiles/ &&
  echo &&
  git status -sb &&
  echo &&
  git diff &&
  echo'
