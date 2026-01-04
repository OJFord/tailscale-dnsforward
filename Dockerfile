FROM tailscale/tailscale:unstable-v1.93
ENV TS_ACCEPT_DNS=1

RUN apk add bash dnsmasq openssh-server
COPY dnsmasq.conf /etc/dnsmasq.conf

COPY entrypoint.sh /
EXPOSE 53/tcp 53/udp
# containerboot is upstream entrypoint
ENTRYPOINT ["/entrypoint.sh", "/usr/local/bin/containerboot"]
