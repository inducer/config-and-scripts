#! /bin/bash

steamos-readonly disable
pacman-key --init
pacman-key --populate
pacman -S tmux nodejs openssh
systemctl enable sshd
systemctl start sshd

echo "WARNING: Check sshd config to ensure no password auth"
