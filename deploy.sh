#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Clean public directory
find public/* -path public/.git -prune -o -exec rm -rf {} \;

# Build the project.
hugo --theme=hugo-octopress

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin source
git subtree push --prefix=public git@github.com:klieber/klieber.github.com.git master --squash
