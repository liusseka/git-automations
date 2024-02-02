#!/usr/bin/bash

pushingToRemote() {
  git fetch

  git push -u origin main || {
    echo "Failed to push to remote."
    echo "Attempting to pull changes from the remote repository."

    git pull origin main || {
      echo "Failed to pull changes from the remote repository."
      echo "Please resolve conflicts manually."
      }

    echo "Successfully pulled changes."
    echo "Retrying to push to remote."

    git push -u origin main || {
      echo "Failed to push to remote even after pulling changes."
      echo "Please resolve conflicts manually."
      exit 1
      }
      echo "Successfully pushed to remote repository"
  }
}
