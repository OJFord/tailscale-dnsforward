#!/usr/bin/env bash
set -eEuo pipefail
cmd="$@"

dnsmasq --no-daemon --interface="$HOST_INTERFACE" &

# necessary to allow devices behind the subnet router to reach the tailnet with SNAT
# https://github.com/tailscale/tailscale/pull/18318
iptables -t mangle -A FORWARD -i "$HOST_INTERFACE" -o tailscale0 -j MARK --set-xmark 0x40000/0xff0000
ip6tables -t mangle -A FORWARD -i "$HOST_INTERFACE" -o tailscale0 -j MARK --set-xmark 0x40000/0xff0000

exec "${cmd[@]}"
