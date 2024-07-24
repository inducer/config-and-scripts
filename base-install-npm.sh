#! /bin/bash

# use tips from here
# https://yourlabs.org/posts/2020-02-05-npm-install-g-home-local/
# to bend -g to ~/.local
#
# i.e.
#
# export PATH=$HOME/.local/bin:$PATH
# export NODE_PATH=$HOME/.local/lib/node_modules:$NODE_PATH
# export npm_config_prefix=$HOME/.local

npm install -g typescript-language-server
npm install -g 'eslint@<9' eslint-config-airbnb-base eslint-plugin-import
npm install -g vscode-langservers-extracted
