fun! SetTabBehavior()
	filetype detect
	if &ft =~ 'ruby\|python\|javascript\|html\|haml\|css\|sass\|yaml'
		set ts=2 sw=2 et
	else
		set ts=4 sw=4
	endif
endfun

fun! RecallFilePos()
	if line("'\"") > 0 && line("'\"") <= line("$")
		exe "normal g`\""
	endif
endfun

au BufReadPost * call RecallFilePos()
au BufReadPost,BufNewFile * call SetTabBehavior()
au BufRead,BufNewFile *.tf set syntax=terraform

map q <Nop>
map Q <Nop>

set hls
set bs=2

syntax on
