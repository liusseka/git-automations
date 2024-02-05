#!/bin/bash

# Assign environmental variables to local variables
GITHUB_TOKEN="$GITHUB_TOKEN"
GIT_USERNAME="$GIT_USERNAME"
GIT_EMAIL="$GIT_EMAIL"

# Source the files containing functions
source handleGitConfigs.sh
source createGitRepo.sh
source handleGitOperations.sh
source gitRepoDelete.sh
source createRemoteRepo.sh
source pushingToRemote.sh
source checkGitRepo.sh

# Main function to execute the script
main() {
  local ACTION=$1

  # Check if the .git directory exists
  if [ "$ACTION" = "create" ];
  then
    echo "Let us create a new repository for you"
    echo "You will be asked for a repo name"
    check_and_configure_git
    create_github_repo

  elif [ "$ACTION" = "update" ];
  then
    echo "Relax, allow me to commit and push your changes"
    echo "But first, lets cross-check if this a git repo..."
    echo "Checking if its a repo...."
    checkGitRepo
    perform_git_operations

  elif [ "$ACTION" = "delete" ];
  then
    echo "This action is irreversible"
    echo "Deleting repository. You will be asked to confirm"
    removeRepoDir

  else
    echo "Invalid command argument provided"
    echo "Specify either 'create' to create a new repo or 'update' to update your changes"
  fi
}

# Call the main function
main "$1"
