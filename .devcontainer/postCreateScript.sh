#!/bin/sh

##########################################################################################
# File: postCreateScript.sh
# Author: Vatsal Gupta
# Date: 07-Aug-2024
# Description:

# This script runs automatically after the DevContainer environment has been created.
# It performs various initialization tasks to ensure the development environment is properly configured.

# 1. Install necessary dependencies:
#    Installs any required software packages, libraries, or tools that are not included in the base container image.
# 2. Set up environment variables:
#    Configures environment variables needed for the project or development workflow.
# 3. Configure services:
#    Sets up or configures additional services or daemons required by the project.
# 4. Perform custom setup tasks:
#    Includes tasks such as generating configuration files, setting up initial data, or performing cleanup.

# Ensure that the development environment is consistently set up with the necessary tools and settings for a smooth workflow.
##########################################################################################

##########################################################################################
# License
##########################################################################################
# This script is licensed under the Apache 2.0 License.
# License information should be updated as necessary.

##########################################################################################
# Constants
##########################################################################################
readonly SNIPPETS_DIR="snippets"
readonly VSCODE_DIR=".vscode"
readonly SNIPPET_FILES_PATTERN="*.code-snippets"

##########################################################################################
# Functions
##########################################################################################

##########################################################################################
# Main Script
##########################################################################################

# Install Linux aliases from external script using curl and execute immediately
# Note: Make sure to review scripts fetched from external sources for security reasons
curl -fsSL https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/HEAD/install.sh | sh

# Check if running in GitHub Codespaces by checking for `CODESPACE_NAME` env variable
if [ -n "${CODESPACE_NAME}" ]; then
    # Generate symlinks for snippet files
    # Create the .vscode directory if it doesn't already exist.
    mkdir -p "${VSCODE_DIR}"

    # Unlink all symbolic links in the '.vscode' directory
    find "${VSCODE_DIR}" -type l -name "${SNIPPET_FILES_PATTERN}" | while read -r file; do
        unlink "${file}"
    done

    # Check if the 'snippets' directory exists
    if [ -d "${SNIPPETS_DIR}" ]; then
        # Find all .code-snippet files in the 'snippets' directory and create symbolic links
        find "${SNIPPETS_DIR}" -type f -name "${SNIPPET_FILES_PATTERN}" | while read -r file; do
            # Create a symbolic link in '.vscode' with the same base name
            ln -s "$(realpath "${file}")" "${VSCODE_DIR}/$(basename "${file}")"
        done
    fi
fi