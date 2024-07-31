#!/bin/bash

# ----------------------------
# Author: Digglega
# Description: Script to add, commit, and push changes to the 'develop' branch with a timestamp.
# ----------------------------

# Adding all changes to staging
git add .

# Checking if there are any changes to commit
if git diff-index --quiet HEAD --; then
    echo "No changes to commit."
    exit 0
fi

# Committing with the current date and time as the commit message
commit_message=$(date +"%Y-%m-%d %H:%M:%S")
git commit -m "$commit_message"

# Pushing to the 'develop' branch
if git push origin develop; then
    # Rainbow color sequence
    RED="\033[0;31m"
    GREEN="\033[0;32m"
    YELLOW="\033[0;33m"
    BLUE="\033[0;34m"
    PURPLE="\033[0;35m"
    CYAN="\033[0;36m"
    NC="\033[0m" # No Color

    # Printing each letter in a different color
    echo -e "${RED}C${GREEN}h${YELLOW}a${BLUE}n${PURPLE}g${CYAN}e${NC}s ${RED}p${GREEN}u${YELLOW}s${BLUE}h${PURPLE}e${CYAN}d ${RED}s${GREEN}u${YELLOW}c${BLUE}c${PURPLE}e${CYAN}s${RED}s${GREEN}f${YELLOW}u${BLUE}l${PURPLE}l${CYAN}y${NC}."
else
    echo "Failed to push changes."
    exit 1
fi

# ----------------------------
# Script executed by Digglega
# ----------------------------
