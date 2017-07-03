" https://github.com/junegunn/vim-plug#installation
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" General
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kepbod/quick-scope'          " Fork of 'unblevable/quick-scope', which seems to be unmaintained now
Plug 'milkypostman/vim-togglelist' " `<leader>q` and `<leader>l` toggle quickfix and location lists
Plug 'tommcdo/vim-lion'            " Line up text with `gl<motion><char>`
Plug 'tpope/vim-commentary'        " Comment and uncomment with `gcc` and `gc<motion>`
Plug 'tpope/vim-eunuch'            " Commands like `:Move` for Linux
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
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" Colors
" http://colorswat.ch/vim
Plug 'ajh17/Spacegray.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'jpo/vim-railscasts-theme'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'

call plug#end()

" Use FZF for quickly navigating to files
nnoremap <C-P> :Files<cr>

" Search with ripgrep or the silver searcher if installed
if executable('rg')
  set grepprg=rg\ --vimgrep
  " FZF with ripgrep
  let s:rg_command = 'rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --color "always" '
  command! -bang -nargs=* F
        \ call fzf#vim#grep(
        \   s:rg_command . shellescape(<q-args>), 1,
        \   <bang>0 ? fzf#vim#with_preview('up:60%')
        \           : fzf#vim#with_preview('right:50%:hidden', '?'),
        \   <bang>0)
  " Find word under cursor
  nnoremap <leader>g :F <C-R><C-W><CR>
elseif executable('ag')
  set grepprg=ag\ --vimgrep
  nnoremap <leader>g :Ag <C-R><C-W><CR>
endif

if executable('goimports')
  let g:go_fmt_command = 'goimports'
endif

" Only use `htmlhint` to reduce noise for AngularJS views
let g:ale_linters = {
      \ 'html': ['htmlhint']
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
let g:ale_html_htmlhint_use_global = 1
let g:ale_sign_column_always = 1

" Don't conceal double quotes in JSON
let g:vim_json_syntax_conceal = 0

" Match HTML tags
runtime! macros/matchit.vim

set autoindent                 " Copy indent from current line when starting new line
set autoread                   " Detect file changes outside of vim
set backspace=indent,eol,start
set cinoptions+=(0             " Line up function arguments
set cursorline                 " Higlight screen line of cursor
set expandtab                  " Pressing tab inserts spaces
set ffs=unix,dos,mac
set hidden                     " Hide buffers instead of closing buffers
set history=10000              " History of ':' commands and searches (10000 max)
set laststatus=1               " Only show status bar if at least two windows
set listchars=tab:»\ ,eol:¬
set mouse=a                    " Use the mouse in all modes
set nojoinspaces               " One space after sentences
set number                     " Show line numbers
set ruler                      " Show line and column of cursor in the status bar
set scrolloff=1                " Keep at least one line above and below the cursor
set showbreak=↪
set sidescrolloff=5            " Minimum columns to keep to the left and right of cursor
set spelllang=en_us
set splitbelow                 " Open horizontal splits below, instead of on top
set splitright                 " Open vertical splits to the right, instead of the left
set ttyfast                    " Assume a fast terminal, improves smoothness of rendering
set wildmenu                   " Enable command-line completion

" Tabs
set shiftwidth=2               " Indent two spaces by default
set smarttab                   " Insert spaces using 'shiftwidth' in front of a line
set softtabstop=2              " Number of spaces that a `<Tab>` counts for

" Search
set ignorecase                 " Ignore case in search patterns. Use `/\C` for case-sensitive searches.
set incsearch                  " Show pattern matches while searching. `<C-L>` mapping below to clear highlighting.
set smartcase                  " Use a case-sensitive search when typing uppercase characters.

if has ('nvim')
  set inccommand=nosplit       " Preview substitutions in Neovim
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

" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L33
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Backup and tmp
set backup     " Make a backup before overwriting a file
set noswapfile " Disable swapfiles used for crash recovery
set undofile   " Save undo history across sessions

" Note these directories must be created outside of Vim.
if has('nvim')
  set backupdir=~/.local/share/nvim/backup
  set directory=~/.local/share/nvim/tmp
  set undodir=~/.local/share/nvim/undo
else
  set backupdir=~/.vim/backup
  set directory=~/.vim/tmp
  set undodir=~/.vim/undo
endif

" Colors
if exists("&termguicolors")
  set termguicolors
endif
set background=dark " Tell Vim my terminal has a dark background
silent! colorscheme molokai

if !has('nvim')
  set ttimeout
  set ttimeoutlen=100
  " https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
  if $TERM_PROGRAM =~ "iTerm.app"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
  endif
endif

augroup ft_asciidoc
  autocmd!
  autocmd BufRead,BufNewFile *.adoc set filetype=asciidoc
  autocmd FileType asciidoc setlocal spell
augroup END

augroup ft_gitcommit
  autocmd!
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal spellcapcheck=""
  " Recnogize numbered lists
  autocmd FileType gitcommit setlocal formatoptions+=n
augroup END

augroup ft_go
  autocmd!
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go setlocal shiftwidth=8
  autocmd FileType go setlocal softtabstop=8
  autocmd FileType go setlocal textwidth=100
augroup END

augroup ft_html
  autocmd!
  " Disable the custom format expression set by vim-javascript that causes
  " problems using `gq` in HTML files
  autocmd FileType html setlocal formatexpr&
  " Don't indent previous line when pressing enter
  autocmd FileType html setlocal indentkeys-=*<Return>
augroup END

augroup ft_markdown
  autocmd!
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal spell
augroup END

augroup ft_sh
  autocmd!
  autocmd FileType sh setlocal shiftwidth=4
  autocmd FileType sh setlocal softtabstop=4
augroup END

augroup jshintrc
  autocmd!
  autocmd BufRead,BufNewFile .jshintrc set filetype=json
augroup END

augroup quickfix
    autocmd!
    " Automatically open the location/quickfix window after `:make`, `:grep`,
    " `:lvimgrep` and friends if there are valid locations/errors
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    cwindow
    autocmd VimEnter        *     cwindow
augroup END

augroup vagrantfile
  autocmd!
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
