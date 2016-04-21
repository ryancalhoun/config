if [[ -z $_PATH ]]; then
	export _PATH=$PATH
fi

export EDITOR=vim

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

PS1="\$(statusprompt '\u@\h' '\w')"

function statusprompt
{
	local lastexit=$?

	echo -en "$(systeminfo "$@")$(gitinfo)"

	if [[ $lastexit -eq 0 ]]; then
		echo -e " $(__blue \$) "
	else
		echo -e " $(__red \$) "
	fi
}

function systeminfo
{
	echo -e "$(__green $1)$(__blue $2)"
}

function gitinfo
{
	local branch
	if branch=$(git symbolic-ref -q --short HEAD 2>/dev/null); then
		echo " $(__magenta "($branch)")"
	elif tag=$(git describe --tags --exact-match 2>/dev/null); then
		echo " $(__yellow "($tag)")"
	elif sha=$(git describe --always 2>/dev/null); then
		echo " $(__cyan "($sha)")"
	fi
}

function __red { __color '31;1m' "$@"; }
function __green { __color '32;1m' "$@"; }
function __yellow { __color '33;1m' "$@"; }
function __blue { __color '34;1m' "$@"; }
function __magenta { __color '35;1m' "$@"; }
function __cyan { __color '36;1m' "$@"; }

function __color { echo -e "\001\033[$1\002${@:2}\001\033[0m\002"; }

