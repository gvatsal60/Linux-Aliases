# Function to check if .aliases.sh is sourced in specified rc file and append it if not
check_sourcing() {
    # Check if .aliases.sh is sourced in specified rc file, if not append it
    if ! grep -qxF 'source "$HOME/.aliases.sh"' "$HOME/$1"; then
        echo "source \"\${HOME}/.aliases.sh\"" >>"${HOME}/$1"
    fi

    if ! source "${HOME}/$1"; then
        echo "Error: Unable to source ${HOME}/$1"
        return 1
    fi
}

# Function to check if rc file exists and call check_sourcing accordingly
check_rc_files() {
    chmod +x "$HOME/.aliases.sh"

    chmod +x "${HOME}/.aliases.sh"

    # Check if .rc file exists
    case "$HOME" in
        *".bashrc"*) check_sourcing .bashrc ;;
        *".zshrc"*) check_sourcing .zshrc ;;
        *) echo "Error: rc (bashrc/zshrc/...) file not found. Please ensure it exists." ;;
    esac
}

# Function to download alias file using wget
function dw_alias_file_wget() {
    wget -O "$HOME/.aliases.sh" "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/master/.aliases.sh"
    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file using curl
function dw_alias_file_curl() {
    curl -o "$HOME/.aliases.sh" "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/master/.aliases.sh"
    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file using git
function dw_alias_file_git() {
    git clone --depth=1 "https://github.com/gvatsal60/Linux-Aliases.git" "$HOME/.aliases"
    cp "$HOME/.aliases/.aliases.sh" "$HOME/.aliases.sh"
    rm -rf "$HOME/.aliases"

    check_rc_files # Call function to check rc files after downloading alias file
}

# Check if wget is available
if command -v wget &>/dev/null; then
    dw_alias_file_wget # Call function to download alias file using wget
# Check if curl is available
elif command -v curl &>/dev/null; then
    dw_alias_file_curl # Call function to download alias file using curl
# Check if git is available
elif command -v git &>/dev/null; then
    dw_alias_file_git # Call function to download alias file using git
else
    echo "Either install wget, curl, or git"
fi
