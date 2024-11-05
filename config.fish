if status is-interactive
    set -gx EDITOR vim
    ~/.rbenv/bin/rbenv init - fish | source

    # aliases
    alias dry='ruby lib/dry.rb'
    alias pg='psql -U postgres acsiv_development'
    alias r='bin/dev'

    alias cpdotfiles='cp ~/.vimrc ~/code/dotfiles/ &&
                      cp ~/.gitconfig ~/code/dotfiles/ &&
                      cp ~/.psqlrc ~/code/dotfiles/ &&
                      cp ~/.pspgconf ~/code/dotfiles/ &&
                      cp ~/.config/fish/config.fish ~/code/dotfiles/ &&                      
                      cp ~/.config/fish/functions/bat.fish ~/code/dotfiles/ &&
                      cd ~/code/dotfiles/ &&
                      git status -sb &&
                      echo &&
                      git diff &&
                      echo'

    cd code/acsiv
end
