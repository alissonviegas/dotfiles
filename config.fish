if status is-interactive
    status --is-interactive; and source (rbenv init -|psub)

    # aliases
    alias dry='ruby lib/dry.rb'
    alias pg='psql -U postgres acsiv_development'
    alias r='bin/dev'
    alias redis='redis-server'
    alias sidekiq='bundle exec sidekiq'

    alias cpdotfiles='echo Copy .vimrc && cp ~/.vimrc ~/code/dotfiles/ &&
                      echo Copy .gitconfig && cp ~/.gitconfig ~/code/dotfiles/ &&
                      echo Copy .psqlrc && cp ~/.psqlrc ~/code/dotfiles/ &&
                      echo Copy .pspgconf && cp ~/.pspgconf ~/code/dotfiles/ &&
                      echo Copy config.fish && cp ~/.config/fish/config.fish ~/code/dotfiles/ &&
                      echo Copy fish_plugins && cp ~/.config/fish/fish_plugins ~/code/dotfiles/ &&
                      echo Copy fish_prompt && cp ~/.config/fish/functions/fish_prompt.fish ~/code/dotfiles/ &&
                      echo Copy fish_functions && cp ~/.config/fish/functions/bat.fish ~/code/dotfiles/ &&
                      cd ~/code/dotfiles/ &&
                      echo &&
                      git status -sb &&
                      echo &&
                      git diff &&
                      echo'

    cd code/acsiv
end
