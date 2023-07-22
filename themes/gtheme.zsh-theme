# Define custom prompt
prompt_custom() {
    # Display user
    local user_info="%F{yellow}%n%f at "

    # Display hostname
    local host_info="%F{magenta}%m%f in "

    # Display current working directory
    local dir_info="%F{blue}%~%f"

    local git_info=""
    # Display git information if inside a git repository
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        local cur_branch=$(git rev-parse --abbrev-ref HEAD)
        local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)
        
        if [[ -n "$upstream" ]]; then
            local change_matrix=($(git rev-list --left-right --count $cur_branch...$upstream))
            local npush=$change_matrix[1]
            local npull=$change_matrix[2]
            local nchanges=$(git status --porcelain | wc -l)

            git_info=" %F{cyan}($cur_branch"
            [[ $npush -gt 0 ]] && git_info+="%F{blue} ↑$npush%f"
            [[ $npull -gt 0 ]] && git_info+="%F{yellow} ↓$npull%f"
            [[ $nchanges -gt 0 ]] && git_info+="%F{red} ↑↓$nchanges%f"
            [[ $npush -eq 0 && $npull -eq 0 && $nchanges -eq 0 ]] && git_info+="%F{green} ✓%f"
            git_info+=")%f"
        else
            git_info=" %F{cyan}($cur_branch)%f"
        fi
    fi

    # Display RAM usage
    local ram_usage=$(free -h | awk 'NR==2{print $3 "/" $2}')
    local ram_info=" %F{magenta}$ram_usage%f"

    # Display virtual environment if active
    local venv_info=""
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv_info="%F{blue}(${VIRTUAL_ENV:t})%f "
    fi

    # Combine all the segments and print
    print -P "$user_info$host_info$dir_info$git_info$ram_info\n$venv_info↪ "
}

RPROMPT='%*'
PROMPT='$(prompt_custom)'


