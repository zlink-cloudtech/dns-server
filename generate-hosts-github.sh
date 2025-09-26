#!/bin/sh

# Script to generate hosts-github.conf for unbound from https://raw.hellogithub.com/hosts

curl -s https://raw.hellogithub.com/hosts | sed 's/#.*//' | grep -v '^$' | while read ip domains; do
    if [[ -n "$ip" && -n "$domains" ]]; then
        for domain in $domains; do
            echo "local-zone: \"$domain.\" static"
            echo "local-data: \"$domain. IN A $ip\""
        done
    fi
done > unbound.conf.d/hosts-github.conf

echo "Generated unbound.conf.d/hosts-github.conf"