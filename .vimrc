hi IncSearch ctermfg=black ctermbg=cyan cterm=BOLD
set incsearch
set wildmenu
set wildmode=longest:list,full
set history=200
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

