#!/bin/bash

# Function to handle user input and perform validation
handle_user_input() {
    if [ "$1" == "create" ];
    then
        while true; do
            # Prompt the user to enter the repository name
            read -r -p "Enter the repository name: " REPO_NAME

            # Check if the repository name is provided
            if [ -z "$REPO_NAME" ]; then
                echo "Repository name cannot be empty."
                exit 1
            fi

            # Validate repository name
            if [[ ! "$REPO_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
                echo "Invalid repository name. Please use only letters, numbers, hyphens, and underscores."
                continue
            fi

            # If the repository name is valid, exit the loop
            break
        done
    fi
    if [ "$1" == "commit" ];
    then
        while true; do
              # Prompt the user to enter the commit message
            read -r -p "Enter the commit message: " COMMIT_MESSAGE

            # Check if the commit message is provided
            if [ -z "$COMMIT_MESSAGE" ];
            then
                echo "Commit message cannot be empty."
                echo "Provide a commit message.."
                continue
            fi

            # If the commit message has been provided, exit the loop
            break
        done
    fi

}