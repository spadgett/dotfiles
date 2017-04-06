" https://github.com/junegunn/vim-plug#installation
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" general
Plug 'benekastah/neomake'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" filetypes
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" colors
Plug 'ayu-theme/ayu-vim'
Plug 'jpo/vim-railscasts-theme'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'

call plug#end()

if executable("rg")
  let g:ctrlp_user_command = 'rg --files  %s'
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g ""'
  set grepprg=ag\ --vimgrep
else
  " fall back to using git ls-files if ag is not available
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

if executable('jshint')
  let g:neomake_javascript_enabled_makers = ['jshint']
endif

if executable('tsc')
  let g:neomake_typescript_enabled_makers = ['tsc']
endif

let g:vim_json_syntax_conceal = 0

runtime! macros/matchit.vim

set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i
set cursorline
set expandtab
set ffs=unix,dos,mac
set hidden
set history=10000
set laststatus=1
set listchars=tab:»\ ,eol:¬
set mouse=a
set noswapfile
set number
set ruler
set scrolloff=1
set showbreak=↪
set sidescrolloff=5
set spelllang=en_us
set ttyfast
set wildmenu

" tabs
set shiftwidth=2
set smarttab
set softtabstop=2

" search
set ignorecase
set incsearch
set smartcase

" mappings
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

" backup and tmp
set backup
set noswapfile
set undofile
if has('nvim')
  set backupdir=~/.local/share/nvim/backup
  set directory=~/.local/share/nvim/tmp
  set undodir=~/.local/share/nvim/undo
else
  set backupdir=~/.vim/backup
  set directory=~/.vim/tmp
  set undodir=~/.vim/undo
endif

" colors
if exists("&termguicolors")
  set termguicolors
endif
set background=dark
silent! colorscheme ayu

" https://hamberg.no/erlend/posts/2014-03-09-change-vim-cursor-in-iterm.html
if $TERM_PROGRAM =~ "iTerm.app"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " block in normal mode
endif

" change cursor back to block more quickly when leaving insert mode
set ttimeout
set ttimeoutlen=100

augroup ft_asciidoc
  autocmd!
  autocmd BufRead,BufNewFile *.adoc set filetype=asciidoc
  autocmd FileType asciidoc setlocal spell
augroup END

augroup ft_gitcommit
  autocmd!
  autocmd FileType gitcommit setlocal spell
  autocmd FileType gitcommit setlocal spellcapcheck=""
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
  autocmd FileType html setlocal formatexpr&
  " don't indent previous line when pressing enter
  autocmd FileType html setlocal indentkeys-=*<Return>
augroup END

augroup ft_javascript
  autocmd!
  " run jshint on save
  autocmd BufWritePost,BufEnter *.js Neomake
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

augroup ft_typescript
  autocmd!
  autocmd BufWritePost,BufEnter *.ts Neomake
augroup END

augroup jshintrc
  autocmd!
  autocmd BufRead,BufNewFile .jshintrc set filetype=json
augroup END

augroup vagrantfile
  autocmd!
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
