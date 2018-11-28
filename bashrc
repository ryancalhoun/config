if [[ -z $_PATH ]]; then
	export _PATH=$PATH
fi

PATH=~/.rbenv/bin:$_PATH
eval "$(rbenv init -)"

export EDITOR=vim

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias ls="ls --color=auto"

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
	echo "$(__green $1)$(__blue $2)"
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
		echo " $(__magenta "($branch$sym)")"
	elif branch=$(git describe --tags --exact-match 2>/dev/null); then
		echo " $(__yellow "($branch)")"
	elif branch=$(git describe --always 2>/dev/null); then
		echo " $(__cyan "($branch)")"
	fi
}

function __red { __color '31;1m' "$@"; }
function __green { __color '32;1m' "$@"; }
function __yellow { __color '33;1m' "$@"; }
function __blue { __color '34;1m' "$@"; }
function __magenta { __color '35;1m' "$@"; }
function __cyan { __color '36;1m' "$@"; }

function __color { echo "\001\033[$1\002${@:2}\001\033[0m\002"; }

