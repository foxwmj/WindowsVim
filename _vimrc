"
" _vimrc file of GVim for Windows Platform.
" Author: mingin.wu@gmail.com
"
" Version: v1.0.3
" Data: 2013-1-15
" Modified: 1. add log color 2.Add shortcut to modify vimrc and source vimrc
" 3. Use FufCoverageFile instead of FufFIle
"
" Version: v1.0.2
" Data: 2011-10-19
" Modified:  1.Add autocmd to make ctags when cpp/h/c file is saved.
"
" Version: v1.0.1
" Data: 2011-10-18
" Modified:  1.Add cscope support 2.disable AutoComplPop/minibufexplorer
"
" Version: v1.0.0
" Date: 2011-07-26
" Modified: original version
"

"==============================================
" Constant
"==============================================


let s:PATH_DIVISOR = "\\"
let s:CODE_DIR= $HOME . s:PATH_DIVISOR . "code_projs"
let s:PY_PROJECTS_PATH = s:CODE_DIR . s:PATH_DIVISOR . "PY_projs"
let s:TC_PROJECTS_PATH = s:CODE_DIR . s:PATH_DIVISOR . "tc"
let s:WMJ_PY_PATH = s:PY_PROJECTS_PATH . s:PATH_DIVISOR . "wmj.py"



"==============================================
" Winodws Default Setting
"==============================================
if has('win32') || has('win64')
    set nocompatible
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin

    if !exists("is_mydiff_inits")
        let is_mydiff_inits= 1
        set diffexpr=MyDiff()
        function MyDiff()
            let opt = '-a --binary '
            if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
            if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
            let arg1 = v:fname_in
            if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
            let arg2 = v:fname_new
            if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
            let arg3 = v:fname_out
            if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
            let eq = ''
            if $VIMRUNTIME =~ ' '
                if &sh =~ '\<cmd'
                    let cmd = '""' . $VIMRUNTIME . '\diff"'
                    let eq = '"'
                else
                    let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
                endif
            else
                let cmd = $VIMRUNTIME . '\diff'
            endif
            silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
        endfunction
    endif
endif


"==============================================
" vim-plug
"==============================================
set nocompatible               " be iMproved
filetype off                   " required!

call plug#begin("d:\\00_dev_env\\20_Vim8\\vim.plug.runtime")

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
language messages zh_CN.utf-8

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

" Ctags
"-------------------
let g:Tlist_Ctags_Cmd=$VIM . '/tools/ctags58/ctags.exe'
set tags=./tags;  "This will look in the current directory for tags, and work up the tree towards root until one is found.
let $CTAGS=g:Tlist_Ctags_Cmd
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



function! GenerateTagsFile(currentFile)
    if (filereadable("tags"))
        "exec ":silent !" . $CTAGS . ' -R --c++-kinds=+p --fields=+iaS --extra=+q *.py'
        exec ":silent !" . $CTAGS . ' -R --c++-kinds=+p --fields=+iaS --extra=+q *'
    endif
endfunction

function! BuildTags(currentPath) ", fileTypes)
    let l:name = input("Build Tags at [". a:currentPath ."] OK[Y]?:")
    if l:name == "Y" || l:name == "y"
        "echo a:currentPath
        exec ":!" . $CTAGS . ' -R --c++-kinds=+p --fields=+iaS --extra=+q .'
        "exec ":!" . $CTAGS . ' -h [".java"] .' 
    endif
endfunction


"autocmd! bufwritepost *.cpp,*.c,*.h     :call GenerateTagsFile(expand("%"))
"autocmd! bufwritepost *.py              :call GenerateTagsFile(expand("%"))

nnoremap <F12> :e ++enc=utf-8<CR>
map <silent> <C-F12> <Esc>:call BuildTags(expand("%"))<CR>
map <silent> <C-F11> <Esc>:execute "silent !" . 'cd ' . getcwd() . '&' . $Cscope_Cmd . ' -R -b '<CR>
map <C-F10> <Esc>:execute 'cs add cscope.out'<CR>

" Folding
"-------------------
set foldmethod=syntax
set foldlevel=100  " Expand all foding when start vim


" FuzzyFinder
"-------------------
map <silent> <C-k>b :FufBuffer<CR>
map <silent> <C-k>f :FufCoverageFile<CR>
map <silent> <C-k>m :FufTag<CR>
map <silent> <c-k>n :FufTagWithCursorWord<CR>
map <silent> <C-k>. :FufBufferTag<CR>
map <silent> <C-k>p :call Py()<CR>
map <silent> <C-k>t :call SearchTC()<CR>


