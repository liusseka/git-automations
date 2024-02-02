#!/usr/bin/bash

create_github_repo() {
  # Checking whether current folder is a gig repository
  if [ -d .git ]; then
     echo "Already Git repository"
     echo "Choose a new directory that is not a git repository and re-run the command"
     exit
  fi

  # Collecting and handling repository name from user
  while true;
  do
      # Prompt the user to enter the repository name
      read -r -p "Enter the repository name: " REPO_NAME

      # Check if the repository name is provided
      if [ -z "$REPO_NAME" ]; then
          echo "Repository name cannot be empty."
          continue
      fi

      # Validate repository name
      if [[ ! "$REPO_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
          echo "Invalid repository name. Please use only letters, numbers, hyphens, and underscores."
          continue
      fi

      # checking if folder is already a repository
      if [ -d "$REPO_NAME" ];
      then
          echo "Directory with the same name already exists."
          echo "Choose a different directory"
          continue
      fi

      # If the repository name is valid, exit
      break
  done

  # Creating and initializing new repository
  mkdir "$REPO_NAME" && cd "$REPO_NAME" || exit

  # Add README file and commit initial changes
  touch README.md
  readme_content="## $REPO_NAME\n\nRead me content will be added here.."
  echo -e "$readme_content" > README.md
  git init
  git add .
  git commit -m "Readme file added"

  # Check if the repository exists on GitHub
  response=$(curl -s -o /dev/null -w "%{http_code}" "https://api.github.com/repos/$GIT_USERNAME/$REPO_NAME")

  if [ $response -eq 200 ];
  then
    # if repository exists on github, set it as url
    echo "Repository $REPO_NAME already exists on GitHub."
    git remote add origin "https://$GITHUB_TOKEN@github.com/$GIT_USERNAME/$REPO_NAME.git"

  else
    # Create the repository using the GitHub API
    creatingRemoteRepo
  fi

  # Push to remote
  pushingToRemote

  echo "Repository setup completed successfully."
}