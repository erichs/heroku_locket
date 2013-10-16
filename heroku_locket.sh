# heroku_locket.sh - lock in app selection for your heroku commands
# v0.1, erichs

_heroku_app() {
  [ -n "$HEROKU_APP" ] && echo "%{%F{magenta}%}heroku: %{%F{blue}%}${HEROKU_APP}%{%f%}"
}

RPROMPT='$(_heroku_app)'

# call applock() to lock-in your app selection, supports tab completion 
applock() {
  local list
  list="$(heroku apps)"
  if $(echo $list | grep -q $1); then
    export HEROKU_APP=$1
  else
    echo "You must choose from one of the following apps:"
    echo $list
  fi
}

_applock_complete() {
  local word completions
  word="$1"
  completions="$(heroku apps | grep -v '^=' | grep -v '^$' | cut -d' ' -f1)"
  reply=( "${(ps:\n:)completions}" )
}
compctl -K _applock_complete applock

# call appunlock() to remove your selection
appunlock() {
  unset HEROKU_APP
}

heroku() {
  if [ -n "$HEROKU_APP" ]; then
    echo "executing: heroku $@ --app $HEROKU_APP"
    command heroku $@ --app $HEROKU_APP
  else
    command heroku $@
  fi
}

: <<EOF
License: The MIT License

Copyright © 2013 Erich Smith

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be included in all copies
or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
EOF
