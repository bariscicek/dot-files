let g:ale_use_deprecated_neovim=1
set belloff=all

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <Esc>
cnoremap kj <Esc>

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
let g:solarized_termcolors=256
