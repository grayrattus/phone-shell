nnoremap <C-d> 0d$:r !date +\%D\#\%T<CR>$a # <ESC>p

function! EmojiFun(emojiName)
	let result = system("emoji ".a:emojiName)
	exe "normal! a" . result . "\<Esc>"
endfunction!

function! _DoneWithoutDateFun(number)
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
endfunction!

function! DoneFun(number)
	exe "normal! 0d$"
	exe "normal! a" . system("date +\%D\#\%T") . "\<Esc>"
	exe "normal! a" . _DoneWithoutDateFun(a:number) . "\<Esc>"
	" Currently a really dirty fix. There is something wrong with emoji
	exe "normal! kJ2lp0E3lr $x"
endfunction!

function! DiaryFun(emoji, number)
	exe "normal! 0d$"
	exe "normal! a" . system("date +\%D\#\%T") . "\<Esc>"
	exe "normal! i" . _DoneWithoutDateFun(a:number) . "\<Esc>"
	if a:emoji == "cat"
		exe "normal! a" . EmojiFun("cat") . "\<Esc>"
	elseif a:emoji == "cycle"
		exe "normal! a" . EmojiFun("bicycle") . "\<Esc>"
	elseif a:emoji == "cook"
		exe "normal! a" . EmojiFun("fork-and-knife-with-plate") . "\<Esc>"
	elseif a:emoji == "program"
		exe "normal! a" . EmojiFun("desktop-computer") . "\<Esc>"
	elseif a:emoji == "uni"
		exe "normal! a" . EmojiFun("lab-coat") . "\<Esc>"
	elseif a:emoji == "love"
		exe "normal! a" . EmojiFun("red-heart") . "\<Esc>"
	endif
	" Currently a really dirty fix. There is something wrong with emoji
	exe "normal! kJ2lp0E3lr $xxx0Ellpa "
endfunction!

:command! -nargs=1 Emoji :call EmojiFun(<q-args>)
:command! -nargs=* Diary :call DiaryFun(<f-args>)
:command! -nargs=1 Done :call DoneFun(<q-args>)
