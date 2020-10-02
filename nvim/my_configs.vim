" close nerdtree if file is closed
" let NERDTreeMapOpenInTab='<ENTER>'
let NERDTreeChristmasTree = 1
let NERDTreeMapActivateNode='<CR>'
let NERDTreeQuitOnOpen=1
let g:ycm_python_binary_path = 'python'
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'
let g:ycm_autoclose_preview_window_after_completion = 1
let t:miniBufExplSortBy = 'name'
let g:airline#extensions#tabline#enabled = 1
fun! ToggleCC()
  if &cc == ''
    set cc=100,120
  else
    set cc=
    endif
endfun

nnoremap <F2> :call ToggleCC()<CR>
nmap <F8> :TagbarToggle<CR>

set backupcopy=yes
set nowritebackup
nnoremap <leader>yy :YcmCompleter GetType<CR>
nnoremap <leader>y; :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <leader>yo :YcmCompleter OrganizeImports<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fast editing and reloading of vimrc configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>c :e! ~/.vim_runtime/my_configs.vim<cr>
autocmd! bufwritepost ~/.vim_runtime/my_configs.vim source ~/.vim_runtime/my_configs.vim

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_custom_ignore = {
      \ 'dir': 'node_modules\|DS_Store\|git\|public\/jspm_packages\|vendor',
      \ 'file': 'public/.*\.js$'
      \ }
let g:ale_maximum_file_size = "3000"
let g:tagbar_ctags_bin="/usr/bin/ctags"

"Tagbar typesript configuration needs also .clang file for typescript
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }
""""""""""""""""""""
"Alt+1,2 for traversing tabs like sublime
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-10> 10gt
"""""""""""""""""""""""""""""""
"Move current line to up down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

let g:easyescape_timeout = 500
"Toggle quickfix with ,e
function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>
""""""" Ctrlp prompt open new tab on enter
"let g:ctrlp_prompt_mappings = {
    "\ 'AcceptSelection("e")': ['<c-t>'],
    "\ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    "\ }

" search and replace of the virtual selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"remove trailing whitespace
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"Inc/dec value under cursor need nextval.vim plugin
nmap <silent> <A-Up> <Plug>nextvalInc
nmap <silent> <A-Down> <Plug>nextvalDec

map <C-n> :NERDTreeFind<CR>
nnoremap q: :q
autocmd BufWritePre *.[jt]s :%s/\s\+$//e
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" FUNCTION: s:openInNewTab(target) {{{1
function! OpenInNewTab(node)
  call a:node.activate()
  if a:node.path.isDirectory
  else
    call a:node.activate({'where': 't'})
    call g:NERDTreeCreator.CreateMirror()
    wincmd l
  endif
endfunction
"""""""""""""""""""""""""""
let g:ale_linters = {
      \   'typescript': ['tsserver'],
      \}
let g:ale_typescript_tsserver_use_global = 1
autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None 
set nofoldenable    " disable folding
set clipboard^=unnamed
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Open todo file
map <leader>q :e ~/.todo<CR>

" Ack/grep on in git's root
function! Find_git_root()
  system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! -nargs=1 Ag execute "Ack! <args> " . Find_git_root()

" First find the word on cursor
map * *N

" assign Ngb to jump to buffer
let c = 1
while c <= 99
  execute "nnoremap " . c . "gb :" . c . "b\<CR>"
  execute "nnoremap " . c . "bd :" . c . "bd\<CR>"
  let c += 1
endwhile
