#!/bin/bash

# Script to update the branch-selector.html file with the latest archive branches

# Get all branches that start with "archive-"
ARCHIVE_BRANCHES=$(git branch | grep "archive-" | sed 's/^[ *]*//')

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

echo "Branch selector page updated with the latest archive branches."