#!/bin/sh
###################################################################################################
# Aliases Script
# Author: [Vatsal Gupta]
# Description: This script defines convenient aliases for common commands.
# Usage: Source this script in your shell profile (e.g., ~/.bashrc, ~/.zshrc).
###################################################################################################

###################################################################################################
# File Management
###################################################################################################
alias l='ls -CF'                                       # List files in column format
alias ll='ls -alF'                                     # List files in long format with details
alias la='ls -A'                                       # List all files except . and ..
alias ls='ls --color=auto'                             # Enable colorized ls output
alias lt='ls --human-readable --size -1 -S --classify' # List files with human-readable sizes, one file per line, sorted by size
alias lh='ls -alh'                                     # Show hidden files in long format
alias recent='ls -lt | head'                           # Quickly access recently modified files
alias count='ls -1 | wc -l'                            # Count files and directories in the current directory
alias p='pwd'                                          # Print current directory
alias mkdir='mkdir -p'                                 # Create directory and parents if not exists

###################################################################################################
# Navigation
###################################################################################################
alias ..='cd ..'     # Go up one directory
alias ...='cd ../..' # Go up two directories

###################################################################################################
# System Information
###################################################################################################
alias cl='clear && clear'                                                                                   # Clear the screen
alias h='history'                                                                                           # Show command history
alias j='jobs # List active jobs'                                                                           # List active jobs
alias duh='du -h'                                                                                           # View disk usage of current directory and its subdirectories in human-readable format
alias du1='du -h --max-depth=1'                                                                             # View disk usage of each file and directory in current directory in human-readable format
alias psa='ps aux'                                                                                          # Show running processes
alias pstree='pstree -p'                                                                                    # Show processes in tree format
alias uptime='uptime && echo "Load average over the last 1 minute: $(cat /proc/loadavg | cut -d " " -f 1)"' # Display system uptime and load average
alias size='du -sh'                                                                                         # Quickly find out the size of a file or directory
alias cal='cal -3'                                                                                          # Display calendar for the current month
alias netstat='netstat -tuln'                                                                               # View network connections
alias ports='netstat -tuln | grep LISTEN'                                                                   # View listening ports
alias topcpu='ps aux --sort=-%cpu | head -n 11'                                                             # View top CPU consuming processes
alias topmem='ps aux --sort=-%mem | head -n 11'                                                             # View top memory consuming processes

###################################################################################################
# Tools
###################################################################################################
alias untar='tar -zxvf' # Extract various archive formats
alias unzip='unzip'     # Extract zip archives
alias man='man -P less' # View and search through manual pages easily

###################################################################################################
# Text Processing
###################################################################################################
alias grep='grep --color=auto' # Enable colorized grep output

###################################################################################################
# Miscellaneous
###################################################################################################
alias vi='vim' # Use Vim as default text editor
alias q='exit' # Exit the current shell session

###################################################################################################
# Git
###################################################################################################
alias gts='git status'                                   # Check Git status
alias gtp='git pull'                                     # Pull changes from remote repository
alias gtdf='git diff --ignore-space-change'              # Show diff, ignoring changes in whitespace
alias gsupdate='git submodule update --init --recursive' # Update submodules
alias gtc='git checkout'                                 # Switch branches or restore working tree files
alias gtclean='git clean -i'                             # Remove untracked files and directories interactively
alias gcm='git commit'                                   # Committing changes
alias gd='git diff'                                      # Showing differences
alias gb='git branch'                                    # Managing branches
alias ga='git add'                                       # Staging changes
alias glpo='git log --pretty=oneline'                    # Concise commit history

# Delete all local branches except "master" and "main" with confirmation
alias gtcbd='git for-each-ref --format "%(refname:short)" refs/heads | grep -vE "^(master|main)$" | xargs git branch -d'

###################################################################################################
# Docker
###################################################################################################
# Docker Compose
alias dc='docker-compose'            # Shortcut for 'docker-compose'
alias dce='docker-compose exec'      # Execute a command inside a running container
alias dcr='docker-compose run --rm'  # Run a one-off command in a new container and remove it after execution
alias dcb='docker-compose build'     # Build or rebuild services
alias dcl='docker-compose logs'      # View output from containers
alias dcpf='docker-compose pause'    # Pause services
alias dcunp='docker-compose unpause' # Unpause services
alias dcps='docker-compose ps'       # List containers
alias dcup='docker-compose up'       # Start services
alias dcud='docker-compose up -d'    # Start services in detached mode
alias dcstp='docker-compose stop'    # Stop services
alias dcstart='docker-compose start' # Start services
alias dcrmv='docker-compose rm -v'   # Remove stopped service containers and associated volumes
alias dcvol='docker volume'          # Docker volume commands

# Docker Container and Image Management
alias dps='docker ps -a'        # List all containers, both running and stopped
alias drm='docker container rm' # Remove one or more containers
alias dimg='docker image'       # Docker image commands
alias dimgs='docker image ls'   # Docker image list command

# Miscellaneous
alias dkall='docker kill $(docker ps -q)' # Kill all running containers

###################################################################################################
# Terraform
###################################################################################################
alias tf='terraform'                     # Shortcut for 'terraform'
alias tfi='terraform init'               # Initialize a new or existing Terraform configuration
alias tfa='terraform apply'              # Apply changes required to reach the desired state
alias tfp='terraform plan'               # Generate and show an execution plan
alias tfd='terraform destroy'            # Destroy Terraform-managed infrastructure
alias tfws='terraform workspace'         # Easily manage Terraform workspaces
alias tfwsl='terraform workspace list'   # List all Terraform workspaces
alias tfwsc='terraform workspace select' # Select a Terraform workspace to use
