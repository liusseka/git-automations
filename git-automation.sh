#!/bin/bash

# Assign environmental variables to local variables
GITHUB_TOKEN="$GITHUB_TOKEN"
GIT_USERNAME="$GIT_USERNAME"
GIT_EMAIL="$GIT_EMAIL"

# Source the files containing functions
source handleUserInput.sh
source handleGitConfigs.sh
source createGitRepo.sh
source handleGitOperations.sh

# Main function to execute the script
main() {
    # Check if the .git directory exists
    if [ -d ".git" ]; then
        echo "Adding, committing, and pushing changes to $REPO_NAME repository"
        handle_user_input "commit"
        perform_git_operations
    else
        echo "No repository. Creating..."
        # Create the repository
        check_and_configure_git
        handle_user_input "create"
        create_github_repo
        git init
    fi
}

# Call the main function
main