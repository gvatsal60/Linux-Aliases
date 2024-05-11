# Common Bash Aliases
# List files in column format
alias l='ls -CF'
# List files in long format with details
alias ll='ls -alF'
# List all files except . and ..
alias la='ls -A'
# Enable colorized ls output
alias ls='ls --color=auto'
# List files with human-readable sizes, one file per line, sorted by size
alias lt='ls --human-readable --size -1 -S --classify'
# Show hidden files in long format
alias lh='ls -alh'
# Quickly access recently modified files
alias recent='ls -lt | head'
# Count files and directories in the current directory
alias count='ls -1 | wc -l'
# Go up one directory
alias ..='cd ..'
# Go up two directories
alias ...='cd ../..'
# Print current directory
alias p='pwd'
# Create directory and parents if not exists
alias mkdir='mkdir -p'
# Clear the screen
alias cl='clear && clear'
# Show command history
alias h='history'
# List active jobs
alias j='jobs # List active jobs'
# View disk usage of current directory and its subdirectories in human-readable format
alias duh='du -h'
# View disk usage of each file and directory in current directory in human-readable format
alias du1='du -h --max-depth=1'
# Show running processes
alias psa='ps aux'
# Show processes in tree format
alias pstree='pstree -p'
# Display system uptime and load average
alias uptime='uptime && echo "Load average over the last 1 minute: $(cat /proc/loadavg | cut -d " " -f 1)"'
# Extract various archive formats
alias untar='tar -zxvf'
alias unzip='unzip'
# View and search through manual pages easily
alias man='man -P less'
# Quickly find out the size of a file or directory
alias size='du -sh'
# Display calendar for the current month
alias cal='cal -3'
# View network connections
alias netstat='netstat -tuln'
# View listening ports
alias ports='netstat -tuln | grep LISTEN'
# View top CPU consuming processes
alias topcpu='ps aux --sort=-%cpu | head -n 11'
# View top memory consuming processes
alias topmem='ps aux --sort=-%mem | head -n 11'
# Enable colorized grep output
alias grep='grep --color=auto'
# Use Vim as default text editor
alias vi='vim'

# Git Aliases
# Shortcut to check the status of the current git repository
alias gts='git status'
# Show the difference between the working directory and the index, ignoring changes in whitespace
alias gtdf='git diff --ignore-space-change'
# Update submodules to the latest commit on their respective branches
alias gsupdate='git submodule update --init --recursive'
# Switch to a different branch or restore working tree files
alias gtc='git checkout'
# Remove untracked files and directories from the working tree (with confirmation)
# alias gtclean='git clean -fd' # For forced removal
alias gtclean='git clean -i' # For interactive removal
# Delete all local branches except "master" and "main" (with confirmation)
alias gtcbd='read -p "This will delete all local branches except master and main. Continue? [y/n]: " confirmation && [ "$confirmation" == "y" ] && git for-each-ref --format "%(refname:short)" refs/heads | grep -vE "^(master|main)$" | xargs git branch -d'
# Shortcut to pull changes from the remote repository into the current branch
alias gtp='git pull'
