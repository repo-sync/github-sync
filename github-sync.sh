#!/bin/sh

set -e

# It's not recommended to use DEBUG=1 in production environments as it will leak your credentials.
if [ -n "$DEBUG" ]; then
  set -x
fi

UPSTREAM_REPO=$1
BRANCH_MAPPING=$2

if [ -z "$UPSTREAM_REPO" ]; then
  echo "Missing \$UPSTREAM_REPO"
  exit 1
fi

if [ -z "$BRANCH_MAPPING" ]; then
  echo "Missing \$SOURCE_BRANCH:\$DESTINATION_BRANCH"
  exit 1
fi

if ! echo "$UPSTREAM_REPO" | grep -Eq ':|@|\.git/?$'
then
  echo "UPSTREAM_REPO does not seem to be a valid git URI, assuming it's a GitHub repo slug"
  echo "Originally: $UPSTREAM_REPO"
  _src_hostname=${SOURCE_HOST:-"github.com"}
  UPSTREAM_REPO="https://${_src_hostname}/${UPSTREAM_REPO}.git"
  echo "Now: $UPSTREAM_REPO"
fi

echo "UPSTREAM_REPO=$UPSTREAM_REPO"
echo "BRANCHES=$BRANCH_MAPPING"

git config --unset-all http."https://github.com/".extraheader || :

_hostname=${DESTINATION_HOST:-"github.com"}
_user=${DESTINATION_USER:-$GITHUB_ACTOR}
_token=${DESTINATION_TOKEN:-$GITHUB_TOKEN}
_repo=${DESTINATION_REPO:-$GITHUB_REPOSITORY}

if [ -z "$_user" ]; then
  echo "Missing \$DESTINATION_USER or \$GITHUB_ACTOR"
  exit 1
fi

if [ -z "$_token" ]; then
  echo "Missing \$DESTINATION_TOKEN or \$GITHUB_TOKEN"
  exit 1
fi

if [ -z "$_repo" ]; then
  echo "Missing \$DESTINATION_REPO or \$GITHUB_REPOSITORY"
  exit 1
fi

echo "Resetting origin to: https://$_user:***@$_hostname/$_repo"
git remote set-url origin "https://$_user:$_token@$_hostname/$_repo"

echo "Adding tmp_upstream $UPSTREAM_REPO"
if [ -n "${SOURCE_USER}" ] && [ -n "${SOURCE_TOKEN}" ]; then
  git remote add tmp_upstream "https://${SOURCE_USER}:${SOURCE_TOKEN}@${UPSTREAM_REPO#https://}"
else
  git remote add tmp_upstream "$UPSTREAM_REPO"
fi

echo "Fetching tmp_upstream"
git fetch tmp_upstream --quiet
git remote --verbose

echo "Pushing changings from tmp_upstream to origin"
git push origin "refs/remotes/tmp_upstream/${BRANCH_MAPPING%%:*}:refs/heads/${BRANCH_MAPPING#*:}" --force

if [ "$SYNC_TAGS" = true ]; then
  echo "Force syncing all tags"
  git tag -d "$(git tag -l)" > /dev/null
  git fetch tmp_upstream --tags --quiet
  git push origin --tags --force
elif [[ -n "$SYNC_TAGS" ]]; then
  echo "Force syncing tags matching pattern: $SYNC_TAGS"
  git tag -d $(git tag -l) > /dev/null
  git fetch tmp_upstream --tags --quiet
  git tag | grep "$SYNC_TAGS" | xargs --no-run-if-empty git push origin --force
fi

echo "Removing tmp_upstream"
git remote rm tmp_upstream
git remote --verbose
