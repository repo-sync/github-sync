FROM alpine

LABEL \
  "name"="GitHub Sync" \
  "homepage"="https://github.com/marketplace/actions/github-sync" \
  "repository"="https://github.com/repo-sync/github-sync" \
  "maintainer"="Wei He <github@weispot.com>"

RUN apk add --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]
