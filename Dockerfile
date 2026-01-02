FROM tailscale/tailscale:unstable-v1.93
ENV TS_ACCEPT_DNS=1

RUN apk add bash dnsmasq openssh-server
COPY dnsmasq.conf /etc/dnsmasq.conf

COPY dnsmasq-and-then.sh /
EXPOSE 53/tcp 53/udp
ENTRYPOINT ["/dnsmasq-and-then.sh", "/usr/local/bin/containerboot"]