" Cscope
"-------------------
let $Cscope_Cmd=$VIM . '/tools/cscope-15.7a-win32rev18-static/cscope.exe'
let &csprg=$VIM . '/tools/cscope-15.7a-win32rev18-static/cscope.exe'
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        :cs add cscope.out  
        " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        :cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-\>\s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>\g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>\c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>\t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>\e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>\f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>\i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-\>\d :scs find d <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-\><C-\>\s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>\g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>\c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>\e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\><C-\>\f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\><C-\>\i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-\><C-\>\d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
endif


" Quit Edit
"-------------------
inoremap <F9> <C-R>=strftime("%c")<CR>



" Layout and mapping
"-------------------
map <F2> :NERDTreeToggle<CR>
"map <F3> :TlistToggle<CR>
nmap <F3> :TagbarToggle<CR>
map <F4> :A<CR>
map <F5> :AV<CR>
map <F6> :cw<CR>
map <F7> :cp<CR>
map <F8> :cn<CR>



" Color
"--------------------
autocmd! BufReadPre *.log   :call LogColor()
"autocmd! BufReadPre *.log   :set wrap

function! LogColor()
    hi Search guibg=LightBlue

    syn match	logText	        /.*$/
"    syn match	logDate	        /^\d*-\d* \d*:\d*:\d*\.\d*[:]*/ nextgroup=logLevelError,logLevelWarn,logLevelVerbose,logLevelDebug skipwhite
"    syn match	logLevelError   /E\/[^:]*:/ nextgroup=logText skipwhite
"    syn match	logLevelWarn    /W\/[^:]*:/ nextgroup=logText skipwhite
"    syn match	logLevelDebug   /D\/[^:]*:/ nextgroup=logText skipwhite
"    syn match	logLevelVerbose /V\/[^:]*:/ nextgroup=logText skipwhite
"    syn match	logLevelError   /[EWDV]\/[^:]*: \[E\]/ nextgroup=logText skipwhite
"    syn match	logLevelWarn    /[EWDV]\/[^:]*: \[W\]/ nextgroup=logText skipwhite
"    syn match	logLevelDebug   /[EWDV]\/[^:]*: \[D\]/ nextgroup=logText skipwhite
"    syn match	logLevelVerbose /[EWDV]\/[^:]*: \[V\]/ nextgroup=logText skipwhite

"    syn match	logDate	        /^\[\d*-\d*-\d* \d*:\d*:\d*\]/ nextgroup=logLevelError,logLevelWarn,logLevelVerbose,logLevelDebug skipwhite
"    syn match	logLevelError   /\[error.*\]/ nextgroup=logText skipwhite
"    syn match	logLevelWarn    /\[warning.*\]/ nextgroup=logText skipwhite
"    syn match	logLevelDebug   /\[debug.*\]/ nextgroup=logText skipwhite
"    syn match	logLevelVerbose /\[notice.*\]/ nextgroup=logText skipwhite
    
    "Android
    syn match	logDate	        /^\d*-\d*-\d* \d*:\d*:\d*|\(\d\+|\)\{0,1}/ nextgroup=logLevelError,logLevelWarn,logLevelVerbose,logLevelDebug skipwhite
    syn match	logLevelError   /\%([^|]\+|\)\{1}E|[^|]\+|/ nextgroup=logText skipwhite
    syn match	logLevelWarn    /\%([^|]\+|\)\{1}W|[^|]\+|/ nextgroup=logText skipwhite
    syn match	logLevelDebug   /\%([^|]\+|\)\{1}D|[^|]\+|/ nextgroup=logText skipwhite
    syn match	logLevelVerbose /\%([^|]\+|\)\{1}I|[^|]\+|/ nextgroup=logText skipwhite

    "iOS
    syn match	logDate	        /^\d*-\d*-\d* \d*:\d*:\d*\.\d*/ nextgroup=logLevelError,logLevelWarn,logLevelVerbose,logLevelDebug skipwhite
    syn match	logLevelError   /Event|\([^|]*|\)\{5}/ nextgroup=logText skipwhite
    syn match	logLevelWarn    /Warn|\([^|]*|\)\{5}/ nextgroup=logText skipwhite
    syn match	logLevelDebug   /Debug|\([^|]*|\)\{5}/ nextgroup=logText skipwhite
    syn match	logLevelWarn    /Info|\([^|]*|\)\{5}/ nextgroup=logText skipwhite


    hi link logDate     SignColumn
    hi link logLevelVerbose Special
    hi link logLevelDebug Debug
    hi link logLevelError Statement
    hi link logLevelWarn Constant
    hi link logText 	String

    hi link wmjWantToRead1 MatchParen
    hi link wmjWantToRead2 MatchParen
endfunction

" Short Cut
"--------------------
map <C-F2> <Esc>:e $VIM/_vimrc<CR>
"map <S-F2> <Esc>:source $VIM/_vimrc<CR>
"map <C-F3> <Esc>:call Sync_vim_and_proj()<CR>
map <C-F3> <Esc>:call Commit_vim_and_proj()<CR>

