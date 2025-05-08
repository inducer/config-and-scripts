#! /bin/bash

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
