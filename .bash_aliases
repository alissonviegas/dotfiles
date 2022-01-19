alias pg='psql -U postgres'
alias redis='redis-server'
alias ms='mailcatcher && bundle exec sidekiq'
alias wf="echo Git alias: && echo ========== &&
  grep -zoP '(?s)(?<=\[alias]\n)(.*)(?=\[core)' --color=never ~/.gitconfig | cut -f2 -d$'\t' &&
  cat /mnt/c/Code/workflow.txt"
alias cpdotfiles='echo Copy .vimrc && cp ~/.vimrc /mnt/c/Code/dotfiles/ &&
  echo Copy .bash_aliases && cp ~/.bash_aliases /mnt/c/Code/dotfiles/ &&
  echo Copy .gitconfig && cp ~/.gitconfig /mnt/c/Code/dotfiles/ &&
  echo Copy .psqlrc && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
  echo Copy .pspgconf && cp ~/.psqlrc /mnt/c/Code/dotfiles/ &&
  cd /mnt/c/Code/dotfiles/ &&
  echo &&
  git status -sb &&
  echo &&
  git diff &&
  echo'
