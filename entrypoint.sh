#!/bin/sh

set -e

if [[ $1 == *"$GITHUB_REPOSITORY"* ]]; then
  echo "Upstream = $1"
  echo "Current Repo = $GITHUB_REPOSITORY"
  echo "Hello, this is self. We are currently on origin, so exiting"
  # exit 0
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
  echo "Set the GITHUB_TOKEN environment variable."
  exit 1
fi

if [[ ! -z "$SSH_PRIVATE_KEY" ]]; then
  echo "Saving SSH_PRIVATE_KEY"

  mkdir --parents /root/.ssh
  echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa

  # Github action changes $HOME to /github at runtime
  # therefore we always copy the SSH key to $HOME (aka. ~)
  mkdir --parents ~/.ssh
  cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true 
fi

sh -c "/github-sync.sh $*"
