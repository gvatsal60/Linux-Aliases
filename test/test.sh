#!/bin/sh

##########################################################################################
# File: test.sh
# Author: Vatsal Gupta
# Date: 20-Jul-2024
# Description: This script detects the current operating system, determines the appropriate
#              shell configuration file (.zshrc for macOS, .bashrc for Linux), retrieves the
#              current Git branch name, fetches and executes an installation script from
#              GitHub based on the Git branch, and checks for a specific alias block in the
#              shell configuration file.
##########################################################################################

##########################################################################################
# License
##########################################################################################
# This script is licensed under the Apache 2.0 License.

##########################################################################################
# Constants
##########################################################################################

##########################################################################################
# Functions
##########################################################################################

##########################################################################################
# Test Script
##########################################################################################

# Determine the operating system
OS=$(uname)

case ${OS} in
    Darwin)
        _rc="${HOME}/.zshrc"
        ;;
    Linux)
        _rc="${HOME}/.bashrc"
        ;;
    *)
        echo "Error: Unsupported or unrecognized operating system '${OS}'"
        exit 1
        ;;
esac

# Get the current Git branch name
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Fetch and execute install.sh from the specified Git branch
curl -fsSL "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/${GIT_BRANCH}/install.sh" | sh

# Define the block of aliases to search for in ~/.rc file
ALIAS_SEARCH_BLOCK="# BEGIN ALIAS_SOURCE_BLOCK"

# Check if ~/.rc exists and if ALIAS_SEARCH_BLOCK is present in it
if [ -f "${_rc}" ]; then
    if ! grep -qxF "${ALIAS_SEARCH_BLOCK}" "${_rc}"; then
        echo "${ALIAS_SEARCH_BLOCK} not found in ${_rc}"
        exit 1
    fi
else
    echo "File ${_rc} not found"
    exit 1
fi
