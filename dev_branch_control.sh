#!/bin/bash

# Script to manage development branch and provide Git control functionality

# Function to display help information
show_help() {
    echo "Dev Branch Control - Git Management Tool"
    echo ""
    echo "Usage: ./dev_branch_control.sh [command]"
    echo ""
    echo "Commands:"
    echo "  create-dev       Create a new development branch"
    echo "  switch-dev       Switch to the development branch"
    echo "  switch-master    Switch to the master branch"
    echo "  commit [message] Commit changes with the specified message"
    echo "  push            Push changes to the remote repository"
    echo "  status          Show the current Git status"
    echo "  update-selector Update the branch selector HTML with dev branch"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./dev_branch_control.sh create-dev"
    echo "  ./dev_branch_control.sh commit \"Updated gallery images\""
    echo "  ./dev_branch_control.sh push"
}

# Function to create a development branch
create_dev_branch() {
    # Check if dev branch already exists
    if git show-ref --verify --quiet refs/heads/dev; then
        echo "Development branch already exists."
        echo "To switch to it, use: ./dev_branch_control.sh switch-dev"
    else
        # Create the dev branch
        git branch dev
        echo "Development branch created successfully."
        echo "To switch to it, use: ./dev_branch_control.sh switch-dev"
    fi
}

# Function to switch to development branch
switch_to_dev() {
    # Check if dev branch exists
    if git show-ref --verify --quiet refs/heads/dev; then
        git checkout dev
        echo "Switched to development branch."
    else
        echo "Development branch does not exist."
        echo "To create it, use: ./dev_branch_control.sh create-dev"
    fi
}

# Function to switch to master branch
switch_to_master() {
    git checkout master
    echo "Switched to master branch."
}

# Function to commit changes
commit_changes() {
    # Get the current branch
    CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
    
    # Check if there are changes to commit
    if git diff-index --quiet HEAD --; then
        echo "No changes to commit on branch: $CURRENT_BRANCH"
    else
        # If a commit message was provided, use it; otherwise, use a default message
        if [ -z "$1" ]; then
            COMMIT_MSG="Update on $CURRENT_BRANCH branch - $(date +"%Y-%m-%d %H:%M:%S")"
        else
            COMMIT_MSG="$1"
        fi
        
        # Add all changes and commit
        git add .
        git commit -m "$COMMIT_MSG"
        echo "Changes committed to branch: $CURRENT_BRANCH"
        echo "Commit message: $COMMIT_MSG"
    fi
}

# Function to push changes
push_changes() {
    # Get the current branch
    CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
    
    # Push changes
    git push origin $CURRENT_BRANCH
    echo "Changes pushed to remote repository, branch: $CURRENT_BRANCH"
}

# Function to show git status
show_status() {
    # Get the current branch
    CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
    echo "Current branch: $CURRENT_BRANCH"
    
    # Show git status
    git status
}

# Function to update branch selector with dev branch
update_branch_selector() {
    # Create a temporary file for the updated HTML
    TMP_FILE=$(mktemp)
    
    # Read the branch-selector.html file up to the marker for dynamic content
    sed -n '1,/<div class="branch-item current-branch">/p' branch-selector.html > "$TMP_FILE"
    
    # Add the current branch item
    cat >> "$TMP_FILE" << EOL
        <div>
          <div class="branch-name">Current Edition (master)</div>
          <div class="branch-date">Latest version</div>
        </div>
        <a href="index.html" class="branch-button">View</a>
      </div>
EOL
    
    # Add dev branch if it exists
    if git show-ref --verify --quiet refs/heads/dev; then
        # Get the last commit date on dev branch
        DEV_DATE=$(git log -1 --format="%ad" --date=short refs/heads/dev)
        
        # If no date found, use current date
        if [ -z "$DEV_DATE" ]; then
            DEV_DATE=$(date +"%Y-%m-%d")
        fi
        
        # Add the dev branch item to the HTML
        cat >> "$TMP_FILE" << EOL
      
      <div class="branch-item dev-branch">
        <div>
          <div class="branch-name">Development Branch (/dev)</div>
          <div class="branch-date">Last updated: $DEV_DATE</div>
        </div>
        <a href="#" class="branch-button" onclick="alert('To view the development branch, run: git checkout dev')">Info</a>
      </div>
EOL
    fi
    
    # Get all branches that start with "archive-"
    ARCHIVE_BRANCHES=$(git branch | grep "archive-" | sed 's/^[ *]*//')
    
    # Add each archive branch
    for branch in $ARCHIVE_BRANCHES; do
        # Extract date from branch name (assuming format archive-edition-YYYY-MM-DD)
        DATE=$(echo "$branch" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}')
        
        # If no date found, use a placeholder
        if [ -z "$DATE" ]; then
            DATE="Unknown Date"
        fi
        
        # Add the branch item to the HTML
        cat >> "$TMP_FILE" << EOL
      
      <div class="branch-item">
        <div>
          <div class="branch-name">$branch</div>
          <div class="branch-date">Created: $DATE</div>
        </div>
        <a href="#" class="branch-button" onclick="alert('To view this archive, run: git checkout $branch')">Info</a>
      </div>
EOL
    done
    
    # Add the closing part of the HTML
    sed -n '/<p class="note">/,$p' branch-selector.html >> "$TMP_FILE"
    
    # Replace the original file with the updated one
    mv "$TMP_FILE" branch-selector.html
    
    echo "Branch selector page updated with development branch and archive branches."
}

# Main script logic
case "$1" in
    create-dev)
        create_dev_branch
        ;;
    switch-dev)
        switch_to_dev
        ;;
    switch-master)
        switch_to_master
        ;;
    commit)
        commit_changes "$2"
        ;;
    push)
        push_changes
        ;;
    status)
        show_status
        ;;
    update-selector)
        update_branch_selector
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use './dev_branch_control.sh help' for usage information."
        exit 1
        ;;
esac

exit 0