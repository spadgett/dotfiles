call plug#begin('~/.local/share/nvim/plugged')

" General
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'tommcdo/vim-lion'            " Line up text with `gl<motion><char>`
Plug 'tpope/vim-commentary'        " Comment and uncomment with `gcc` and `gc<motion>`
Plug 'tpope/vim-fugitive'          " Git commands
Plug 'tpope/vim-repeat'            " Repeat surround and other plugin commands
Plug 'tpope/vim-rhubarb'           " GitHub utilities like `:Gbrowse`
Plug 'tpope/vim-surround'          " `ys`, `cs`, `ds` for parens and quotes
Plug 'tpope/vim-unimpaired'        " Bracket mappings

" Filetypes
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'pearofducks/ansible-vim'

" Language Server Protocol, Completions, and Linting
"
" Install the JavaScript / TypeScript language server:
" yarn global add javascript-typescript-langserver
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'w0rp/ale'                    " Asynchronous linting

" Colors -- http://colorswat.ch/vim
Plug 'NLKNguyen/papercolor-theme'
Plug 'ajh17/Spacegray.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'fenetikm/falcon'
Plug 'mike-hearn/base16-vim-lightline'
Plug 'morhetz/gruvbox'
Plug 'neutaaaaan/iosvkem'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'

call plug#end()

" Colors
let ayucolor="dark"
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = 0
let g:gruvbox_sign_column = 'bg0'

set background=dark
set termguicolors
colorscheme hybrid

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typscript': ['eslint'],
\}

" fzf configuration
nnoremap <C-P> :Files<CR>
nnoremap gb :Buffers<CR>
nnoremap gh :History<CR>

" elzr/vim-json configuration
" Don't conceal double quotes in JSON
let g:vim_json_syntax_conceal = 0

let g:jsx_ext_required = 1

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'colorscheme': 'hybrid',
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

set cinoptions+=(0             " Line up function arguments
set fileformats=unix,dos,mac
set hidden                     " Hide buffers instead of closing buffers
set inccommand=nosplit         " Preview substitutions in Neovim
set mouse=a                    " Use the mouse in all modes
set nojoinspaces               " One space after sentences after join
set number                     " Show line numbers
set nohlsearch
set noruler                    " Don't show line and column of cursor in the status bar
set noshowmode                 " lightline already displays the mode
set tagcase=followscs
set scrolloff=1                " Keep at least one line above and below the cursor
set sidescrolloff=5            " Minimum columns to keep to the left and right of cursor
set spelllang=en_us
set splitbelow                 " Open horizontal splits below, instead of on top
set splitright                 " Open vertical splits to the right, instead of the left

" Tabs
set expandtab                  " Pressing tab inserts spaces
set shiftwidth=2               " Indent two spaces by default
set softtabstop=2              " Number of spaces that a `<Tab>` counts for

" Search
set ignorecase                 " Ignore case in search patterns. Use `/\C` for case-sensitive searches.
set smartcase                  " Use a case-sensitive search when typing uppercase characters.

" Backup and tmp
set backup                     " Make a backup before overwriting a file
set backupdir=~/.local/share/nvim/backup
set noswapfile                 " Don't make swapfiles. I save often and have never found them helpful.
set undofile                   " Save undo history across sessions

" Completion
if filereadable('/usr/share/dict/words')
  " Use `<C-X><C-K>` to complete words
  set dictionary+=/usr/share/dict/words
endif

" Path
set path-=/usr/include
set path+=src
set path+=app
set suffixesadd+=.js
set suffixesadd+=.jsx
set suffixesadd+=.ts
set suffixesadd+=.tsx

" Search
if executable('rg')
  set grepprg=rg\ --vimgrep
  nnoremap \* :grep -F '<cword>'<CR>
endif

" Correct typos like `:W` and `:Q`
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang E e<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" `%%` expands to the current file's directory.
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" Preserve flags when rerunning last subistitue command.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Break undo before clearing the line.
inoremap <C-U> <C-G>u<C-U>
inoremap <C-Space> <C-x><C-o>

" Jump to tag for CSS class under cursor.
nnoremap \<C-]> :tag .<C-R><C-F><CR>

augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.adoc set filetype=asciidoc
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
augroup END

augroup quickfix
  autocmd!
  " Automatically open the location/quickfix window after `:make`, `:grep`,
  " `:lvimgrep` and friends if there are valid locations/errors
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    cwindow
  autocmd VimEnter        *     cwindow
augroup END

" Don't fight commands like `:grep`
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_rootMarkers = ['package.json']
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.tsx': ['javascript-typescript-stdio'],
    \ }

augroup lsp
  autocmd!
  autocmd FileType javascript,typescript setlocal signcolumn=yes
  autocmd FileType javascript,typescript setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
  autocmd FileType javascript,typescript nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
  autocmd FileType javascript,typescript nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
  autocmd FileType javascript,typescript nnoremap <buffer> <silent> \r :call LanguageClient#textDocument_rename()<CR>
  autocmd FileType javascript,typescript nnoremap <buffer> \\ :call LanguageClient_contextMenu()<CR>
augroup END
