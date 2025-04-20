# Yuriko Goto - Visual Designer Website

This repository contains the website for Yuriko Goto, a visual designer. The website showcases her portfolio, services, and provides contact information.

## Repository Structure

- HTML files for different pages (index.html, about.html, gallery.html, etc.)
- Assets directory containing:
  - CSS styles (style.css)
  - JavaScript functionality (main.js)
  - Images and other media

## Branch Management

### Archive Branch

This repository includes an archive branch feature to preserve the current edition of the website. To create an archive branch, run the provided script:

```bash
chmod +x create_archive_branch.sh
./create_archive_branch.sh
```

The script will:
1. Create a new branch named "archive-edition-[current-date]"
2. Create documentation about the archive branch in ARCHIVE.md
3. Provide instructions for accessing the archive branch

### Development Branch Control

For managing the development branch and Git operations, use the dev_branch_control.sh script:

```bash
chmod +x dev_branch_control.sh
./dev_branch_control.sh [command]
```

Available commands:
- `create-dev`: Create a new development branch
- `switch-dev`: Switch to the development branch
- `switch-master`: Switch to the master branch
- `commit [message]`: Commit changes with the specified message
- `push`: Push changes to the remote repository
- `status`: Show the current Git status
- `update-selector`: Update the branch selector HTML with dev branch
- `help`: Show help information

Example usage:
```bash
./dev_branch_control.sh create-dev
./dev_branch_control.sh switch-dev
./dev_branch_control.sh commit "Updated gallery images"
./dev_branch_control.sh push
```

## Accessing Branches

To view an archived version of the website:

```bash
git checkout [archive-branch-name]
```

To access the development branch:

```bash
git checkout dev
```

To return to the main branch:

```bash
git checkout master
```

## Website Features

- Portfolio gallery
- Commission request form
- Community section
- Contact information
- Goods/merchandise section
- User login functionality
