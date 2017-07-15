let s:vimdir = $HOME . '/.vim/'
let s:rg_cmd = 'rg -H --no-heading --vimgrep --hidden'

function! s:warn(message)
  echom('Warning: ' . a:message)
endfunction

" Only attempt to load plugins if vim-plug is installed
" https://github.com/junegunn/vim-plug#installation
if !empty(glob(s:vimdir . 'autoload/plug.vim'))
  call plug#begin(s:vimdir . 'plugged')

  " General
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'mhinz/vim-grepper'           " Better grep
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

  " Colors -- http://colorswat.ch/vim
  Plug 'ayu-theme/ayu-vim'
  Plug 'jpo/vim-railscasts-theme'
  Plug 'sjl/badwolf'
  Plug 'tomasr/molokai'

  call plug#end()

  " Use FZF for quickly navigating to files
  nnoremap <C-P> :Files<cr>

  let g:grepper = {}
  let g:grepper.open = 1
  let g:grepper.quickfix = 1
  let g:grepper.stop = 1000
  let g:grepper.switch = 1

  " Add grep tools in order of preference if they're installed
  let g:grepper.tools = []
  let s:preferred_tools = ['rg', 'ag', 'grep', 'git']
  for tool in s:preferred_tools
    if (executable(tool))
      call add(g:grepper.tools, tool)
      if tool ==# 'rg'
        let g:grepper.rg = { 'grepprg': s:rg_cmd }
        " Also set `grepprg` in case I use `:grep` (muscle memory)
        let &grepprg = s:rg_cmd
      endif
    endif
  endfor

  nnoremap gs :Grepper<cr>
  xmap gs <plug>(GrepperOperator)

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
else
  " Use VimEnter to show the message, which avoids the enter to continue prompt
  call s:warn('vim-plug is not installed! See https://github.com/junegunn/vim-plug#installation')
  " Even if Vim plug is not installed, try to set up grepprg
  if executable('rg')
    let &grepprg = s:rg_cmd
    nnoremap gs :grep<Space>
  endif
endif

" Match HTML tags, etc.
runtime! macros/matchit.vim

set autoindent                 " Copy indent from current line when starting new line
set autoread                   " Detect file changes outside of vim
set backspace=indent,eol,start
set cinoptions+=(0             " Line up function arguments
set cursorline                 " Higlight screen line of cursor
set ffs=unix,dos,mac
set formatoptions+=j           " Remove comment leader when joining lines
set hidden                     " Hide buffers instead of closing buffers
set history=10000              " History of ':' commands and searches (10000 max)
set laststatus=1               " Only show status bar if at least two windows
set listchars=tab:>\ ,trail:-,nbsp:+
set mouse=a                    " Use the mouse in all modes
set nojoinspaces               " One space after sentences
set number                     " Show line numbers
set ruler                      " Show line and column of cursor in the status bar
set scrolloff=1                " Keep at least one line above and below the cursor
set sessionoptions-=options
set sidescrolloff=5            " Minimum columns to keep to the left and right of cursor
set spelllang=en_us
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
set incsearch                  " Show pattern matches while searching. `<C-L>` mapping below to clear highlighting.
set smartcase                  " Use a case-sensitive search when typing uppercase characters.

" Backup and tmp
set backup     " Make a backup before overwriting a file
set undofile   " Save undo history across sessions

if exists("&inccommand")
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
nnoremap <silent> <Leader><Leader> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" Quickly navigate windows
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k

" Break undo before clearing the line.
inoremap <C-U> <C-G>u<C-u>

" Automatically create backup, tmp, and undo directories if they don't exist
function! s:MkdirIfNecessary(path)
  if !isdirectory(a:path)
    call mkdir(a:path, 'p')
  endif
endfunction

let s:backupdir = s:vimdir . 'backup'
call s:MkdirIfNecessary(s:backupdir)
let &backupdir = s:backupdir

let s:tmpdir = s:vimdir . 'tmp'
call s:MkdirIfNecessary(s:tmpdir)
let &directory = s:tmpdir

let s:undodir = s:vimdir . 'undo'
call s:MkdirIfNecessary(s:undodir)
let &undodir = s:undodir

" Colors
if exists('&termguicolors')
  set termguicolors
endif
set background=dark " Tell Vim my terminal has a dark background

try
  colorscheme molokai
catch
  " Pick one of the less horrible out-of-the-box color schemes
  colorscheme slate
  " cursorline does not look good with slate
  set nocursorline
endtry

if !has('nvim')
  set ttimeout
  set ttimeoutlen=100
  " https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
  if $TERM_PROGRAM ==# 'iTerm.app'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
  endif
endif

if has('autocmd')
  augroup ft_asciidoc
    autocmd!
    autocmd BufRead,BufNewFile *.adoc set filetype=asciidoc
    autocmd FileType asciidoc setlocal spell
  augroup END

  augroup ft_gitcommit
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType gitcommit setlocal spellcapcheck=""
    " Recognize numbered lists
    autocmd FileType gitcommit setlocal formatoptions+=n
  augroup END

  augroup ft_go
    autocmd!
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal shiftwidth=8
    autocmd FileType go setlocal softtabstop=8
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
endif
