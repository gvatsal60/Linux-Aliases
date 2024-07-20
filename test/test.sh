#!/bin/sh

# Get the current Git branch name
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Fetch and execute install.sh from the specified Git branch
curl -fsSL "https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/${GIT_BRANCH}/install.sh" | sh

# Define the block of aliases to search for in ~/.bashrc
ALIAS_SEARCH_BLOCK="# BEGIN ALIAS_SOURCE_BLOCK"

# Path to the ~/.bashrc file
_rc="${HOME}/.bashrc"

# Check if ~/.bashrc exists and if ALIAS_SEARCH_BLOCK is present in it
if [ -f "${_rc}" ]; then
    if ! grep -qxF "${ALIAS_SEARCH_BLOCK}" "${_rc}"; then
        echo "ALIAS_SEARCH_BLOCK not found in ${_rc}"
        exit 1
    fi
else
    echo "File ${_rc} not found"
    exit 1
fi