function! Sync_vim_and_proj()
    exec ":!python " . s:WMJ_PY_PATH . " sync " . $VIM . "\\"
    exec ":!python " . s:WMJ_PY_PATH . " sync " . s:PY_PROJECTS_PATH 
endfunction

function! Commit_vim_and_proj()
    exec ":!python " . s:WMJ_PY_PATH . " ci " . $VIM . "\\"
    exec ":!python " . s:WMJ_PY_PATH . " ci " . s:PY_PROJECTS_PATH 
endfunction

if !exists(":UP")
    command UP call Sync_vim_and_proj()
endif

if !exists(":CI")
    command CI call Commit_vim_and_proj()
endif

map <C-F5> <Esc>:e!<CR>
map <C-F6> <Esc>:v/\(<C-R>/\)/d
map <C-F7> <Esc>:g/\(<C-R>/\)/d
map <C-F8> <Esc>:v/\(<c-r>=expand("<cword>")<cr>\)/d

map <S-F6> <Esc>:vimgrep /\(<c-r>/\)/ <c-r>=expand("%")<cr>
map <S-F8> <Esc>:vimgrep /\(<c-r>=expand("<cword>")<cr>\)/ <c-r>=expand("%")<cr>


" Searching
"-------------------

"Search but not jump to next occurd
map * *``
map # #``

hi link hl1  MatchParen
hi link hl2  PMenuThumb
hi link hl3  ColorColumn
hi link hl4  Title
hi link hl5  Directory	
hi link hl6  ErrorMsg	
hi link hl7  Question
hi link hl8  SpellBad
hi link hl9  SpellCap

set synmaxcol=350

let g:highlighting = 0
function! Highlighting()
    if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
        let g:highlighting = 0
        return ":silent nohlsearch\<CR>"
    endif
    let @/ = '\<'.expand('<cword>').'\>'
    let g:highlighting = 1
    return ":silent set hlsearch\<CR>"
endfunction
map <silent> <expr> <2-LeftMouse> Highlighting()


