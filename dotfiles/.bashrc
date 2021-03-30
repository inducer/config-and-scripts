source ~/.shellrc_common

if [ ! "x$TERM" = "xemacs" ]; then
  SAVE="\0337"
  RESTORE="\0338"
  PROMPT_PREFIX="\[$SAVE\033[34;1m\033[1;57f \u@\h         $RESTORE\]"
  if [ "x$TERM" = "xxterm" ]; then
    PROMPT_PREFIX="$PROMPT_PREFIX\[\033]0;\u@\h - \w\007\]"
    fi
  PROMPT_PREFIX="$PROMPT_PREFIX\[$SAVE\033[1m\033[1;72f\t$RESTORE\]"
  PS1="$PROMPT_PREFIX\[\033[1m\]\w\[\033[0m\] "
  PS2="$PROMPT_PREFIX\[\033[1m\]...\[\033[0m\] "
  export PROMPT_COMMAND="\
  PS1=\"$PROMPT_PREFIX\[\033[1m\]\w\[\033[0m\] \"
  PS2=\"$PROMPT_PREFIX\[\033[1m\]...\[\033[0m\] \""
else
  unset PROMPT_COMMAND
  export PS1="[\w] "
fi

set -o vi
