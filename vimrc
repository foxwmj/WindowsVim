set nocompatible
set t_Co=256                " Color number

" import windows
if filereadable(expand("~/.vim/vendor/gvim_windows/gvim_windows_default.vim"))
    source ~/.vim/vendor/gvim_windows/gvim_windows_default.vim
endif

if filereadable(expand("~/.vim/vendor/gvim_windows/mswin.vim"))
    source ~/.vim/vendor/gvim_windows/mswin.vim
endif

"==============================================
" vim-plug
"==============================================
set nocompatible               " be iMproved
filetype off                   " required!

if has('win32') || has('win64')
    call plug#begin("d:\\WindowsVim\\vim.plug.runtime")
else
    call plug#begin()
endif

" My Bundles here:
" ----------------
Plug 'taglist.vim'
Plug 'a.vim'
Plug 'molokai'
Plug 'The-NERD-tree'
Plug 'L9'
Plug 'FuzzyFinder'
Plug 'Tagbar'             " browse the tags of the current file and get an overview of its structure
" ------------------------------------------------------------------
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
" ------------------------------
" How to solve YCM start slowly
" https://github.com/Valloric/YouCompleteMe/issues/893
" ------------------------------
function! YCMInstall(info)
  if a:info.status == 'installed'
    !python install.py --clang-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'on': [], 'do': function('YCMInstall') }

function! YCM()
    call plug#load('YouCompleteMe')
    if exists('g:loaded_youcompleteme')
        call youcompleteme#Enable()
    endif
endfunction
" ------------------------------
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
" ------------------------------
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" ------------------------------------------------------------------

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on


"==============================================
" My Setting
"==============================================

" Unmap
"-------------------
unmap <C-Y>

" Color
"-------------------
colorscheme molokai

"No Backup and exchanged file
"-------------------
set nobackup
set noswapfile
set noundofile

"Encoding 
"-------------------
set encoding=utf-8
set fileencodings=utf-8,cp936,gb2312,gb18030,gbk,ucs-bom,latin1
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
if has('win32') || has('win64')
    language messages zh_CN.utf-8                " print message with chinese
endif

"Maximun the window
"-------------------
if (has("gui_running"))
    set nowrap
    set guioptions+=b
    autocmd GUIEnter * simalt ~x
else
    set wrap
endif

"Font
"-------------------
if has('win32') || has('win64')
    "set guifont=Inconsolata:h12
    set guifont=DejaVu_Sans_Mono:h10:cANSI
else
    set guifont=DejaVu\ Sans\ Mono\ 10
endif

"Editor setting
"-------------------
syntax enable
syntax on
set number
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set autoindent
set incsearch
set hlsearch
set ignorecase



if filereadable(expand("~/.vim/shortcut"))
    source ~/.vim/shortcut
endif

if filereadable(expand("~/.vim/function"))
    source ~/.vim/function
endif
