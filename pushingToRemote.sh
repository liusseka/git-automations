#!/usr/bin/bash

pushingToRemote() {
  git push -u origin main || {
    echo "Failed to push to remote. Attempting to pull changes from the remote repository."
    git pull origin main || {
      echo "Failed to pull changes from the remote repository. Please resolve conflicts manually."
      }
    echo "Successfully pulled changes. Retrying to push to remote."
    git push -u origin main || {
      echo "Failed to push to remote even after pulling changes. Please resolve conflicts manually."
      exit 1
      }
      echo "Successfully pushed to remote repository"
  }
}
