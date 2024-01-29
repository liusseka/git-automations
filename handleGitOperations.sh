#!/bin/bash

source handleUserInput.sh

# Function to perform Git operations
perform_git_operations() {
    # Add new files to the staging area
    git add .

    handle_user_input

    # Commit changes with the provided message
    git commit -m "$COMMIT_MESSAGE"

    # Get the name of the current directory
    DIR_NAME=$(basename "$(pwd)")

    # Check if the repository exists on GitHub
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://api.github.com/repos/$GIT_USERNAME/$DIR_NAME")

    if [ $response -eq 404 ];
    then
        echo "Repository $DIR_NAME does not exists on GitHub. Creating one...."

        # Create the repository using the GitHub API
        response=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" -d '{"name":"'"$DIR_NAME"'"}'
        "https://api.github.com/user/repos")

        if [[ "$response" == *"errors"* ]];
        then
            echo "Failed to create repository '$DIR_NAME' on GitHub. Error: $response"
            exit 1
        else
            echo "Repository '$DIR_NAME' created successfully on GitHub."
        fi
        git remote add origin "https://$GITHUB_TOKEN@github.com/$GIT_USERNAME/$DIR_NAME.git"
    fi

    # Push changes to the remote repository
    git push origin main
}
