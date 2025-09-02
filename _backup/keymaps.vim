" Custom Keymaps

nmap <silent><leader>qa :qa<cr>
nmap <silent><leader>xa :xa<cr>

" tabpage
" https://neovim.io/doc/user/tabpage.html
nmap <silent><leader>ts :tab split<cr>
nmap <silent><leader>tml :-tabmove<cr>
nmap <silent><leader>tmr :+tabmove<cr>
nmap <silent><leader>tmz :0tabmove<cr>

" term emulator
" lt stands for linux term as wt is for windows term
nmap <silent><leader>lt :bel sp 100 \| resize 15 \| term<cr><S-A>
nmap <silent><leader>gdb :bel sp \| resize 15 \| term<cr><S-A>gdb<cr><cr>
:tnoremap <silent><Esc> <C-\><C-n>
:tnoremap <silent><Esc><Esc> <C-\><C-n>:q<cr>

" iamroot18
nmap <silent><leader>1 <ESC>a/* IAMROOT, <C-R>=strftime("%Y.%m.%d")<CR>:*/<LEFT><ESC>
nmap <silent><leader>2 <ESC>o/* IAMROOT, <C-R>=strftime("%Y.%m.%d")<CR>:<CR><BS>/<ESC><UP><END>

