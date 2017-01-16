set nocompatible
set t_Co=256                " Color number

if has('win32') || has('win64')
    let s:PATH_DIVISOR = "\\"
else
    let s:PATH_DIVISOR = "/"
endif
let s:VIMRC_PATH = expand('<sfile>:p:h')

" import windows
" ~/.vim/vendor/gvim_windows/gvim_windows_default.vim"
let s:WINDOWS_VIM = s:VIMRC_PATH . s:PATH_DIVISOR . "vendor" . s:PATH_DIVISOR . "gvim_windows" . s:PATH_DIVISOR . "gvim_windows_default.vim"
if filereadable(s:WINDOWS_VIM)
    exec "source " . s:WINDOWS_VIM
endif

" ~/.vim/vendor/gvim_windows/mswin.vim"
let s:MSWIN_VIM = s:VIMRC_PATH . s:PATH_DIVISOR . "vendor" . s:PATH_DIVISOR . "gvim_windows" . s:PATH_DIVISOR . "mswin.vim"
if filereadable(s:MSWIN_VIM)
    exec "source " . s:MSWIN_VIM
endif


"==============================================
" vim-plug
"==============================================
set nocompatible               " be iMproved
filetype off                   " required!

if has('win32') || has('win64')
    let s:PLUG_PATH = s:VIMRC_PATH . s:PATH_DIVISOR . "vim.plug.runtime"
else
    let s:PLUG_PATH = s:VIMRC_PATH . s:PATH_DIVISOR . "plugged"
endif
call plug#begin(s:PLUG_PATH)

" My Bundles here:
" ----------------
Plug 'a.vim'
Plug 'molokai'
Plug 'The-NERD-tree'
Plug 'L9'
Plug 'FuzzyFinder'
Plug 'Tagbar'             " browse the tags of the current file and get an overview of its structure

Plug 'tpope/vim-fugitive' " Git wrapper
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" ------------------------------------------------------------------
Plug 'tpope/vim-fugitive' " Git wrapper
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" ------------------------------------------------------------------
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets' " Snippets are separated from the engine. Add this if you want them:
" ------------------------------------------------------------------
Plug 'aert/vim-powerline' " Lokaltod/vim-powerline fail. 
let g:powerline_symbols = 'fancy'

" ------------------------------------------------------------------
Plug 'SirVer/ultisnips'

" Add ~/.vim/vendor to rtp(RunTimePath)
let s:VENDOR_PATH= s:VIMRC_PATH . s:PATH_DIVISOR . "vendor"
if isdirectory(s:VENDOR_PATH)
    exec "set rtp+=" . s:VENDOR_PATH
endif
let g:UltiSnipsSnippetDirectories=["UltiSnips","wmj_snippets"]           
" ~/.vim/vendor/{ft}.snippets
function! EditFtSnippet()
    let s:WORKING_FT_SNIPPET = s:VENDOR_PATH . s:PATH_DIVISOR . "wmj_snippets" . s:PATH_DIVISOR . &filetype . ".snippets"
    exec "vsplit " . s:WORKING_FT_SNIPPET
    "autocmd Buf
endfunction
if !exists(":FT")
    command FT call EditFtSnippet()
endif
" ------------------------------------------------------------------



" Plug 'Valloric/YouCompleteMe' 
" ------------------------------------------------------------------
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
if !exists(":YCM")
    command YCM call YCM()
endif
" ------------------------------
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
" ------------------------------
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsListSnippets = "<c-tab>"
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
    if has('win32') || has('win64')
        autocmd GUIEnter * simalt ~x
    endif
else
    set wrap
endif

"Font
"-------------------
if has('win32') || has('win64')
    "set guifont=Inconsolata:h12
    set guifont=DejaVu_Sans_Mono:h10:cANSI
elseif system('uname')=~'Darwin'
    "set guifont=DejaVu\ Sans\ Mono\ 10
	set guifont=Consolas:h18
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


" Ctags
"-------------------
if has("win32") || has("win64")
    let g:Tlist_Ctags_Cmd=$VIM . '/tools/ctags58/ctags.exe'
elseif system('uname')=~'Darwin'
    let g:Tlist_Ctags_Cmd='/usr/local/bin/ctags'   " brew install ctags
else
    let g:Tlist_Ctags_Cmd='/usr/bin/ctags'  
endif

let $CTAGS=g:Tlist_Ctags_Cmd
set tags=./tags;  "This will look in the current directory for tags, and work up the tree towards root until one is found.
let tlist_objc_settings    = 'objc;i:interface;c:class;m:method;p:property'
let g:tagbar_ctags_bin=g:Tlist_Ctags_Cmd

" add a definition for Objective-C to tagbar
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'objc',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

" ~/.vim/shortcut
let s:SHORTCUT_FILE = s:VIMRC_PATH . s:PATH_DIVISOR . "shortcut"
if filereadable(s:SHORTCUT_FILE)
    exec "source " . s:SHORTCUT_FILE
endif

" ~/.vim/function
let s:FUNCTION_FILE = s:VIMRC_PATH . s:PATH_DIVISOR . "function"
if filereadable(s:FUNCTION_FILE)
    exec "source " . s:FUNCTION_FILE
endif

"=========================
" auto command
"
au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif 

