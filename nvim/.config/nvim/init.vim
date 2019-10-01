call plug#begin('~/.local/share/nvim/plugged')

" General
Plug '/usr/local/opt/fzf'          " Use FZF installed by Homebrew
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tommcdo/vim-lion'            " Line up text with `gl<motion><char>`
Plug 'tpope/vim-commentary'        " Comment and uncomment with `gcc` and `gc<motion>`
Plug 'tpope/vim-fugitive'          " Git commands
Plug 'tpope/vim-repeat'            " Repeat surround and other plugin commands
Plug 'tpope/vim-rhubarb'           " GitHub utilities like `:Gbrowse`
Plug 'tpope/vim-surround'          " `ys`, `cs`, `ds` for parens and quotes
Plug 'tpope/vim-unimpaired'        " Bracket mappings

" Filetypes
Plug 'dag/vim-fish'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'pearofducks/ansible-vim'

" Colors
Plug 'ayu-theme/ayu-vim'

call plug#end()

set background=dark
set termguicolors
colorscheme ayu

" vim-json: don't conceal double quotes in JSON
let g:vim_json_syntax_conceal = 0

" vim-jsx: require `.jsx` extension for JSX highlighting and indentation
let g:jsx_ext_required = 1

" vim-prettier
let g:prettier#autoformat = 0
augroup prettier
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx Prettier
augroup END

set cinoptions+=(0             " Line up function arguments
set fileformats=unix,dos,mac
set hidden                     " Hide buffers instead of closing buffers
set inccommand=nosplit         " Preview substitutions in Neovim
set laststatus=1
set mouse=a                    " Use the mouse in all modes
set nojoinspaces               " One space after sentences after join
set number                     " Show line numbers
set nohlsearch
set nomodeline                 " Sidestep potential security vulnerabilities
set tagcase=followscs
set scrolloff=1                " Keep at least one line above and below the cursor
set sidescrolloff=5            " Minimum columns to keep to the left and right of cursor
set signcolumn=yes
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

" Jump to tag for CSS class under cursor.
nnoremap \<C-]> :tag .<C-R><C-F><CR>

" fzf mappings
nnoremap <C-P> :Files<CR>
nnoremap gb :Buffers<CR>
nnoremap gh :History<CR>

" coc.nvim mappings

" Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> \r <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.adoc set filetype=asciidoc
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
augroup END

augroup quickfix
  autocmd!
  " Automatically open the location/quickfix window after `:make`, `:grep`,
  " `:lvimgrep` and friends if there are valid locations/errors
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    cwindow
  autocmd VimEnter        *     cwindow
augroup END
