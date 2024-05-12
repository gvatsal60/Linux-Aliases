# shellcheck shell=sh

# Function to check if .aliases.sh is sourced in specified rc file and append it if not
check_sourcing() {
    chmod +x "$HOME/.aliases.sh"

    # Check if .aliases.sh is sourced in specified rc file, if not append it
    if ! grep -qxF "source \"${HOME}/.aliases.sh\"" "$HOME/$1"; then
        printf "\n# Sourcing custom aliases" >>"${HOME}/$1"
        echo "source \"\${HOME}/.aliases.sh\"" >>"${HOME}/$1"
    fi

    if [ -r "${HOME}/$1" ]; then
        # shellcheck source=/dev/null
        if ! . "${HOME}/$1"; then
            echo "Error: Unable to source ${HOME}/$1"
        else
            echo "Sourced ${HOME}/$1 successfully."
        fi
    else
        echo "Error: File ${HOME}/$1 does not exist or is not readable."
    fi
}

# Function to check if rc file exists and call check_sourcing accordingly
check_rc_files() {
    # Check if .bashrc exists
    if [ -f "$HOME/.bashrc" ]; then
        check_sourcing .bashrc
    # Check if .zshrc exists
    elif [ -f "$HOME/.zshrc" ]; then
        check_sourcing .zshrc
    else
        echo "Error: rc(bashrc/zshrc/...) file not found. Please ensure it exists."
    fi
}

# Function to download alias file using wget
dw_alias_file_wget() {
    wget -O "$HOME/.aliases.sh" "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/master/.aliases.sh"
    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file using curl
dw_alias_file_curl() {
    curl -o "$HOME/.aliases.sh" "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/master/.aliases.sh"
    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file using git
dw_alias_file_git() {
    git clone --depth=1 "https://github.com/gvatsal60/Linux-Aliases.git" "$HOME/.aliases"
    cp "$HOME/.aliases/.aliases.sh" "$HOME/.aliases.sh"
    rm -rf "$HOME/.aliases"

    check_rc_files # Call function to check rc files after downloading alias file
}

if [ -f "$HOME/.aliases.sh" ]; then
    echo "File already exists: $HOME/.aliases.sh"
else
    # Check if wget is available
    if command -v wget >/dev/null 2>&1; then
        dw_alias_file_wget # Call function to download alias file using wget
    # Check if curl is available
    elif command -v curl >/dev/null 2>&1; then
        dw_alias_file_curl # Call function to download alias file using curl
    # Check if git is available
    elif command -v git >/dev/null 2>&1; then
        dw_alias_file_git # Call function to download alias file using git
    else
        echo "Either install wget, curl, or git"
    fi
fi
