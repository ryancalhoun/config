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
		echo -e " \033[34;1m\$\033[0m "
	else
		echo -e " \033[31;1m\$\033[0m "
	fi
}

function systeminfo
{
	echo "\033[32;1m$1\033[34;1m$2\033[0m"
}

function gitinfo
{
	local branch
	if branch=$(git symbolic-ref -q --short HEAD 2>/dev/null); then
		echo " \033[35;1m($branch)\033[0m"
	elif tag=$(git describe --tags --exact-match 2>/dev/null); then
		echo " \033[33;1m($tag)\033[0m"
	elif sha=$(git describe --always 2>/dev/null); then
		echo " \033[36;1m($sha)\033[0m"
	fi
}

