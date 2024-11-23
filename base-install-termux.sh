#! /bin/bash

PACKAGES=(
  helix helix-grammars
  vim
  git
  broot
  zoxide
  lazygit
  ncdu
  python
  ndk-sysroot
  make clang
  zsh
  pwgen
  openssh
  okc-agents
  nodejs yarn
  lazygit
  git-delta
  fzf
  fd
  ripgrep
)
pkg install "${PACKAGES[@]}"
