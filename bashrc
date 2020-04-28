if [[ -z $_PATH ]]; then
  export _PATH=$PATH
fi

PATH=~/bin:~/.rbenv/bin:$_PATH
eval "$(rbenv init -)"

PATH=$(tr : '\n' <<< "$PATH" | grep -v /mnt/c | paste -sd :)

export EDITOR=vim
if cat /proc/version  | grep -q Microsoft; then
  if ! sudo service cron status | grep -q running; then
    sudo service cron start
  fi
fi

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls --color=auto"
alias grep="grep --color"

umask 022

PS1="\$(statusprompt '\u@\h' '\w')"

function statusprompt
{
  local lastexit=$?
  local prompt=0

  echo -en "$(systeminfo "$@") "
  ext="$(kube_info)$(tf_info)$(gitinfo)"
  if [[ ! -z $ext ]]; then
    echo -en "$ext "
  fi

  if [[ $lastexit -eq 0 ]]; then
    echo -e "$(__blue \$) "
  else
    echo -e "$(__red \$) "
  fi
}

function systeminfo
{
  echo "$(__green $1)$(__light_blue $2)"
}

function gitinfo
{
  local branch
  if branch=$(git symbolic-ref -q --short HEAD 2>/dev/null); then
    local st=$(git status -sb)
    if grep -q ahead <<< "$st"; then
      if grep -q behind <<< "$st"; then
        local sym="\xe2\x9c\x97" # ✗
      else
        local sym="\xe2\x86\x91" # ↑
      fi
    elif grep -q behind <<< "$st"; then
      local sym="\xe2\x86\x93" # ↓
    elif grep -q -v '##' <<< "$st"; then
      local sym="\xe2\x80\xa6" # …
    else
      local sym="\xe2\x9c\x93" # ✓
    fi
    echo "$(__light_magenta "($branch$sym)")"
  elif branch=$(git describe --tags --exact-match 2>/dev/null); then
    echo "$(__yellow "($branch)")"
  elif branch=$(git describe --always 2>/dev/null); then
    echo "$(__cyan "($branch)")"
  fi
}

function kube_info
{
  ctx=$(kubectl config current-context 2>/dev/null)
  if [[ ! -z $ctx ]]; then
    echo "$(__light_cyan "[$ctx]")"
  fi
}

function tf_info
{
  ws=$(cat .terraform/environment 2>/dev/null)
  if [[ ! -z $ws ]]; then
    echo "$(__gray "|$ws|")"
  fi
}

function use
{
  if [[ -z $1 ]]; then
    for d in /opt/*; do
      if ls $d/[v0-9]* > /dev/null 2>&1; then
        echo "   $(basename $d)"
      fi
    done
  elif [[ -z $2 ]]; then
    for d in /opt/$1/*/$1; do
      echo "   $(basename $(dirname $d))"
    done
  else
    ln -sf /opt/$1/$2/$1 ~/bin/$1
  fi
}



function __red { __color '31m' "$@"; }
function __green { __color '32m' "$@"; }
function __yellow { __color '33m' "$@"; }
function __blue { __color '34m' "$@"; }
function __magenta { __color '35m' "$@"; }
function __cyan { __color '36m' "$@"; }
function __gray { __color '37m' "$@"; }
function __dim_gray { __color '90;1m' "$@"; }
function __light_red { __color '91;1m' "$@"; }
function __light_green { __color '92;1m' "$@"; }
function __light_yellow { __color '93;1m' "$@"; }
function __light_blue { __color '94;1m' "$@"; }
function __light_magenta { __color '95;1m' "$@"; }
function __light_cyan { __color '96;1m' "$@"; }

function __color {
  if [[ $prompt ]]; then
    echo "\001\033[$1\002${@:2}\001\033[0m\002";
  else
    echo "\033[$1${@:2}\033[0m";
  fi
}

function __test_colors {
  echo -e $(__red red)
  echo -e $(__green green)
  echo -e $(__yellow yellow)
  echo -e $(__blue blue)
  echo -e $(__magenta magenta)
  echo -e $(__cyan cyan)
  echo -e $(__gray gray)
  echo -e $(__dim_gray dim_gray)
  echo -e $(__light_red light_red)
  echo -e $(__light_green light_green)
  echo -e $(__light_yellow light_yellow)
  echo -e $(__light_blue light_blue)
  echo -e $(__light_magenta light_magenta)
  echo -e $(__light_cyan light_cyan)
}
