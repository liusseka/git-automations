create_github_repo() {
    # check if local repo exists or if folder already a repo
    if [ -d .git ] || [ -d "$REPO_NAME" ];
    then
      echo "Already Git repository or a directory with the same name already exists."
      echo "Please initialize $REPO_NAME repository or choose a different name."
      exit 1
    fi

    # Creating and initializing new repository
    mkdir "$REPO_NAME" && cd "$REPO_NAME" || exit
    git init

    # Add README file and the name of the repository to the README content
    touch README.md
    readme_content="## $REPO_NAME\n\nRead me content will be added here.."
    echo -e "$readme_content" > README.md
    git add .
    git commit -m "Readme file added"

    # Check if the repository exists on GitHub
    response=$(curl -s -o /dev/null -w "%{http_code}" "https://api.github.com/repos/$GIT_USERNAME/$REPO_NAME")

    if [ $response -eq 200 ];
    then
        echo "Repository $REPO_NAME already exists on GitHub."
    else
        # Create the repository using the GitHub API
        response=$(curl -s -X POST -H "Authorization: token $GITHUB_TOKEN" -d '{"name":"'"$REPO_NAME"'"}'
        "https://api.github.com/user/repos")

        if [[ "$response" == *"errors"* ]];
        then
            echo "Failed to create repository '$REPO_NAME' on GitHub. Error: $response"
            exit 1
        else
            echo "Repository '$REPO_NAME' created successfully on GitHub."
        fi
    fi
    git remote add origin "https://$GITHUB_TOKEN@github.com/$GIT_USERNAME/$REPO_NAME.git"

    # Push to remote
    git push -u origin main || {
    echo "Failed to push to remote. Attempting to pull changes from the remote repository."
    git pull origin main || {
        echo "Failed to pull changes from the remote repository. Please resolve conflicts manually."
        exit 1
    }
    echo "Successfully pulled changes. Retrying to push to remote."
    git push -u origin main || {
        echo "Failed to push to remote even after pulling changes. Please resolve conflicts manually."
        exit 1
      }
      echo "Successfully pushed to remote repository"
    }

    echo "Repository setup completed successfully."
}