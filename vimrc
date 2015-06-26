"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

if has('win32')
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
endif

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
Bundle 'tomasr/molokai'
Bundle 'fatih/vim-go'
Bundle 'Shougo/neocomplete.vim'
Bundle 'OmniCppComplete'
Bundle 'bling/vim-airline'
Bundle 'bufexplorer.zip'
Bundle 'kien/ctrlp.vim'
Bundle 'rkulla/pydiction'
"Bundle 'pyflakes/pyflakes'
"Bundle 'klen/python-mode'
"Bundle 'SirVer/ultisnips'
"Bundle 'honza/vim-snippets'
"Bundle 'vim-scripts/UltiSnips'
"Bundle 'pangloss/vim-javascript'
"Bundle 'wookiehangover/jshint.vim'
"Bundle 'mattn/emmet-vim'
"Bundle 'altercation/vim-colors-solarized'

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set number      "show line numbers

"display tabs and trailing spaces
"set list
set listchars=tab:>-,trail:-,nbsp:.,eol:$

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

"default indent settings
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set copyindent " copy the previous indentation on autoindenting

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden
set nobackup " no *~ backup files
set background=dark

"colorscheme for molokai
colorscheme molokai

" hilight function name
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
highlight cfunctions ctermfg=81
highlight Type ctermfg=120 cterm=none
highlight Structure ctermfg=120 cterm=none
highlight Macro ctermfg=161 cterm=bold
highlight PreCondit ctermfg=161 cterm=bold
highlight CursorLine cterm=underline
highlight CursorLine cterm=bold
set cursorline


"------------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb18030,big5,latin1

autocmd FileType ruby,javascript,css,html
      \	set expandtab | set softtabstop=2 | set shiftwidth=2
autocmd FileType c,cpp,python,go,sh set expandtab

"statusline setup
set laststatus=2

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40

"explorer mappings
nnoremap <f1> :BufExplorer<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TagbarToggle<cr>
nnoremap <silent> <f5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<cr>

" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

"source project specific config files
runtime! projects/**/*.vim

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

if has("cscope")
    set csprg=cscope
    set csto=0
    set cst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" map CTRL-E to end-of-line (insert mode)
imap <C-e> <esc>$i<right>
" " map CTRL-A to beginning-of-line (insert mode)
imap <C-a> <esc>0i
map <S-u> <C-u>
map <S-d> <C-d>
map <S-B> <C-B>
map <S-F> <C-F>

" Disable completion previews with function prototypes, etc.
set completeopt=menu

"VimOrganizer
autocmd! BufRead,BufWrite,BufWritePost,BufNewFile *.org
autocmd  BufEnter *.org call org#SetOrgFileType() | set wrap
let g:SuperTabDefaultCompletionType = "context"

"-----------------------------------------------------------------------------
"Neocomplete configure
"-----------------------------------------------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
     \ 'default' : '',
         \ 'vimshell' : $HOME.'/.vimshell_hist',
             \ 'scheme' : $HOME.'/.gosh_completions'
                     \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" " <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
	"return neocomplete#close_popup() . "\<CR>"
	  "" For no inserting <CR> key.
	  ""return pumvisible() ? neocomplete#close_popup() : "\<CR>"
"endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"-----------------------------------------------------------------------------
"UltiSnips configure
"-----------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use  https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"
"

"-----------------------------------------------------------------------------
"Pydiction configure
"-----------------------------------------------------------------------------
let g:pydiction_location = '/root/.vim/bundle/pydiction/complete-dict'

"-----------------------------------------------------------------------------
"delimitMate configure
"-----------------------------------------------------------------------------
let delimitMate_expand_cr = 1
