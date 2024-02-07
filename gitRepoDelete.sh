#!/usr/bin/bash

removeRepoDir() {

  repo_to_delete=$(basename "$(pwd)")

  # First, we delete the local repository
  if [ -d ".git" ];
  then
    read -r -p "Type 'Yes' or 'No' to confirm removal of repository tracking?: " GitDelete
    if [ "$GitDelete" = "Yes" ];
    then
      echo "Removing git tracking"
      rm -rf .git
    elif [ "$GitDelete" = "No" ];
    then
      echo "git tracking not removed.."
      echo "git removal cancelled by user"
      exit 0
    else
      echo "Option not recognized"
      echo "Type either Yes or No"
    fi
  fi

  # Second, we delete the local directory
  read -r -p "Type 'Yes' or 'No' to delete directory and its files?: " DirDelete
  if [ "$DirDelete" = "Yes" ];
  then
    cd ..
    echo "Deleting repository directory"
    rm -rf "$repo_to_delete"
  elif [ "$DirDelete" = "No" ];
  then
    echo "Directory not deleted"
    echo "Deletion cancelled by user"

  else
    echo "Option not recognized. Its either a Yes or No"
  fi


  # Lastly, we remove the git remote repository
  read -r -p "Type 'Yes' or 'No' to delete remote repository: " RemoteDelete
  response=$(curl -s -o /dev/null -w "%{http_code}" -X GET -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$USERNAME/$repo_to_delete)
  if [ "$RemoteDelete" = "Yes" ];
  then
    if [ "$response" = "204" ];
    then
      echo "Removing remote repository"
      echo "It won't take long..."
      curl -X DELETE -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$USERNAME/$repo_to_delete
      echo "remote repository $repo_to_delete deleted successfully"

    else
      echo "Remote repository does not exist or not found"
      read -r -p "Provide name of the remote repository to delete: " RemoteRepoTODelete
      response=$(curl -s -o /dev/null -w "%{http_code}" -X GET -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$USERNAME/$RemoteRepoTODelete)
      if [ "$response" = "200" ];
      then
        echo "Removing remote repository $RemoteRepoTODelete"
        echo "It won't take long..."
        curl -X DELETE -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/$USERNAME/$RemoteRepoTODelete
        echo "remote repository $RemoteRepoTODelete deleted successfully"
      fi
    fi

  elif [ "$RemoteDelete" = "No" ];
    then
      echo "Remote repository not removed.."
      echo "Removal cancelled by user"

  else
    echo "Option not recognized"
    echo "Type either Yes or No"
  fi
}

