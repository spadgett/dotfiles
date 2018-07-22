call plug#begin('~/.local/share/nvim/plugged')

" General
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'tommcdo/vim-lion'            " Line up text with `gl<motion><char>`
Plug 'tpope/vim-commentary'        " Comment and uncomment with `gcc` and `gc<motion>`
Plug 'tpope/vim-fugitive'          " Git commands
Plug 'tpope/vim-repeat'            " Repeat surround and other plugin commands
Plug 'tpope/vim-rhubarb'           " GitHub utilities like `:Gbrowse`
Plug 'tpope/vim-surround'          " `ys`, `cs`, `ds` for parens and quotes
Plug 'tpope/vim-unimpaired'        " Bracket mappings
Plug 'w0rp/ale'                    " Asynchronous linting

" Filetypes
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'pearofducks/ansible-vim'

" Colors -- http://colorswat.ch/vim
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'

call plug#end()

" fzf configuration
nnoremap <C-P> :Files<CR>
nnoremap gb :Buffers<CR>
nnoremap gh :History<CR>

" w0rp/ale configuration
" Only use `htmlhint` for HTML to reduce noise for AngularJS views
" Avoid eslint for typescript since it is not configured correctly out of the box
let g:ale_linters = {
      \ 'html': ['htmlhint'],
      \ 'typescript': ['tslint', 'tsserver', 'typecheck']
      \}
let g:ale_html_htmlhint_options =
      \ '--format=unix ' .
      \ '-r ' .
      \ 'attr-lowercase,' .
      \ 'attr-no-duplication,' .
      \ 'attr-value-double-quotes,' .
      \ 'id-unique,' .
      \ 'inline-style-disabled,' .
      \ 'spec-char-escape,' .
      \ 'tag-pair'
" Use the global htmlhint instead of searching `node_modules`
let g:ale_html_htmlhint_use_global = 1

" elzr/vim-json configuration
" Don't conceal double quotes in JSON
let g:vim_json_syntax_conceal = 0

let g:jsx_ext_required = 1

" Match HTML tags, etc.
runtime! macros/matchit.vim

set cinoptions+=(0             " Line up function arguments
set fileformats=unix,dos,mac
set hidden                     " Hide buffers instead of closing buffers
set inccommand=nosplit         " Preview substitutions in Neovim
set laststatus=1               " Only show status bar if at least two windows
set mouse=a                    " Use the mouse in all modes
set nojoinspaces               " One space after sentences after join
set number                     " Show line numbers
set noruler                    " Don't show line and column of cursor in the status bar
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

" Search
if executable('rg')
  set grepprg=rg\ --vimgrep
endif

" Correct typos like `:W` and `:Q`
command! -bang W w<bang>
command! -bang Q q<bang>
command! -bang E e<bang>
command! -bang Qa qa<bang>
command! -bang QA qa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" %% expands to the current file's directory
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" Break undo before clearing the line.
inoremap <C-U> <C-G>u<C-U>

" Colors
" Disable true color for now since default macOS terminal doesn't support it
set termguicolors
colorscheme molokai

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
