ARG BASE_IMAGE=alpinelinux/unbound
FROM $BASE_IMAGE
ARG COUNTRY=

# Set mirror for China if COUNTRY=CN
RUN if [ "$COUNTRY" = "CN" ]; then \
    sed -i 's#https\?://dl-cdn.alpinelinux.org/alpine#https://mirrors.tuna.tsinghua.edu.cn/alpine#g' /etc/apk/repositories; \
fi

# Install curl for fetching hosts
RUN apk update && apk add --no-cache curl wget

# Copy the script and configuration files
COPY generate-hosts-github.sh /usr/local/bin/generate-hosts-github.sh
COPY entrypoint.sh /usr/local/bin/dns-server-entrypoint.sh
COPY unbound.conf /etc/unbound/unbound.conf
COPY unbound.conf.d/ /etc/unbound/unbound.conf.d/

# Make scripts executable
RUN chmod +x /usr/local/bin/dns-server-entrypoint.sh /usr/local/bin/generate-hosts-github.sh

ENTRYPOINT [ "/usr/local/bin/dns-server-entrypoint.sh" ]