#!/bin/bash

# usage: ./deploy.sh "build"

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi

echo -e "\n---\n---\e[38;5;36m Syncing source files with repo... \e[0m\n---\n"

git checkout source
rm -rf public
git add .

git commit -m "Source update: $msg"
git push origin source

echo -e "\n---\n---\e[38;5;36m Syncing with master branch... \e[0m\n---\n"

git clone "git@github.com:decksterr/decksterr.github.io.git"

mv decksterr.github.io public
cd public

git checkout master 
git pull

cd  ..

# Build the project.
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -t hyde-hyde

echo -e "\n---\n---\e[38;5;36m Deploying updates... \e[0m\n---\n"

cd public

git add .
git commit -m "Build update: $msg"
git push origin master

# Come Back up to the Project Root
cd ..
