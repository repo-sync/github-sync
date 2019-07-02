#!/bin/sh

set -e

if [[ -n "$SSH_PRIVATE_KEY" ]]
then
  mkdir -p /root/.ssh
  echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
  chmod 600 /root/.ssh/id_rsa
fi

mkdir -p ~/.ssh
cp /root/.ssh/* ~/.ssh/ 2> /dev/null || true 

sh -c "/github-sync.sh $*"
