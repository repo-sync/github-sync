#!/bin/sh

set -e

UPSTREAM_REPO=$1
BRANCH_MAPPING=$2

if ! echo $UPSTREAM_REPO | grep '.git'
then
  UPSTREAM_REPO="https://github.com/${UPSTREAM_REPO}.git"
fi

echo "UPSTREAM_REPO=$UPSTREAM_REPO"
echo "BRANCHES=$BRANCH_MAPPING"

git remote add upstream "$UPSTREAM_REPO"
git fetch upstream
git remote -v
git push origin "refs/remotes/upstream/${BRANCH_MAPPING%%:*}:refs/heads/${BRANCH_MAPPING#*:}" -f
