#!/usr/bin/bash

creatingRemoteRepo() {
  # setting up repo name
  REPO_NAME=$(basename "$(pwd)")

  # Create the repository using the GitHub API
  response=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" -d '{"name":"'"$REPO_NAME"'"}' "https://api.github.com/user/repos")

  if [[ ! "$response" == *"\"id\""* ]];
  then
    echo "Failed to create $REPO_NAME repo on GitHub."
    echo "$response"
    exit 1
  else
    # If remote repo created successfully, add it to local
    echo "Repository '$REPO_NAME' created successfully on GitHub."
    git remote add origin "https://$GITHUB_TOKEN@github.com/$GIT_USERNAME/$REPO_NAME.git"
    pushingToRemote
  fi
}

