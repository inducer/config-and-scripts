#! /bin/bash

PACKAGES=(
  apcupsd
  kmod-usb3 kmod-usb-storage kmod-fs-ext4
  # for apcupsd
  kmod-usb-hid

  htop tmux
  luci-app-ddns luci-app-upnp
  etherwake luasocket
  msmtp-mta
)

opkg update
opkg install "${PACKAGES[@]}"

