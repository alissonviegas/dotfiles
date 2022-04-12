alias ms='mailcatcher && bundle exec sidekiq'
alias pg='psql -U postgres'
alias r='rails s'
alias redis='redis-server'
alias wf="echo Git alias: && echo ========== &&
  grep -zoP '(?s)(?<=\[alias]\n)(.*)(?=\[core)' --color=never ~/.gitconfig | cut -f2 -d$'\t' &&
  cat /home/alisson/code/workflow.txt"

alias cpdotfiles='echo Copy .vimrc && cp ~/.vimrc /home/alisson/code/dotfiles/ &&
  echo Copy .bash_aliases && cp ~/.bash_aliases /home/alisson/code/dotfiles/ &&
  echo Copy .gitconfig && cp ~/.gitconfig /home/alisson/code/dotfiles/ &&
  echo Copy .psqlrc && cp ~/.psqlrc /home/alisson/code/dotfiles/ &&
  echo Copy .pspgconf && cp ~/.psqlrc /home/alisson/code/dotfiles/ &&
  cd /home/alisson/code/dotfiles/ &&
  echo &&
  git status -sb &&
  echo &&
  git diff &&
  echo'
