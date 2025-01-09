# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

alias nix-clean="nix-collect-garbage && nix-collect-garbage -d"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/super/.conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/super/.conda/etc/profile.d/conda.sh" ]; then
        . "/home/super/.conda/etc/profile.d/conda.sh"
    else
        export PATH="/home/super/.conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Enable colors
reset_color="\[\033[0m\]"
bold="\[\033[1m\]"

# Colors
user_color="\[\033[38;5;45m\]"    # Blue
host_color="\[\033[38;5;219m\]"   # Pink
dir_color="\[\033[38;5;220m\]"    # Yellow
git_branch_color="\[\033[38;5;83m\]" # Green
git_dirty_color="\[\033[38;5;196m\]" # Red
line_color="\[\033[38;5;240m\]"   # Gray

# Nerd Fonts Symbols
arrow="  "
git_icon="  "
dir_icon=""
curved_arrow="󱞩"
dollar_sign=""

parse_git_branch() {
    git branch 2>/dev/null | grep '*' | sed 's/* //'
}

parse_git_dirty() {
    [[ $(git status --porcelain 2>/dev/null) ]] && echo "✗" || echo "✔"
}

# Prompt
# PS1="\n"  # Start a new line
PS1="${user_color}\u${reset_color}@${host_color}\h${reset_color}${arrow}${dir_color}${dir_icon} \w${reset_color}\n"

PS1+="${curved_arrow}$(branch=$(parse_git_branch);[ -n "$branch" ] && echo "${git_branch_color}${git_icon}$branch $(parse_git_dirty)${reset_color}") ${dollar_sign} "

FIRST_PROMPT=true

# Function to print a horizontal line with newlines before and after (if not the first prompt)
draw_line() {
    if [ "$FIRST_PROMPT" = false ]; then
        printf '\n'                # Print a blank line before the line
        printf '\033[1;34m%*s\033[0m\n' "$(tput cols)" '' | tr ' ' '-'  # Print the horizontal line
        printf '\n'                # Print a blank line after the line
    fi
    FIRST_PROMPT=false
}

# Add the line-drawing function to PROMPT_COMMAND
PROMPT_COMMAND="draw_line; $PROMPT_COMMAND"