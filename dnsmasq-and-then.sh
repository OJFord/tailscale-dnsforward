#!/usr/bin/env bash
set -eEuo pipefail
then="$@"

dnsmasq --no-daemon --listen-address="$HOST_INTERFACE" &
exec "${then[@]}"
