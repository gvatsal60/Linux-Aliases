#!/bin/sh

###################################################################################################
# File: postCreateScript.sh
# Author: [Vatsal Gupta (gvatsal60)]
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
###################################################################################################

###################################################################################################
# License
###################################################################################################
# This script is licensed under the Apache 2.0 License.

###################################################################################################
# Global Variables & Constants
###################################################################################################

readonly ALIAS_FILE_LINK="https://raw.githubusercontent.com/gvatsal60/Linux-Aliases/HEAD/install.sh"

###################################################################################################
# Functions
###################################################################################################

###################################################################################################
# Main Script
###################################################################################################

# Install Linux aliases from external script using curl and execute immediately
# Note: Make sure to review scripts fetched from external sources for security reasons
if command -v curl >/dev/null 2>&1; then
    curl -fsSL ${ALIAS_FILE_LINK} | sh
else
    echo "Error: curl is not installed. Unable to use Linux aliases"
fi
