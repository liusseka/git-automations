#!/bin/bash

source createGitRepo.sh

# Function to perform Git operations
perform_git_operations() {

  # first we check if a remote repo exists, then create one
  # Get the current directory name
  response=$(curl -s -o /dev/null -w "%{http_code}" "https://api.github.com/repos/$GIT_USERNAME/$CURRENT_REPO_NAME")

  if [ ! $response -ne 404 ];
  then
    echo "Repository $REPO_NAME does not exist on GitHub."
    echo "Creating one now...."
    # Create the repository using the GitHub API
    creatingRemoteRepo
  fi

  # Add new files to the staging area
  git remote set-url origin "https://$GITHUB_TOKEN@github.com/$GIT_USERNAME/$CURRENT_REPO_NAME.git"
  git pull
  git add .

  while true;
  do
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

  # Commit changes with the provided message
  git commit -m "$COMMIT_MESSAGE"

  # Push changes to the remote repository
  pushingToRemote
}
