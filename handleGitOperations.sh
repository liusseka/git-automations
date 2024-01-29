#!/bin/bash

source handleUserInput.sh

# Function to perform Git operations
perform_git_operations() {
    # Add new files to the staging area
    git add .

    handle_user_input

    # Commit changes with the provided message
    git commit -m "$COMMIT_MESSAGE"

    # Push changes to the remote repository
    git push origin master
}