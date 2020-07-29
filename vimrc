fun! SetTabBehavior()
	filetype detect
	if &ft =~ 'ruby\|perl\|python\|groovy\|sh\|javascript\|text\|html\|haml\|css\|sass\|yaml\|json\|tf\|vue\|ejs\|markdown'
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
au BufRead,BufNewFile *.html.ejs set filetype=ejs syntax=html
au BufRead,BufNewFile *.txt.ejs set filetype=ejs syntax=text
au BufReadPost * call RecallFilePos()
au BufReadPost,BufNewFile * call SetTabBehavior()

map q <Nop>
map Q <Nop>

set hls
set bs=2

syntax on
hi shCommandSub ctermfg=white
