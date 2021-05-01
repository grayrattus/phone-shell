nnoremap <C-d> 0d$:r !date +\%D\#\%T<CR>$a # <ESC>p

function! EmojiFun(emojiName)
	let result = system("emoji ".a:emojiName)
	exe "normal! a" . result . "\<Esc>"
endfunction!

function! DoneFun(number)
	exe "normal! 0d$"
	exe "normal! a" . system("date +\%D\#\%T") . "\<Esc>"
	if a:number == "1"
		exe "normal! a" . EmojiFun("grinning-face") . "\<Esc>"
	elseif a:number == 2
		exe "normal! a" . EmojiFun("smirking-face") . "\<Esc>"
	elseif a:number == 3
		exe "normal! a" . EmojiFun("neutral-face") . "\<Esc>"
	elseif a:number == 4
		exe "normal! a" . EmojiFun("slightly-frowning-face") . "\<Esc>"
	elseif a:number == 5
		exe "normal! a" . EmojiFun("loudly-crying-face") . "\<Esc>"
	elseif a:number == 6
		exe "normal! a" . EmojiFun("grinning-face") . "\<Esc>"
	endif
	" Currently a really dirty fix. There is something wrong with emoji
	exe "normal! p2k3J2lxi "
endfunction!

:command! -nargs=1 Emoji :call EmojiFun(<q-args>)
:command! -nargs=1 Done :call DoneFun(<q-args>)
