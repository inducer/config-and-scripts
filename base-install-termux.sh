#! /bin/bash

PACKAGES=(
  helix helix-grammars
  vim
  git
  python python-venv
  ndk-sysroot
  make clang
  zsh
  pwgen
  openssh
  okc-agents
  nodejs yarn
)
pkg install "${PACKAGES[@]}"
