#!/bin/bash

# Script to create an archive branch of the current edition

# Get current date for branch name
CURRENT_DATE=$(date +"%Y-%m-%d")
BRANCH_NAME="archive-edition-$CURRENT_DATE"

# Create the new branch
git branch $BRANCH_NAME

# Verify the branch was created
if git show-ref --verify --quiet refs/heads/$BRANCH_NAME; then
    echo "Successfully created archive branch: $BRANCH_NAME"
else
    echo "Failed to create archive branch"
    exit 1
fi

# Create documentation about the archive branch
cat > ARCHIVE.md << EOL
# Archive Branch

This repository contains an archive branch that preserves the state of the website at a specific point in time.

## Archive Information

- **Branch Name**: $BRANCH_NAME
- **Creation Date**: $CURRENT_DATE
- **Purpose**: To preserve the current edition of the website for historical reference

## How to Access the Archive

To view the archived version of the website, you can check out the archive branch:

\`\`\`
git checkout $BRANCH_NAME
\`\`\`

To return to the main development branch:

\`\`\`
git checkout master
\`\`\`
EOL

# Add the documentation file to git
git add ARCHIVE.md

echo "Archive branch created and documented successfully."
echo "To use the archive branch, run: git checkout $BRANCH_NAME"
echo "To return to the main branch, run: git checkout master"