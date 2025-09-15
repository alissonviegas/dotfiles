if status is-interactive
    set -gx EDITOR vim

    ~/.rbenv/bin/rbenv init - fish | source

    # aliases
    alias dry='ruby lib/dry.rb'
    alias pg='psql -U postgres acsiv_development'
    alias r='bin/rails server -p 3000'
    alias rmprepush='rm .git/hooks/pre-push'

    cd code/acsiv
end
