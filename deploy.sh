#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

rm -rf public
git clone git@github.com:klieber/klieber.github.com ./public

# Clean public directory
find public/* -path public/.git -prune -o -exec rm -rf {} \; 2>/dev/null

# Build the project.
hugo --theme=hugo-octopress

cd ./public

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push
