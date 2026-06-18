if status is-interactive
    set -g fish_greeting
    set -gx EDITOR vim

    ~/.local/bin/mise activate fish | source

    alias dry='ruby lib/dry.rb'
    alias fd=fdfind
    alias pg='psql -U alisson acsiv_development'
    alias r='bin/rails server -p 3000'
    alias rmprepush='rm .git/hooks/pre-push'
    alias y='yarn install && yarn build && yarn build:css'

    cd ~/code/acsiv/
end
