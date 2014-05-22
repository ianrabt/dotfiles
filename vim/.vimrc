colorscheme pablo
set bg=dark
set tabstop=4
set shiftwidth=4
"set expandtab
set nu
set nowrap
set cul
filetype plugin indent on
syntax on
execute pathogen#infect()
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE
highlight CursorLine term=NONE cterm=NONE
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
" groovyness in Insert mode (lets you paste and keep on typing)
" This blows away i_CTRL-V though (see :help i_CTRL-V)
imap <C-v> <Esc><C-v>a

function ShowTabs()
	syntax match Tab /\t/
	hi Tab cterm=underline ctermfg=blue
endfunction

" Show all tab characters when F2 is pressed
nmap <F2> :call ShowTabs() <CR>
" And hide them with F3
nmap <F3> :hi Tab cterm=none <CR>

nmap <F4> :TlistToggle <CR>
nmap <F7> :tabp <CR>
nmap <F8> :tabn <CR>
