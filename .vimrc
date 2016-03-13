hi IncSearch ctermfg=black ctermbg=cyan cterm=BOLD
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%100v', 100)

let mapleader=','
noremap ' ,

" edit files in directory of current buffer
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

set incsearch
set wildmenu
set wildmode=longest:list,full
set history=200
nnoremap <silent> øb :bprevious
nnoremap <silent> æb :bnext
 map <C-h> <C-w>h 
 map <C-j> <C-w>j 
 map <C-k> <C-w>k 
 map <C-l> <C-w>l 
set number
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
" "+y is the sequence to copy TO the Windows clipboard
" "+p is the sequence to copy FROM the Windows clipboard
function! Putclip(type, ...) range
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  if a:type == 'n'
    silent exe a:firstline . "," . a:lastline . "y"
  elseif a:type == 'c'
    silent exe a:1 . "," . a:2 . "y"
  else
    silent exe "normal! `<" . a:type . "`>y"
  endif
  "call system('putclip', @@)
  "  "As of Cygwin 1.7.13, the /dev/clipboard device was added to provide
  "    "access to the native Windows clipboard. It provides the added benefit
  "      "of supporting utf-8 characters which putclip currently does not.
  "      Based
  "        "on a tip from John Beckett, use the following:
  call writefile(split(@@,"\n"), '/dev/clipboard')
  let &selection = sel_save
  let @@ = reg_save
  endfunction

vnoremap <silent> <leader>y :call Putclip(visualmode(), 1)
nnoremap <silent> <leader>y :call Putclip('n', 1)

"=====[ Highlight matches when jumping to next ]=============
nnoremap <silent> n n:call HLNext(0.4)
nnoremap <silent> N N:call HLNext(0.4)
function! HLNext (blinktime)
highlight WhiteOnRed ctermfg=white ctermbg=red
let [bufnum, lnum, col, off] = getpos('.')
let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
let target_pat = '\c\%#'.@/
let ring = matchadd('WhiteOnRed', target_pat, 101)
redraw
exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
call matchdelete(ring)
redraw
endfunction
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list
" let g:netrw_liststyle=3
