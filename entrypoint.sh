#!/bin/sh

if [ "$UNBOUND_HOSTS_GITHUB_ENABLE" = "YES" ]; then
    /usr/local/bin/generate-hosts-github.sh
fi

/usr/local/bin/entrypoint.sh