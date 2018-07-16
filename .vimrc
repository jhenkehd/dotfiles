" Sample .vimrc file by Martin Brochhaus
" Presented at PyCon APAC 2012
"

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
set clipboard=unnamed


" Mouse and backspace
set mouse=a  " on OSX press ALT and click
set bs=2     " make backspace behave like normal again


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = "\<Space>"


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
noremap <Leader>z :update<CR>
vnoremap <Leader>z <C-C>:update<CR>
inoremap <Leader>z <C-O>:update<CR>


" Quick quit command
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=232 guibg=#080808
au InsertLeave * match ExtraWhitespace /\s\+$/

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~" Tabs sind schon okay
"exec "set listchars=tab:\u2002\u2002\u2002\u2002,trail:\uB7,nbsp:~"
"set list

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod
let g:airline_theme='powerlineish'

" Enable syntax highlighting
" You need to reload this file for the change to apply
syntax on
filetype on
filetype plugin on
"filetype indent off

filetype on
augroup PatchDiffHighlight
    autocmd!
    autocmd FileType  diff   syntax enable
augroup END

" Showing line numbers and length
set number	      " show line numbers
set textwidth=0	      " this turns off physical line wrapping (ie: automatic insertion of newlines)
set wrapmargin=0      " this turns off physical line wrapping (ie: automatic insertion of newlines)
set wrap	      " this enables 'visual' wrapping
set formatoptions-=t  " don't automatically wrap text when typing

" set colorcolumn=160
" highlight ColorColumn ctermbg=233
highlight ColorColumn ctermbg=232
call matchadd('ColorColumn', '\%81v', 100)

"====[ Open any file with a pre-existing swapfile in readonly mode "]=========

augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg ErrorMsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" auto reread files modified by external sources
set autoread


" Useful settings
set history=1000
set undolevels=1000


" Tab and indention related settings
set tabstop=4
set softtabstop=0
set shiftwidth=4
set shiftround
set smarttab
set expandtab
set copyindent
set preserveindent
set autoindent


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
""set nobackup
""set nowritebackup
""set noswapfile


" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
call pathogen#infect()


" ============================================================================
" Python IDE Setup
" ============================================================================


" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" python support
" --------------
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8

" template language support (SGML / XML too)
" ------------------------------------------
" and disable that stupid html rendering (like making stuff bold etc)
autocmd FileType xml,html,htmljinja,htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html,htmljinja,htmldjango imap <buffer> <c-e> <Plug>SparkupExecute
autocmd FileType html,htmljinja,htmldjango imap <buffer> <c-l> <Plug>SparkupNext
autocmd FileType html setlocal commentstring=<!--\ %s\ -->
autocmd FileType htmljinja setlocal commentstring={#\ %s\ #}
let html_no_rendering=1
let g:syntastic_html_checkers = []

" Verilog
" -------
autocmd FileType verilog setlocal shiftwidth=2 tabstop=8 softtabstop=2

" CSS
" ---
autocmd FileType css setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType css setlocal commentstring=/*\ %s\ */
autocmd FileType css noremap <buffer> <leader>r :call CSSBeautify()<cr>

" Less
" ----
autocmd FileType less setlocal shiftwidth=2 tabstop=8 softtabstop=2

" Java
" ----
autocmd FileType java setlocal shiftwidth=2 tabstop=8 softtabstop=2
autocmd FileType java setlocal commentstring=//\ %s

" rst
" ---
"autocmd BufNewFile,BufRead *.txt setlocal ft=rst
"autocmd FileType rst setlocal shiftwidth=4 tabstop=4 softtabstop=4
"\ formatoptions+=nqt textwidth=74

" C#
autocmd FileType cs setlocal tabstop=8 softtabstop=4 shiftwidth=4
autocmd FileType cs setlocal commentstring=//\ %s

" C/Obj-C/C++
autocmd FileType c setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType cpp setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType objc setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType c setlocal commentstring=/*\ %s\ */
autocmd FileType cpp,objc setlocal commentstring=//\ %s
let c_no_curly_error=1
let g:syntastic_cpp_include_dirs = ['include', '../include']
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_c_include_dirs = ['include', '../include']
let g:syntastic_c_compiler = 'clang'

" Octave/Matlab
autocmd FileType matlab setlocal tabstop=8 softtabstop=2 shiftwidth=2 

" vim
" ---
autocmd FileType vim setlocal shiftwidth=2 tabstop=8 softtabstop=2

" Javascript
" ----------
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType javascript noremap <buffer> <leader>r :call JsBeautify()<cr>
autocmd FileType javascript let b:javascript_fold = 0
let javascript_enable_domhtmlcss=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args='--config ~/.vim/extern-cfg/jshint.json'

" JSON
" ----
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Typescript
" ----------
let g:syntastic_typescript_checkers = []

" D
" -
autocmd FileType d setlocal shiftwidth=4 tabstop=8 softtabstop=4

" cmake support
" -------------
autocmd BufNewFile,BufRead CMakeLists.txt setlocal ft=cmake

" YAML support
" ------------
autocmd FileType yaml setlocal shiftwidth=2 tabstop=8 softtabstop=2
autocmd BufNewFile,BufRead *.sls setlocal ft=yaml

" Lua support
" -----------
autocmd FileType lua setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Add Python syntax for .wsgi files
autocmd BufNewFile,BufRead *.wsgi set filetype=python

