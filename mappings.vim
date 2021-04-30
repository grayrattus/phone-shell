nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-d> 0d$:r !date +\%D\#\%T<CR>$a # <ESC>p

function! EmojiFun(emojiName)
	let result = system("emoji ".a:emojiName)
	exe "normal! a" . result . "\<Esc>"
endfunction!

:command! -nargs=1 Emoji :call EmojiFun(<q-args>)
