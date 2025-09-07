#!/bin/sh

###################################################################################################
# File: install.sh
# Author: [Vatsal Gupta (gvatsal60)]
# Date: 12-Jul-2024
# Description: Setup of custom aliases on a Linux system by downloading a
#              predefined .aliases.sh file from a GitHub repository and
#              integrating it into the user's shell configuration
#              files (~/.bashrc, ~/.zshrc, or ~/.profile)
###################################################################################################

###################################################################################################
# License
###################################################################################################
# This script is licensed under the Apache 2.0 License.

###################################################################################################
# Global Variables & Constants
###################################################################################################
# Exit the script immediately if any command fails
set -e

readonly FILE_NAME=".aliases.sh"
readonly FILE_PATH="${HOME}/${FILE_NAME}"
readonly ALIAS_SRC_URL="https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/HEAD/${FILE_NAME}"

readonly ALIAS_SEARCH_STR="\. \"${FILE_PATH}\""

ALIAS_SOURCE_STR=$(
    cat <<EOF

# Common and useful aliases
if [ -f "${FILE_PATH}" ]; then
 . "${FILE_PATH}"
fi
EOF
)

###################################################################################################
# Functions
###################################################################################################

# Function: println
# Description: Prints a message to the console, followed by a newline.
# Usage: println "Your message here"
println() {
    printf "%s\n" "$*" 2>/dev/null
}

# Function: print_err
# Description: Prints an error message to the console, followed by a newline.
# Usage: print_err "Your error message here"
print_err() {
    printf "%s\n" "$*" >&2
}

# Function: update_rc
# Description: Update shell configuration files
update_rc() {
    _rc=""
    case ${ADJUSTED_ID} in
    debian | rhel)
        _rc="${HOME}/.bashrc"
        ;;
    alpine | arch)
        _rc="${HOME}/.profile"
        ;;
    darwin)
        _rc="${HOME}/.zshrc"
        ;;
    *)
        print_err "Error: Unsupported or unrecognized OS distribution ${ADJUSTED_ID}"
        exit 1
        ;;
    esac

    # Check if ".aliases.sh" is already sourced, if not then append it
    if [ -f "${_rc}" ]; then
        if ! grep -qsE "${ALIAS_SEARCH_STR}" "${_rc}"; then
            println "=> Updating ${_rc} for ${ADJUSTED_ID}..."
            # Append the sourcing block to the RC file
            println "${ALIAS_SOURCE_STR}" >>"${_rc}"
        fi
    else
        # Notify if the rc file does not exist
        println "=> Profile not found. ${_rc} does not exist."
        println "=> Creating the file ${_rc}... Please note that this may not work as expected."
        # Create the rc file
        touch "${_rc}"
        # Append the sourcing block to the newly created rc file
        println "${ALIAS_SOURCE_STR}" >>"${_rc}"
    fi

    println ""
    println "=> Close and reopen your terminal to start using aliases"
    println "   OR"
    println "=> Run the following to use it now:"
    println ">>> source ${_rc} # This loads aliases"
}

# Function: dw_file
# Description: Download file using wget or curl if available
dw_file() {
    # Check if curl is available
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL -o "${FILE_PATH}" "${ALIAS_SRC_URL}"
    # Check if wget is available
    elif command -v wget >/dev/null 2>&1; then
        wget -O "${FILE_PATH}" "${ALIAS_SRC_URL}"
    else
        print_err "Error: Either install wget or curl"
        exit 1
    fi
}

###################################################################################################
# Main Script
###################################################################################################

OS=$(uname)

case ${OS} in
Darwin)
    ADJUSTED_ID="darwin"
    ;;
Linux)
    # Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
    # shellcheck source=/dev/null
    . /etc/os-release

    # Get an adjusted ID independent of distro variants
    if [ "${ID}" = "debian" ] || [ "${ID_LIKE#*debian}" != "${ID_LIKE}" ]; then
        ADJUSTED_ID="debian"
    elif [ "${ID}" = "arch" ] || [ "${ID_LIKE#*arch}" != "${ID_LIKE}" ]; then
        ADJUSTED_ID="arch"
    elif [ "${ID}" = "rhel" ] || [ "${ID}" = "fedora" ] || [ "${ID}" = "mariner" ] || [ "${ID_LIKE#*rhel}" != "${ID_LIKE}" ] || [ "${ID_LIKE#*fedora}" != "${ID_LIKE}" ] || [ "${ID_LIKE#*mariner}" != "${ID_LIKE}" ]; then
        ADJUSTED_ID="rhel"
    elif [ "${ID}" = "alpine" ]; then
        ADJUSTED_ID="alpine"
    else
        print_err "Error: Linux distro ${ID} not supported."
        exit 1
    fi
    ;;
*)
    print_err "Error: Unsupported or unrecognized OS distribution ${ADJUSTED_ID}"
    exit 1
    ;;
esac

# Default behavior
_action="y"

# Check if the script is running in interactive mode, for non-interactive mode `_action` defaults to 'y'
if [ -t 0 ]; then
    # Interactive mode
    if [ -f "${FILE_PATH}" ]; then
        println "=> File already exists: ${FILE_PATH}"
        println "=> Do you want to replace it (default: y)? [y/n]: "
        # Read input, use default value if no input is given
        read -r _rp_conf
        _rp_conf="${_rp_conf:-${_action}}"
        _action="${_rp_conf}"
    fi
fi

if [ "${_action}" = "y" ]; then
    println "=> Updating the file: ${FILE_PATH}"
    # Download the necessary file from the specified source
    dw_file
    # Update the configuration file with the latest changes
    update_rc
elif [ "${_action}" = "n" ]; then
    println "=> Keeping existing file: ${FILE_PATH}"
else
    print_err "Error: Invalid input. Please check your entry and try again."
    exit 1
fi
