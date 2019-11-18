fun! SetTabBehavior()
	filetype detect
	if &ft =~ 'ruby\|perl\|python\|sh\|javascript\|html\|haml\|css\|sass\|yaml\|json\|tf\|vue\|markdown'
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

au BufRead,BufNewFile *.tf set syntax=tf
au BufRead,BufNewFile *.tfvars set filetype=tf syntax=tf
au BufReadPost * call RecallFilePos()
au BufReadPost,BufNewFile * call SetTabBehavior()

map q <Nop>
map Q <Nop>

set hls
set bs=2

syntax on
