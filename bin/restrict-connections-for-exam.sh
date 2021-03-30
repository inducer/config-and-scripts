#! /bin/bash

# in sudoers:
# exam root = NOPASSWD: /etc/restrict-connections-for-exam.sh

set -e
set -x

iptables -F OUTPUT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -d 130.126.112.202  -j ACCEPT
iptables -A OUTPUT -p udp --dport 53  -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53  -j ACCEPT
iptables -A OUTPUT -p tcp -j REJECT
iptables -A OUTPUT -p udp -j REJECT
iptables -P OUTPUT DROP
