#! /bin/bash

steamos-readonly disable
pacman-key --init
pacman-key --populate
pacman -Syu tmux nodejs openssh libfido2 yarn \
        ccid opensc
systemctl enable sshd
systemctl start sshd

echo "WARNING: Check sshd config to ensure no password auth"
