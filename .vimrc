filetype plugin indent on

set autoindent                 " Copy indent from current line when starting new line
set autoread                   " Detect file changes outside of vim
set backspace=indent,eol,start
set cinoptions+=(0             " Line up function arguments
set fileformats=unix,dos,mac
set formatoptions+=j           " Remove comment leader when joining lines
set hidden                     " Hide buffers instead of closing buffers
set history=10000              " History of ':' commands and searches (10000 max)
set hlsearch
set listchars=tab:>\ ,trail:-,nbsp:+
set mouse=a                    " Use the mouse in all modes
set nojoinspaces               " One space after sentences after join
set number                     " Show line numbers
set scrolloff=1                " Keep at least one line above and below the cursor
set sessionoptions-=options
set sidescrolloff=5            " Minimum columns to keep to the left and right of cursor
set splitbelow                 " Open horizontal splits below, instead of on top
set splitright                 " Open vertical splits to the right, instead of the left
set ttyfast                    " Assume a fast terminal, improves smoothness of rendering
set wildmenu                   " Enable command-line completion

" Tabs
set expandtab                  " Pressing tab inserts spaces
set shiftwidth=2               " Indent two spaces by default
set smarttab                   " Insert spaces using 'shiftwidth' in front of a line
set softtabstop=2              " Number of spaces that a `<Tab>` counts for

" Search
set ignorecase                 " Ignore case in search patterns. Use `/\C` for case-sensitive searches.
set incsearch                  " Show pattern matches while searching.
set smartcase                  " Use a case-sensitive search when typing uppercase characters.

" Backup and tmp
set backup                     " Make a backup before overwriting a file
set noswapfile                 " Don't make swapfiles. I save often and have never found them helpful.
set undofile                   " Save undo history across sessions

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

" Break undo before clearing the line.
inoremap <C-U> <C-G>u<C-U>
