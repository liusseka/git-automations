#!/usr/bin/bash

checkGitRepo() {
  # First, we check if folder or any parent folder in its path is a git repo
  current_dir="$PWD"

  while [ "$current_dir" != "/" ];
  do
    if [ -d "$current_dir/.git" ]; then
        git_repo_found=true
        break
    fi
    current_dir=$(dirname "$current_dir")
  done

  if [ "$git_repo_found" != true ];
  then
     echo "Directory or parent directory not a Git repository"
     echo "Create a new repository or run 'git init' to initialize this directory"
     exit
  else
    CURRENT_REPO_NAME=$(basename "$current_dir")
    echo "Git repository found in $current_dir"
    echo "Repository name: $CURRENT_REPO_NAME"
    echo "Confirmed, proceeding to commit and push changes."
  fi
}