" Return last visually selected text or '\<cword\>'.
" what = 1 (selection), or 2 (cword), or 0 (guess if 1 or 2 is wanted).
function! Pattern(what)
    if a:what == 2 || (a:what == 0 && histget(':', -1) =~# '^H')
        let result = expand("<cword>")
        if !empty(result)
            let result = '\<'.result.'\>'
        endif
    else
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        normal! gvy
        let result = substitute(escape(@@, '\.*$^~['), '\_s\+', '\\_s\\+', 'g')
        normal! gV
        call setreg('"', old_reg, old_regtype)
    endif
    return result
endfunction

function! DoHighlightRegex(hlnum)
    let hltotal = a:hlnum
    let pattern = @/
    if !empty(pattern)
        let pattern = '\%('.pattern.'\)'
    endif
    let id = hltotal + 100

    for m in getmatches()
        if m.id == id
            let pp =m.pattern
            if pattern != pp
                let newPP = pp.'\|'.pattern
            endif
        endif
    endfor
    silent! call matchdelete(id)
    if exists("newPP") && !empty(newPP)
        let pattern = newPP
    endif
    if !empty(pattern)
        try
            call matchadd('hl'.hltotal, pattern, -1, id)
        catch /E28:/
            echo 'Highlight hl'.hltotal.' is not defined'
        endtry
    endif
endfunction

function! DoHighlight(hlnum, patType)
    let hltotal = a:hlnum
    if type(a:patType) == type(0)
        let pattern = Pattern(a:patType)
    else
        let pattern = a:patType
    endif
    let id = hltotal + 100

    for m in getmatches()
        if m.id == id
            let pp =m.pattern
            if pattern != pp
                let newPP = pp.'\|'.pattern
            endif
        endif
    endfor
    silent! call matchdelete(id)
    if exists("newPP") && !empty(newPP)
        let pattern = newPP
    endif
    if !empty(pattern)
        try
            call matchadd('hl'.hltotal, pattern, -1, id)
        catch /E28:/
            echo 'Highlight hl'.hltotal.' is not defined'
        endtry
    endif
endfunction


" Remove all matches for pattern.
function! UndoHighlight(patType)
    if type(a:patType) == type(0)
        let pattern = Pattern(a:patType)
    else
        let pattern = a:patType
    endif

    for m in getmatches()
        let lid = m.id
        let ll = split(m.pattern, '\\|')

        let newlist = []
        for item in ll
            if item != pattern
                call add(newlist, item)
            endif
        endfor

        if newlist != ll
            call matchdelete(lid) 

            let newPattern = join(newlist,'\|')
            if !empty(newPattern)
                try
                    call matchadd('hl'.(lid-100), newPattern, -1, lid)
                catch /E28:/
                    echo 'Highlight hl'.(lid-100).' is not defined'
                endtry
            endif
        endif
    endfor
endfunction


function! SearchCurrentGroupWithPattern(patType, backward)
    if type(a:patType) == type(0)
        let pattern = Pattern(a:patType)
    else
        let pattern = a:patType
    endif

    let lid = -1
    for m in getmatches()
        let itemList = split(m.pattern, '\\|')
        let found = 0
        for item in itemList
            if item ==# pattern
                let found = 1
                break
            endif
        endfor

        if found == 1
            let lid = m.id
            break
        endif
    endfor

    if lid != -1
        call SearchWithId(lid, a:backward)
    endif
endfunction


function! SearchWithId(id, backward)
    for m in getmatches()
        if m.id == a:id
            call search('\C'.m.pattern, a:backward ? 'b' : '')
            break
        endif
    endfor
endfunction

function! SearchAll(backward)
    let patternList = []
    for m in getmatches()
        call add(patternList, m.pattern)
    endfor
    let allPattern = join(patternList, '\|')
    call search('\C'.allPattern, a:backward ? 'b' : '')
endfunction

vnoremap <silent> <Leader>11 :<C-U>call DoHighlightRegex(1)<CR>
vnoremap <silent> <Leader>22 :<C-U>call DoHighlightRegex(2)<CR>
vnoremap <silent> <Leader>33 :<C-U>call DoHighlightRegex(3)<CR>
vnoremap <silent> <Leader>44 :<C-U>call DoHighlightRegex(4)<CR>
vnoremap <silent> <Leader>55 :<C-U>call DoHighlightRegex(5)<CR>
vnoremap <silent> <Leader>66 :<C-U>call DoHighlightRegex(6)<CR>
vnoremap <silent> <Leader>77 :<C-U>call DoHighlightRegex(7)<CR>
vnoremap <silent> <Leader>88 :<C-U>call DoHighlightRegex(8)<CR>
vnoremap <silent> <Leader>99 :<C-U>call DoHighlightRegex(9)<CR>

nnoremap <silent> <Leader>11 :<C-U>call DoHighlightRegex(1)<CR>
nnoremap <silent> <Leader>22 :<C-U>call DoHighlightRegex(2)<CR>
nnoremap <silent> <Leader>33 :<C-U>call DoHighlightRegex(3)<CR>
nnoremap <silent> <Leader>44 :<C-U>call DoHighlightRegex(4)<CR>
nnoremap <silent> <Leader>55 :<C-U>call DoHighlightRegex(5)<CR>
nnoremap <silent> <Leader>66 :<C-U>call DoHighlightRegex(6)<CR>
nnoremap <silent> <Leader>77 :<C-U>call DoHighlightRegex(7)<CR>
nnoremap <silent> <Leader>88 :<C-U>call DoHighlightRegex(8)<CR>
nnoremap <silent> <Leader>99 :<C-U>call DoHighlightRegex(9)<CR>

vnoremap <silent> <Leader>` :<C-U>call UndoHighlight(1)<CR>
vnoremap <silent> <Leader>1 :<C-U>call DoHighlight(1, 1)<CR>
vnoremap <silent> <Leader>2 :<C-U>call DoHighlight(2, 1)<CR>
vnoremap <silent> <Leader>3 :<C-U>call DoHighlight(3, 1)<CR>
vnoremap <silent> <Leader>4 :<C-U>call DoHighlight(4, 1)<CR>
vnoremap <silent> <Leader>5 :<C-U>call DoHighlight(5, 1)<CR>
vnoremap <silent> <Leader>6 :<C-U>call DoHighlight(6, 1)<CR>
vnoremap <silent> <Leader>7 :<C-U>call DoHighlight(7, 1)<CR>
vnoremap <silent> <Leader>8 :<C-U>call DoHighlight(8, 1)<CR>
vnoremap <silent> <Leader>9 :<C-U>call DoHighlight(9, 1)<CR>

nnoremap <silent> <Leader>` :<C-U>call UndoHighlight(2)<CR>
nnoremap <silent> <Leader>1 :<C-U>call DoHighlight(1, 2)<CR>
nnoremap <silent> <Leader>2 :<C-U>call DoHighlight(2, 2)<CR>
nnoremap <silent> <Leader>3 :<C-U>call DoHighlight(3, 2)<CR>
nnoremap <silent> <Leader>4 :<C-U>call DoHighlight(4, 2)<CR>
nnoremap <silent> <Leader>5 :<C-U>call DoHighlight(5, 2)<CR>
nnoremap <silent> <Leader>6 :<C-U>call DoHighlight(6, 2)<CR>
nnoremap <silent> <Leader>7 :<C-U>call DoHighlight(7, 2)<CR>
nnoremap <silent> <Leader>8 :<C-U>call DoHighlight(8, 2)<CR>
nnoremap <silent> <Leader>9 :<C-U>call DoHighlight(9, 2)<CR>

nnoremap <silent> <Leader>0 :call clearmatches()<CR>
nnoremap <silent> <Leader>n :call SearchAll(0)<CR>
nnoremap <silent> <Leader>N :call SearchAll(1)<CR>

vnoremap <silent> <Leader>m :call SearchCurrentGroupWithPattern(1,0)<CR>
vnoremap <silent> <Leader>M :call SearchCurrentGroupWithPattern(1,1)<CR>

nnoremap <silent> <Leader>m :call SearchCurrentGroupWithPattern(2,0)<CR>
nnoremap <silent> <Leader>M :call SearchCurrentGroupWithPattern(2,1)<CR>

function! MingjinFilter()
    :s/\(\t[0-9,\.]\+\)[^\t]\+/\1/g 
endfunction




" Project MobileQQ Log
"-------------------

function! IosHighlight(version)
    let push='\%([a-zA-Z\.]*[pP]ush[a-zA-Z\.]*\)'

    let @/ = "^.*conn begin.*"
    call DoHighlightRegex(8)

    let @/ = "^.*conn end. Connect ok"
    call DoHighlightRegex(1)

    let @/ = "^.*disConnect.*"
    call DoHighlightRegex(2)

    let @/ = '\%(@PK|send, pcmd:\)\@<=[^,]*'
    call DoHighlightRegex(1)

    let @/ = '\%(@PK|recv, pcmd:\)\@<=[^,]*'
    call DoHighlightRegex(2)

    let @/ = '\%(@PK|send, pcmd:\)\@<='.push
    call DoHighlightRegex(3)

    let @/ = '\%(@PK|recv, pcmd:\)\@<='.push
    call DoHighlightRegex(3)


    let @/ = '\%(@PK|Add pack.*cmd : \)\@<=[^,]*'
    call DoHighlightRegex(1)

    let @/ = '\%(@PK|recv combine pack. cmd : \)\@<=[^,]*'
    call DoHighlightRegex(2)


    let @/ = '\%(.*\[read ping begin\].*\)' 
    call DoHighlightRegex(5)

    let @/ = '\%(.*\[read ping end\].*\)' 
    call DoHighlightRegex(5)

    let @/ = '\%(QQAddressBookAppDelegate.mm.*进入后台\)'
    call DoHighlightRegex(7)

    let @/ = '\%(QQAddressBookAppDelegate.mm.*后台时间\)'
    call DoHighlightRegex(7)

    let @/ = '\%(QQAddressBookAppDelegate.mm.*手机到后台\)'
    call DoHighlightRegex(6)

    let @/ = '\%(QQAddressBookAppDelegate.mm.*手机到前台\)'
    call DoHighlightRegex(5)

    if a:version == "detail"
        let @/ = '\%(ServerListInfoTable\)'
        :call DoHighlightRegex(5)

        let @/ = '\%(ServerListData\)'
        :call DoHighlightRegex(5)
    endif

    let @/ = ""

endfunction

function! IosFilter(version)
    let @/ = '\%(@PK|Add packet to combine pack,cmd : \)\@<=[^,]*'
    call DoHighlightRegex(1)

    let @/ = '\%(@PK|recv combine pack. cmd : \)\@<=[^,]*'
    call DoHighlightRegex(2)

    let closeSocket = '\%(disConnect\)'
    let openSocket = '\%(conn begin\)'
    let SocketOpenResult = '\%(conn end\)'
    let netSend = '\%(send, pcmd:\)'
    let netRecv = '\%(recv, pcmd:\)'
    "let netSend2 = '\%(Add packet to combine pack,cmd :\)'
    let netSend2 = '\%(@PK|Add pack.*cmd : \)'
    let netRecv2 = '\%(recv combine pack. cmd :\)'
    let fileTrans = '\%(UniFileTransEngine\)\|\%(Upload\)'
    let readPing = '\%(read ping\)'
    let BDH = '\%(BDHConfigMgr\)'
    let switchForeAndBack = 'QQAddressBookAppDelegate'

    "let all = closeSocket.'\|'.openSocket.'\|'.netSend.'\|'.netRecv.'\|'.'\%(ServerListModule\)'.'\|'.'\%(ServerListInfoTable\)'.'\|'.'\%(ServerListData\)'.'\|'.'\%(TcpConnect\)'
    "let all = closeSocket.'\|'.openSocket.'\|'.netSend.'\|'.netRecv . '\|' . fileTrans . '\|' . BDH  . '\|' . SocketOpenResult
    let all = closeSocket.'\|'.openSocket.'\|'.netSend.'\|'.netRecv .'\|'.netSend2.'\|'.netRecv2 . '\|' . SocketOpenResult . '\|' . readPing . '\|' . switchForeAndBack

    if a:version == "detail"
        let all = all.'\|'.'\%(ServerListInfoTable\)'

        let all = all.'\|'.'\%(ServerListData\)'
    endif

    exe ":v/".all."/d"
endfunction


function! Ios()
    call IosFilter("simple")
    call IosHighlight("simple")
endfunction

function! Ios2()
    call IosFilter("detail")
    call IosHighlight("detail")
endfunction




function! SsoFilter()
    let closeSocket = '\%(cli2sso\)'
    let openSocket = '\%(sso2cli\)'

    let all = closeSocket.'\|'.openSocket

    exe ":v/".all."/d"
endfunction

function! SsoLog()

    let netSend = '\%(cli2sso.*cmd: \?\)\@<=[^|]*'
    let netRecv = '\%(sso2cli.*cmd: \?\)\@<=[^|]*'
    let netPushRecv = '\%(Nsso2cli.*cmd:\)\@<=[^|]*'

    let @/ = netSend
    call DoHighlightRegex(1)

    let @/ = netRecv
    call DoHighlightRegex(2)


    let @/ = netPushRecv
    call DoHighlightRegex(3)

    let @/ = ""
endfunction

function! MsfEventLog(version)
    let push='\%([a-zA-Z\.]*[pP]ush[a-zA-Z\.]*\)'

    let closeSocket = '^.*close Socket.*'
    let openSocket = '^.*open conn at.*'
    let netSend = '\%(netSend.*cmd: \?\)\@<=[^ ]*'
    let netRecv = '\%(netRecv.*cmd: \?\)\@<=[^ ]*'
    let netPushSend = '\%(netSend.*cmd: \?\)\@<='.push
    let netPushRecv = '\%(netRecv.*cmd: \?\)\@<='.push

    let netSendTimeout = '\%(netRecv.*cmd: \?\)\@<=[^ ]*\%(.*timeout\)\@='
    let addMergeSSO = '\%(NetConnTag|add [-0-9]\+ scmd: \?\)\@<=[^ ]*'

    let @/ = closeSocket
    call DoHighlightRegex(2)

    let @/ = openSocket
    call DoHighlightRegex(1)

    let @/ = netSend
    call DoHighlightRegex(1)

    let @/ = addMergeSSO
    call DoHighlightRegex(4)

    let @/ = netRecv
    call DoHighlightRegex(2)

    let @/ = netSendTimeout
    call DoHighlightRegex(7)

    let @/ = netPushRecv
    call DoHighlightRegex(3)

    let @/ = netPushSend
    call DoHighlightRegex(3)

    let @/ = "deep sleep"
    call DoHighlightRegex(3)

    let @/ = "try open Conn.*"
    call DoHighlightRegex(8)

    let @/ = "netchange.*"
    call DoHighlightRegex(9)

    let @/ = "found repeat net event"
    call DoHighlightRegex(9)

    if a:version == "detail"
        let @/ = '\%(AppProcessManager|\)\@<=add process.*'
        call DoHighlightRegex(6)

        let @/ = '\%(ReqHandler.recv.*msName:\)\@<=[^ ]*'
        call DoHighlightRegex(8)

        let @/ = '\%(AppProcessManager.send.*msName:\)\@<=[^ ]*'
        call DoHighlightRegex(9)

        let @/ = '\%(serviceCmd:\)\@<=[^ ]*'
        call DoHighlightRegex(7)

        let @/ = '\%(sCmd:\)\@<=[^ ]*'
        call DoHighlightRegex(7)

        let @/ = '\%(RespHandler|.*add push to.*msName:\)\@<=[^ ]*'
        call DoHighlightRegex(6)
    endif

    let @/ = ""
endfunction


function! MsfEventFilter()
    let closeSocket = '\%(close Socket\)'
    let openSocket = '\%(open conn at\)'
    let netSend = '\%(netSend.*cmd:\)'
    let netRecv = '\%(netRecv.*cmd:\)'
    let mergeSSO = 'NetConnTag|add [-0-9]\+ scmd:'

    let addProcess = "AppProcessManager|add process"

    let all = closeSocket.'\|'.openSocket.'\|'.netSend.'\|'.netRecv.'\|'. mergeSSO. '\|' . "NetConnInfoCenter".'\|'.'SsoListManager'.'\|'.'deep sleep'.'\|'.'try open Conn'.'\|'.addProcess

    exe ":v/".all."/d"
endfunction


function! Msf()
    call MsfEventFilter()
    call MsfEventLog("simple")
endfunction

function! Msf2()
    call MsfEventFilter()
    call MsfEventLog("detail")
endfunction

function! Mqq()
    call MqqEventLog("simple")
endfunction

function! Mqq2()
    call MqqEventLog("detail")
endfunction

function! MqqEventLog(version)
    let push='\%([a-zA-Z\.]*[pP]ush[a-zA-Z\.]*\)'

    let msfSend = '\%(\[MSF Send\]\)\@<=[^, ]*'
    let msfRecv = '\%(\[MSF Receive\]\)\@<=[^, ]*'

    let msfSendPush = '\%(\[MSF Push\]\)\@<=[^, ]*'
    let msfRecvPush = '\%(\[MSF Receive\]\)\@<='.push

    let msfEnd      = '\%(\[MSF End\]\[[^\]]*\]\)\@<=[^, ]*'


    let @/ = msfSend
    call DoHighlightRegex(1)

    let @/ = msfRecv
    call DoHighlightRegex(2)

    let @/ = msfSendPush
    call DoHighlightRegex(3)

    let @/ = msfRecvPush
    call DoHighlightRegex(3)

    let @/ = msfEnd
    call DoHighlightRegex(4)

    let @/ = '.*\[MSF Push\]cmd_connClosed.*'
    call DoHighlightRegex(1)

    let @/ = '.*\[MSF Push\]cmd_connOpened.*'
    call DoHighlightRegex(1)

    if a:version == "detail"
        let processBegin = '^.*BaseApplication onCreate'
        let @/ = processBegin
        call DoHighlightRegex(1)

        let @/ = 'C2CMsgEquals Error'
        call DoHighlightRegex(5)


        let @/ = '|qqBaseActivity|\[\d*\].*'
        call DoHighlightRegex(8)

        let @/ = 'doInit begin with Application.*'
        call DoHighlightRegex(1)

        let @/ = 'Application.*exit'
        call DoHighlightRegex(2)

    endif

    let @/ = ""

endfunction

function! Filte_Match()

    let all = "" 
    for m in getmatches()
        let pp =m.pattern
        if all == ""
            let all = pp
        else
            let all = all.'\|'.pp
        endif
    endfor
    echo all
    exe ":v/".all."/d"
endfunction






"
"==========================
" PY MODE
"=========================
function! NewPyProject()
    let l:name = input("Enter PY project name:")
    call NewPy(l:name)
endfunction

function! NewPy(projectName)
    let projectName = a:projectName
    if projectName == ""
        let projectName = "tmp"
    endif
    echo projectName

    let rootFolder = s:PY_PROJECTS_PATH.s:PATH_DIVISOR.projectName
    if !isdirectory(rootFolder)
        call mkdir(rootFolder, 'p')
    endif

    let l:filename = rootFolder.s:PATH_DIVISOR."main.py"
    let $TEMP_STR = l:filename
    edit $TEMP_STR

    let $TEMP_STR = rootFolder
    lcd $TEMP_STR
endfunction

function! Py()
    echo s:PY_PROJECTS_PATH
    let l:searchPath = "" . s:PY_PROJECTS_PATH . s:PATH_DIVISOR . "**" . s:PATH_DIVISOR . "*.py"
    call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns', [l:searchPath]], ['g:fuf_coveragefile_prompt', '>Python File>'])
                \ | FufCoverageFile
endfunction

if !exists(":PY")
    command PY call Py()
endif

if !exists(":PYN")
    command PYN call NewPyProject()
endif

" CDC = Change to Directory of Current file
if !exists(":CDC")
    command CDC lcd %:p:h
endif



let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
"let g:syntastic_disabled_filetypes=['html']
let g:syntastic_python_checkers=['python']


"======================= omnifunc =========================
autocmd FileType python set omnifunc=pythoncomplete#Complete


"======================= Current Folder =========================
if !exists(":GF")
    command GF call GoCurrentFolder()
endif

function! GoCurrentFolder()
    let $TEMP_STR = expand("%:p:h")
    silent execute '!cmd /c start '.$TEMP_STR
endfunction 


"====================== code =============================
let s:CODE_DIR= $HOME . s:PATH_DIVISOR . "code_projs"
function! CloneCode()
    if !isdirectory(s:CODE_DIR)
        call mkdir(s:CODE_DIR, 'p')
        exec ":! svn checkout https://mingjin-sandbox.googlecode.com/svn/branches/projs" s:CODE_DIR
    else
        echo s:CODE_DIR . " already exsits!"
    endif
endfunction

function! SyncCodeFolder()
    exec ":! svn update " . s:CODE_DIR
endfunction


function! CommitCode()
    exec ":! svn add --force " . s:CODE_DIR . s:PATH_DIVISOR ."*"
    let l:choise = input("sure? [Y]:[N]")
    if l:choise == "Y"
        exec ":! svn commit -m vim_auto_commit " . s:CODE_DIR
    endif
endfunction

function! GoToCodeFolder()
    let $TEMP_STR = s:CODE_DIR
    silent execute '!cmd /c start '.$TEMP_STR
endfunction

function! SearchTC()
    echo s:TC_PROJECTS_PATH
    let l:searchPath = "" . s:TC_PROJECTS_PATH . s:PATH_DIVISOR . "**" . s:PATH_DIVISOR . "*"
    call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns', [l:searchPath]], ['g:fuf_coveragefile_prompt', '>TC File>'])
                \ | FufCoverageFile
endfunction



" Fast Acess 
"------------------
map  <C-k>r :!python % 
map <silent> <C-k><C-k> :call OpenWmjFile()<CR>

function! OpenWmjFile()
    exec "e " . s:WMJ_PY_PATH
    lcd %:p:h
endfunction



"======================= Quick Help =========================
if !exists(":QH")
    command QH call QuickHelp()
endif

function! QuickHelp()
    echo '%s printf     | :%s/\(.*\)/\=printf("%-10s", submatch(1)) . "good"/g'
    echo 'expand expr   | <C-R>=Split("\\t",3)<CR> '
endfunction 


function! Split(sep, num)
    let l:str = "\\(\\%([^" . a:sep . "]\\)\\+\\)" . a:sep
    let l:out = ""
    for index in range(a:num)
        let l:out .= l:str
    endfor
    let l:out .= "\\(.*\\)"

    return l:out
endfunction

function! GetLastSearch()
    return @/
endfunction

cmap <Leader>s <C-r>=Split("\\t",)
cmap <Leader>p \=printf("%-20s",submatch())
cmap <Leader>/ <C-r>=GetLastSearch()<CR>



"======================= Fold =========================

function! FoldTree2(lnum)
    let l:preline = len(split(getline(a:lnum-1),"|"))
    let l:cur = len(split(getline(a:lnum),"|"))
    let l:nextline = len(split(getline(a:lnum+1),"|"))
    return l:cur>=l:nextline ? 0 : l:cur
endfunction

function! FoldTree(lnum)
    return len(split(getline(a:lnum),"|"))
endfunction

autocmd! BufReadPre *.callstack setlocal fen fdm=expr fde=FoldTree(v:lnum)



function! Hash2Name()
    if !exists("l:Hash2Name_cmdPath")
        let l:Hash2Name_cmdPath = $VIM . "\\cmd.txt"
    endif
    
python << EOF
import vim
import re

DEBUG = False
CMD_FILE = "cmd.txt"
CMD_FILE = vim.eval("l:Hash2Name_cmdPath")

def java_hashcode(s):
    h = 0
    for c in s:
        h = (31 * h + ord(c)) & 0xFFFFFFFF
    return ((h + 0x80000000) & 0xFFFFFFFF) - 0x80000000

def constructMap():
    m = {}
    with open(CMD_FILE, "r") as f:
        for name in f:
            name = name[:-1]
            hashcode = java_hashcode(name)
            m.setdefault(hashcode, name)
    return m

def translate():
    h2n_map = constructMap()
    output = []

    #with open(MSF_FILE, "r") as f:

    f = vim.current.buffer[:]
    cnt = 0
    
    for line in f:
        line = line

        try:
            #send & rec
            res = re.search("(.*net((Send)|(Recv)).*)ssoSeq:([-0-9]+).*(uin[^ ]+).*cmd:([-0-9]+) ([-0-9]+)",line)
            if res:
                linebegin = res.group(1)
                ssoSeq = res.group(5)
                uin = res.group(6)
                cmdhash = res.group(7)
                len_c = res.group(8)

                cmd = h2n_map[int(cmdhash)]
                len_d = int(len_c) - int(ssoSeq)
                line = "%sssoSeq:%s %s cmd:%s len:%d" % (linebegin, ssoSeq, uin, cmd, len_d)

            #timeout
            res = re.search("(.*net((Send)|(Recv)).*)ssoSeq:([-0-9]+).*(uin[^ ]+).*cmd:([-0-9]+)(.*timeout)",line)
            if res:
                linebegin = res.group(1)
                ssoSeq = res.group(5)
                uin = res.group(6)
                cmdhash = res.group(7)
                lineend= res.group(8)

                cmd = h2n_map[int(cmdhash)]
                line = "%sssoSeq:%s %s cmd:%s %s" % (linebegin, ssoSeq, uin, cmd, lineend)

            #add
            #add 86876 scmd: 397544696 uin: *0742 len: 22 msg to -1108313138 delayWaitSendList
            res = re.search("(.*add [-0-9]+ scmd: )([-0-9]+)(.*)",line)
            if res:
                linebegin = res.group(1)
                cmdhash = res.group(2)
                lineend= res.group(3)

                cmd = h2n_map[int(cmdhash)]
                line = "%s%s%s" % (linebegin, cmd, lineend)

            if DEBUG:
                print line
        except:
            cnt = cnt + 1
            if cnt < 10:
                print "EXCEPTION!!!"
            elif cnt == 10:
                print "MORE THAN 10 EXCEPTIONS"
            pass

        output.append(line)
    del vim.current.buffer[:]
    vim.current.buffer.append("------> After translate <-------")
    vim.current.buffer.append(output)

def outputToVimBuffer():
    import vim

#constructMap()
translate()

EOF
endfunction


