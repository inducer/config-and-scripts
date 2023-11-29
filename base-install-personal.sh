#! /bin/bash

set -e

function with_echo()
{
  echo "$@"
  $@
}
PACKAGES=(
  spectre-meltdown-checker smartmontools
  netcat-traditional elinks
  iucode-tool
  rsync cronie
  etckeeper logrotate gnupg2 scdaemon keepassxc
  htop iotop iftop tcpdump mtr ncdu rsync unison unison-gtk s-tui
  tmux screen tmate sudo apt-listbugs apt-listchanges reptyr sshfs sshuttle
  transmission xsel
  zsh
  moreutils gawk
  tig subversion mercurial git-lfs gh git-absorb git-autofixup git-delta repo meld
  qgit
  curl
  mlocate pwgen
  libgmp-dev libmpfr-dev
  libpq-dev libjemalloc-dev
  vim-gtk3 neovim emacs exuberant-ctags micro gedit aspell-de aspell-en
  python3-psutil python3-yaml python3-websockets
  net-tools acl
  pypy3 pypy3-dev
  python3-scipy python3-matplotlib
  swig
  python3-pyqt5
  flake8 python3-pep8-naming
  python3-dbg python3-venv python3-virtualenv python3-pip-whl
  python3.11-dbg python3.11-dev python3.11-venv python3-poetry
  silversearcher-ag ripgrep fzf fd-find
  texlive-xetex texlive-publishers texlive-science texlive-bibtex-extra biber
  texlive-fonts-extra cm-super dvipng latexdiff psutils pdftk texlive-extra-utils
  chktex dvidvi fragmaster lacheck latexmk purifyeps texlive-luatex
  pandoc
  mc
  graphviz inkscape gnucash
  gmsh occt-draw occt-misc libxi-dev rapidjson-dev freecad
  libocct-{ocaf,data-exchange,draw,foundation,modeling-algorithms,modeling-data,visualization}-dev
  libopenmpi-dev openmpi-common mpich libmpich-dev
  systemd-coredump
  likwid cpufrequtils linux-perf time numactl libunwind-dev
  ffmpeg ffmpegthumbnailer
  ocl-icd-opencl-dev ocl-icd-libopencl1 oclgrind
  build-essential packaging-dev pkgconf ninja-build cmake cmake-curses-gui
  gcc-multilib
  llvm-dev libclang-dev gdb strace ltrace valgrind
  libblas-dev liblapack-dev libopenblas-dev
  opensc-pkcs11
  libboost-all-dev
  kitty
  maxima wxmaxima
  shellcheck
  bison flex
  npm yarnpkg
  golang
  octave paraview
  qemu qemu-user-static virtualbox-qt
  libelf-dev dwarves
  dconf-editor
  restic
  katarakt
  geeqie darktable gajim
  nebula
  yubikey-manager yubikey-manager-qt

  # zotero needs this
  libbus-glib-1-2

  # xournal++ wants these
  libcairo-dev libgtk-3-dev libpoppler-glib-dev portaudio19-dev libsndfile-dev \
  libxml2-dev liblua5.3-dev libzip-dev librsvg2-dev gettext lua-lgi \
  libgtksourceview-4-dev help2man

  sqlite3 sqlitebrowser

  notmuch notmuch-git libnotmuch-dev

  firefox firefox-l10n-de chromium

  # for pop shell
  node-typescript

  msmtp offlineimap

  nextcloud-desktop nextcloud-desktop-cmd nextcloud-desktop-l10n
  nautilus-nextcloud

  imagemagick graphicsmagick  heif-thumbnailer heif-gdk-pixbuf libheif-examples

  flatpak
)

with_echo apt install aptitude "${PACKAGES[@]}"

# vim: foldmethod=marker
