#!/bin/sh

##########################################################################################
# File: install.sh
# Author: Vatsal Gupta
# Date: 12-Jul-2024
# Description: Setup of custom aliases on a Linux system by downloading a
#              predefined .aliases.sh file from a GitHub repository and
#              integrating it into the user's shell configuration
#              files (~/.bashrc, ~/.zshrc, or ~/.profile)
##########################################################################################

##########################################################################################
# License
##########################################################################################
# This script is licensed under the Apache 2.0 License.

##########################################################################################
# Global Variables & Constants
##########################################################################################
readonly FILE_NAME=".aliases.sh"
readonly FILE_PATH="${HOME}/${FILE_NAME}"
readonly FILE_LINK="https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/HEAD/${FILE_NAME}"

UPDATE_RC="${UPDATE_RC:-"true"}"

##########################################################################################
# Functions
##########################################################################################
# Function: updaterc
# Description: Update shell configuration files
updaterc() {
    _rc=""
    if [ "${UPDATE_RC}" = "true" ]; then
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
            echo "Error: Unsupported or unrecognized os distribution ${ADJUSTED_ID}"
            exit 1
            ;;
        esac

        # Check if "~.aliases.sh" is already sourced, if not then append it
        ALIAS_SOURCE_BLOCK=$(printf "# BEGIN ALIAS_SOURCE_BLOCK\nif [ -f \"%s\" ]; then\n . \"%s\"\nfi\n# END ALIAS_SOURCE_BLOCK\n" "${FILE_PATH}" "${FILE_PATH}")
        ALIAS_SEARCH_BLOCK=$(printf "# BEGIN ALIAS_SOURCE_BLOCK\n%s\n" "${FILE_PATH}")

        if [ -f "${_rc}" ]; then
            if ! grep -qxF "${ALIAS_SEARCH_BLOCK}" "${_rc}"; then
                echo "Updating ${_rc} for ${ADJUSTED_ID}..."
                # Append the sourcing block to the RC file
                printf "\n%s" "${ALIAS_SOURCE_BLOCK}" >> "${_rc}"
            fi
        else
            # Notify if the rc file does not exist
            echo "Error: File ${_rc} does not exist."
            echo "Creating the ${_rc} file... although not sure if it will work."
            # Create the rc file
            touch "${_rc}"
            # Append the sourcing block to the newly created rc file
            printf "\n%s" "${ALIAS_SOURCE_BLOCK}" >> "${_rc}"
        fi

        if [ -f "${_rc}" ]; then
            # shellcheck source=/dev/null
            . "${_rc}"
        fi
    fi
}

# Function: dw_file
# Description: Download file using wget or curl if available
dw_file() {
    # Check if curl is available
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL -o "${HOME}/${FILE_NAME}" ${FILE_LINK}
    # Check if wget is available
    elif command -v wget >/dev/null 2>&1; then
        wget -O "${HOME}/${FILE_NAME}" ${FILE_LINK}
    else
        echo "Error: Either install wget or curl"
        exit 1
    fi
}

##########################################################################################
# Main Script
##########################################################################################

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
    if [ "${ID}" = "debian" ] || (echo "${ID_LIKE}" | grep -q "debian"); then
        ADJUSTED_ID="debian"
    elif [ "${ID}" = "arch" ] || (echo "${ID_LIKE}" | grep -q "arch"); then
        ADJUSTED_ID="arch"
    elif [ "${ID}" = "rhel" ] || [ "${ID}" = "fedora" ] || [ "${ID}" = "mariner" ] || (echo "${ID_LIKE}" | grep -q "rhel") || (echo "${ID_LIKE}" | grep -q "fedora") || (echo "${ID_LIKE}" | grep -q "mariner"); then
        ADJUSTED_ID="rhel"
    elif [ "${ID}" = "alpine" ]; then
        ADJUSTED_ID="alpine"
    else
        echo "Error: Linux distro ${ID} not supported."
        exit 1
    fi
    ;;
*)
    echo "Error: Unsupported or unrecognized os distribution ${ADJUSTED_ID}"
    exit 1
    ;;
esac

if [ -f "${HOME}/${FILE_NAME}" ]; then
    echo "File already exists: ${HOME}/${FILE_NAME}"
    echo "Do you want to replace it (default: y)? [y/n]: "
    read -r rp_conf
    rp_conf="${rp_conf:-y}"
    if [ "${rp_conf}" = "y" ]; then
        # Replace the existing file
        echo "Replacing ${HOME}/${FILE_NAME}..."
        dw_file
        updaterc
    else
        echo "Keeping existing file: ${HOME}/${FILE_NAME}"
    fi
else
    dw_file
    updaterc
fi
