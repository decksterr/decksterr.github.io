#!/bin/bash

# usage: ./deploy.sh "build"

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

echo -e "\033[0;32mSyncing source files with repo...\033[0m"

git rm -r public
git add .
git reset -- public

git commit -m "Source update: $msg"

git push origin source

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -t hyde-hyde

# Go To Public folder
cd public
# Add changes to git.
git add .

# Commit changes.

git commit -m "Build update: $msg"

# Push source and build repos.
git push origin master

# Come Back up to the Project Root
cd ..