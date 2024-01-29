#!/bin/bash

# Function to check if Git is configured with the desired identity
configure_git_identity() {
    # Set the desired Git identity
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_EMAIL"

    # Recheck if configurations match the desired identity after setting them
    CONFIGURED_USERNAME=$(git config --global user.name)
    CONFIGURED_EMAIL=$(git config --global user.email)

    # Check if configurations match the desired identity
    if [ "$CONFIGURED_USERNAME" != "$GIT_USERNAME" ] || [ "$CONFIGURED_EMAIL" != "$GIT_EMAIL" ];
    then
        echo "Could not configure git"
        exit 1
    else
        echo "Git Git configured successfully"
    fi
}

check_and_configure_git() {
    # Check if user.name and user.email are configured globally
    CONFIGURED_USERNAME=$(git config --global user.name)
    CONFIGURED_EMAIL=$(git config --global user.email)

    # Check if configurations match your desired identity
    if [ "$CONFIGURED_USERNAME" != "$GIT_USERNAME" ] || [ "$CONFIGURED_EMAIL" != "$GIT_EMAIL" ];
    then
        echo "Git not configured. Configuring now with the following"
        echo "Username: $GIT_USERNAME"
        echo "Email: $GIT_EMAIL"
        configure_git_identity
    fi
}

# Main function to check and configure Git
check_and_configure_git() {
    # Check if user.name and user.email are configured globally
    CONFIGURED_USERNAME=$(git config --global user.name)
    CONFIGURED_EMAIL=$(git config --global user.email)

    # Check if configurations match your desired identity
    if [ "$CONFIGURED_USERNAME" != "$GIT_USERNAME" ] || [ "$CONFIGURED_EMAIL" != "$GIT_EMAIL" ]; then
        echo "Git not configured. Configuring now with the following:"
        echo "Username: $GIT_USERNAME"
        echo "Email: $GIT_EMAIL"
        configure_git_identity
    fi
}

check_and_configure_git