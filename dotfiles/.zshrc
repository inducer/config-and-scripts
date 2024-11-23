# shell key bindings ----------------------------------------------------------
bindkey -v
#bindkey -M viins "^R" history-incremental-search-backward

# fzf -------------------------------------------------------------------------
if test -x /usr/bin/fdfind; then

  # Setting fd as the default source for fzf
  export FZF_DEFAULT_COMMAND='fdfind --type f -H'

  _fzf_compgen_path() {
    fdfind --hidden --follow --exclude ".git" . "$1"
  }

  # Use fd to generate the list for directory completion
  _fzf_compgen_dir() {
    fdfind --type d --hidden --follow --exclude ".git" . "$1"
  }

  export FZF_ALT_C_COMMAND="fdfind --follow -t d . $HOME"
fi

source_if_exists()
{
  if test -f "$1"; then
    source "$1"
  fi
}

if test -d ~/shared/pack/fzf; then
  MY_FZF_PATH=$HOME/shared/pack/fzf
elif test -d ~/pack/fzf; then
  MY_FZF_PATH=$HOME/pack/fzf
else
  echo "fzf is missing: https://github.com/junegunn/fzf.git"
fi

source_if_exists $MY_FZF_PATH/shell/completion.zsh
source_if_exists $MY_FZF_PATH/shell/key-bindings.zsh


# shell options ---------------------------------------------------------------
setopt auto_cd
setopt no_menu_complete
setopt auto_menu
setopt correct
setopt multios
setopt path_dirs
setopt auto_pushd
setopt extended_glob
setopt no_hup
setopt no_check_jobs
setopt hist_ignore_dups
setopt no_nomatch
setopt completeinword
setopt listtypes

setopt long_list_jobs
setopt notify
setopt sharehistory

setopt prompt_subst

HISTFILE=~/.zshhistory
HISTSIZE=10000
SAVEHIST=10000

# prompt helpers --------------------------------------------------------------
XTERM_TITLE_BEGIN=`echo "\033]0;"`
XTERM_TITLE_END=`echo "\007"`
SCREEN_TITLE_BEGIN=`echo "\033k"`
SCREEN_TITLE_END=`echo "\033\\\\"`
SCREEN_HARDSTATUS_BEGIN=`echo "\033_"`
SCREEN_HARDSTATUS_END=`echo "\033\\\\"`

# set up the prompt -----------------------------------------------------------

# https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html
# vcs_info: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# colors: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Other-Functions

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:git*' formats "[%b %{$fg_bold[red]%}%a%m%u%c%{$reset_color%}] "
zstyle ':vcs_info:git:*' check-for-changes 'true'
zstyle ':vcs_info:git*:*' get-revision true

zstyle ':vcs_info:git*+set-message:*' hooks git-st git-stash

# {{{ vcs_info enhancers
#
# Show remote ref name and number of commits ahead-of or behind
# https://www.eseth.org/2010/git-in-zsh.html
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+=" (${stashes} sta)"
    fi
}

# Show remote ref name and number of commits ahead-of or behind
# https://www.eseth.org/2010/git-in-zsh.html
function +vi-git-st() {
    local ahead behind remote
    local -a gitstatus

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
        (( $ahead )) && gitstatus+=( "${c3}+${ahead}${c2}" )

        behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)
        (( $behind )) && gitstatus+=( "${c4}-${behind}${c2}" )

        hook_com[branch]="%{$fg_bold[blue]%}${hook_com[branch]}%{$reset_color%}=${remote}${(j:/:)gitstatus}"
    fi
}

# }}}


# runs vcs_info (to populate variables) before showing the prompt
precmd() { vcs_info }

PROMPT='${vcs_info_msg_0_}%B%~%b '
RPROMPT=' %{$fg_bold[blue]%}%n@%m %{$reset_color%}%B%T%{$reset_color%}'
PROMPT="$PROMPT%{$XTERM_TITLE_BEGIN%n@%m - %~$XTERM_TITLE_END%}"

# -------------------------------------------------------------------------
# common shell setup stuff
# -------------------------------------------------------------------------

source ~/.shellrc_common

# -----------------------------------------------------------------------------
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=0
zstyle ':completion:*' substitute 1
zstyle :compinstall filename '/home/andreas/.zshrc'

zstyle ':completion:*' list-colors no=00 fi=00 di=01\;34 \
  ln=target pi=40\;33 so=01\;35 do=01\;35 bd=40\;33\;01 cd=40\;33\;01 \
  or=40\;31\;01 ex=01\;32

autoload -Uz compinit
compinit
# End of lines added by compinstall

if [ $commands[gh] ]; then
  source <(gh completion --shell zsh)
  compdef _gh gh
fi

loadpkg()
{
  local pkgname="$1"
  local pkgurl="$2"
  if test -d "$HOME/pack/$pkgname"; then
    . "$HOME/pack/$pkgname/$pkgname.zsh"
  elif test -d "$HOME/shared/pack/$pkgname"; then
    . "$HOME/shared/pack/$pkgname/$pkgname.zsh"
  else
    echo "$pkgname is missing: $pkgurl"
  fi
}

# loadpkg zsh-autosuggestions "https://github.com/zsh-users/zsh-autosuggestions.git"
# bindkey '^ ' autosuggest-accept
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#e0e0e0,bg=cyan,bold,underline"

loadpkg zsh-syntax-highlighting "https://github.com/zsh-users/zsh-syntax-highlighting.git"


if test -d $HOME/pack/zsh-completions; then
  fpath=($HOME/pack/zsh-completions $fpath)
elif test -d $HOME/shared/pack/zsh-completions; then
  fpath=($HOME/shared/pack/zsh-completions $fpath)
else
  echo "zsh completions is missing: https://github.com/zsh-users/zsh-completions.git"
fi

source <(zoxide init zsh)
# source <(command fx --init)
source <(broot --print-shell-function zsh)

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    local manual_loc=$HOME/pack/lazygit/lazygit
    if test -x $manual_loc; then
      ~/pack/lazygit/lazygit "$@"
    else
      lazygit "$@"
    fi

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# vim: sw=2
