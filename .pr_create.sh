#!/bin/bash

# A simple bash function to create a new branch, commit changes,
# and open the pull request creation page in your browser using GitHub CLI.

# Usage: pr [<branch_name>] "<commit_message>"
# If <branch_name> is not provided, it will be generated from the commit message.

function pr() {
  local branch_name=""
  local commit_message=""

  # Check for the minimum required argument (commit message)
  if [ -z "$1" ]; then
    echo "Error: Commit message is required."
    echo "Usage: pr [<branch_name>] \"<commit_message>\""
    return 1
  fi

  # Determine arguments
  if [ -n "$2" ] && [[ "$2" != "-"* ]]; then
    branch_name="$1"
    commit_message="$2"
  else
    commit_message="$1"
    # Replace spaces and special characters with hyphens for the branch name.
    branch_name=$(echo "$commit_message" | sed -E 's/[ ,:-]+/-/g' | tr '[:upper:]' '[:lower:]')
  fi

  echo "Starting the process..."
  
  # Step 1: Create and checkout a new branch from the current one.
  echo "Creating new branch: $branch_name"
  git checkout -b "$branch_name"

  # Check if the branch creation was successful.
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create branch. Aborting."
    return 1
  fi

  # Step 2: Commit all changes in the new branch.
  echo "Committing changes with message: \"$commit_message\""
  git commit -am "$commit_message"

  # Check if the commit was successful.
  if [ $? -ne 0 ]; then
    echo "Error: Failed to commit changes. Aborting."
    return 1
  fi

  # Step 3: Open the pull request creation page using the GitHub CLI --web option.
  echo "Pushing branch and opening pull request creation page in your browser..."
  gh pr create --web --base master --head "$branch_name" --title "$commit_message"
  
  # Check if the command was successful.
  if [ $? -ne 0 ]; then
    echo "Error: Failed to open pull request page. Aborting."
    return 1
  fi

  echo "Successfully completed the pull request process."
}

# You can add this function to your .bash_profile or .zshrc file
# to make it available in all your terminal sessions.
