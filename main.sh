#!/bin/sh

##########################################################################################
# Developer Information
##########################################################################################
# Developer's Name and Contact Information
developer_name="[Vatsal Gupta]"
developer_telegram="[https://t.me/gvatsal60]"
repository_link="[https://github.com/gvatsal60/Linux-Aliases]"

# Display developer information
echo "Developer: $developer_name"
echo "Contact: $developer_telegram"
echo "Repository: $repository_link"

##########################################################################################
# License Information
##########################################################################################
# License
license_name="Apache-2.0 license"
license_link="[https://github.com/gvatsal60/Linux-Aliases/blob/HEAD/LICENSE]"

# Display license information
echo "License: $license_name"
echo "For details, please see the $license_name located at: $license_link"

##########################################################################################
# Functions
##########################################################################################
# Function to check if .aliases.sh is sourced in specified rc file and append it if not
check_sourcing() {
    chmod +x "$HOME/.aliases.sh"

    # Check if .aliases.sh is sourced in specified rc file, if not append it
    if ! grep -qxF ". \"\$HOME/.aliases.sh\"" "$HOME/$1"; then
        printf "\n# Sourcing custom aliases\n" >> "${HOME}/$1"
        echo ". \"\$HOME/.aliases.sh\"" >> "${HOME}/$1"
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
    # Check if .profile exists
    elif [ -f "$HOME/.profile" ]; then
        check_sourcing .profile
    else
        echo "Error: rc(bashrc/zshrc/profile) file not found. Please ensure it exists."
    fi
}

# Function to download alias file using wget
dw_alias_file_wget() {
    wget -O "$HOME/.aliases.sh" "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/HEAD/.aliases.sh"
    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file using curl
dw_alias_file_curl() {
    curl -fsSL -o "$HOME/.aliases.sh" "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/HEAD/.aliases.sh"
    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file using git
dw_alias_file_git() {
    git clone --depth=1 "https://github.com/gvatsal60/Linux-Aliases.git" "$HOME/.aliases"
    cp "$HOME/.aliases/.aliases.sh" "$HOME/.aliases.sh"
    rm -rf "$HOME/.aliases"

    check_rc_files # Call function to check rc files after downloading alias file
}

# Function to download alias file
dw_alias_file() {
    # Check if wget is available
    if command -v wget &>/dev/null; then
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
}

# Main Function
main() {
    if [ -f "$HOME/.aliases.sh" ]; then
        printf "File already exists: %s\n" "$HOME/.aliases.sh"
        printf "Do you want to replace it? [y/n]: "
        read -r replace_confirmation
        replace_confirmation="${replace_confirmation:-y}"
        if [ "$replace_confirmation" = "y" ]; then
            # Replace the existing file
            printf "\nReplacing %s...\n" "$HOME/.aliases.sh"
            dw_alias_file
        else
            printf "\nKeeping existing file: %s\n" "$HOME/.aliases.sh"
        fi
    else
        dw_alias_file
    fi
}

##########################################################################################
# Execution
##########################################################################################
echo ""
main
