tailscale/tailscale, plus forwarding DNS queries on the local interface to the tailnet (MagicDNS, and whatever is configured).

All env vars etc. as per the upstream image; defaults unchanged except `TS_ACCEPT_DNS=1` (it doesn't make sense to decline it) and the addition of:
- `HOST_INTERFACE`: e.g. `eth0`, the LAN interface name

SSHD is also enabled in order that `TS_EXTRA_ARGS=--ssh` can be used, but this is not set by default.

Built in Actions daily to pick up latest tailscale image; though you can of course use `TS_EXTRA_ARGS=--auto-update` and leave updating the image for when there's any config change in this repository.
