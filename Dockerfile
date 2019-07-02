FROM alpine

LABEL "com.github.actions.name"="Github Sync"
LABEL "com.github.actions.description"="⤵️ Sync current repository with remote"
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="black"

LABEL "repository"="http://github.com/wei/github-sync"
LABEL "homepage"="http://github.com/wei/github-sync"
LABEL "maintainer"="Wei He <github@weispot.com>"

RUN apk add --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]
