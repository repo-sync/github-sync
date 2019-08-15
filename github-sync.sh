#!/bin/sh

set -e

OWNER=$(git remote get-url origin | cut -d'/' -f4)
REPO=$(git remote get-url origin | cut -d'/' -f5)
UPSTREAM_REPO=$1
BRANCH_MAPPING=$2

if ! echo $UPSTREAM_REPO | grep '.git'
then
  UPSTREAM_REPO="https://github.com/${UPSTREAM_REPO}.git"
fi

echo "UPSTREAM_REPO=$UPSTREAM_REPO"
echo "BRANCHES=$BRANCH_MAPPING"

# Github actions no longer auto set the username and GITHUB_TOKEN
git remote set-url origin "https://$OWNER:$GITHUB_TOKEN@github.com/$OWNER/$REPO"
git remote add upstream "$UPSTREAM_REPO"
git fetch upstream
git remote -v
git push origin "refs/remotes/upstream/${BRANCH_MAPPING%%:*}:refs/heads/${BRANCH_MAPPING#*:}" -f
