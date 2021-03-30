#! /bin/zsh

set -e
setopt -o EXTENDED_GLOB

export PYTHONWARNINGS=ignore

WHO="$1"

cd ~/teaching

for i in *~jetzt ; do
  if test -f $i/grade/do-grade.sh; then
    echo "/^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    echo "| /^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    echo "| | teaching/$i/grade"
    echo "| \___________________________________________________________________"
    echo "\_____________________________________________________________________"
    (cd ./$i/grade; ./do-grade.sh -w 6 -s "$WHO" | grep -v Close || true)
  fi
done
