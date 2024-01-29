#!/bin/bash

# Function to perform Git operations
perform_git_operations() {
    # Add new files to the staging area
    git add .

    read -r -p "Enter the commit message: " COMMIT_MESSAGE

        # Check if the commit message is provided
        if [ -z "$COMMIT_MESSAGE" ]; then
            echo "Commit message cannot be empty."
            exit 1
        fi

    # Commit changes with the provided message
    git commit -m "$COMMIT_MESSAGE"

    # Push changes to the remote repository
    git push origin master
}