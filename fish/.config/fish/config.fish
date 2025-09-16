if status is-interactive
    set -gx EDITOR vim

    zoxide init fish | source

    alias dry='ruby lib/dry.rb'
    alias pg='psql -U postgres acsiv_development'
    alias r='bin/rails server -p 3000'
    alias rmprepush='rm .git/hooks/pre-push'

    switch (uname)
        case Darwin
            rbenv init - fish | source

        case Linux
            ~/.rbenv/bin/rbenv init - fish | source
            alias fd=fdfind
    end

    cd code/acsiv
end
