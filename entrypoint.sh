#!/usr/bin/env bash
set -eEuo pipefail
cmd="$@"

dnsmasq --no-daemon --interface="$HOST_INTERFACE" &

# MARK necessary to allow devices behind the subnet router to reach the
# tailnet with SNAT: https://github.com/tailscale/tailscale/pull/18318
chain=('--table=mangle' '--insert=FORWARD')
if_cond=("--in-interface=$HOST_INTERFACE" '--out-interface=tailscale0')
# optionally restrict to the given $ALLOW_FROM_ADDR_V4/6 (e.g. it (V4)
# may be the whole $TS_ROUTES, or it could be completely disjoint.
src_cond4=()
src_cond6=()
if [ -n "${ALLOW_FROM_ADDR_V4-}" ]; then
    src_cond4=("--source=$ALLOW_FROM_ADDR_V4")
    iptables "${chain[@]}" ! "${src_cond4[@]}" "${if_cond[@]}" --jump=DROP
fi
if [ -n "${ALLOW_FROM_ADDR_V6-}" ]; then
    src_cond6=("--source=$ALLOW_FROM_ADDR_V6")
    ip6tables "${chain[@]}" ! "${src_cond6[@]}" "${if_cond[@]}" --jump=DROP
fi

mark=('--jump=MARK' '--set-xmark=0x40000/0xff0000')
iptables "${chain[@]}" "${src_cond4[@]}" "${if_cond[@]}" "${mark[@]}"
ip6tables "${chain[@]}" "${src_cond6[@]}" "${if_cond[@]}" "${mark[@]}"

exec "${cmd[@]}"
