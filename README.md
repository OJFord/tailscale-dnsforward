tailscale/tailscale, plus forwarding DNS queries on the local interface to the tailnet (MagicDNS, and whatever is configured).

All env vars etc. as per the upstream image; defaults unchanged except `TS_ACCEPT_DNS=1` (it doesn't make sense to decline it) and the addition of:
- `ALLOW_FROM_ADDR_V4`: e.g. `192.168.88.0/24,172.1.2.3`, restrict forwarding only to given addresses/subnets
- `ALLOW_FROM_ADDR_V6`: e.g. `::dead,::beef`, as above but ipv6
- `HOST_INTERFACE`: e.g. `eth0`, the LAN interface name

SSHD is also enabled in order that `TS_EXTRA_ARGS=--ssh` can be used, but this is not set by default.

Built in Actions daily to pick up latest tailscale image; though you can of course use `TS_EXTRA_ARGS=--auto-update` and leave updating the image for when there's any config change in this repository.
