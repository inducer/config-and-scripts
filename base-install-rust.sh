#! /bin/bash

set -eo pipefail

# add rustup?

function ci() {
  cargo install --locked "$@"
  
}

ci typos-cli
ci --git https://github.com/tekumara/typos-lsp.git
ci fclones
ci tealdeer
ci skim
ci difftastic
ci --git https://codeberg.org/mergiraf/mergiraf.git
ci yazi-build

# https://tectonic-typesetting.github.io/book/latest/howto/build-tectonic/external-dep-install.html
CXXFLAGS="-std=c++20" ci tectonic -F external-harfbuzz
(cd "$HOME/.cargo/bin" && ln -s tectonic nextonic)

ci --git https://github.com/latex-lsp/texlab
# --tag <insert version here>
