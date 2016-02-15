fun! SetTabBehavior()
	if &ft =~ 'ruby\|javascript\|html'
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

map q <Nop>
map Q <Nop>

set hls
