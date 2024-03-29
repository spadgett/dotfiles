local set = vim.opt

-- general options
set.grepprg = 'rg --vimgrep'
set.inccommand = 'nosplit'
set.laststatus = 1
set.modeline = false
set.mouse = 'a'
set.number = true
set.scrolloff = 1
set.sidescrolloff = 5
set.smartcase = true
set.splitbelow = true
set.splitright = true
set.swapfile = false

-- indentation
local indent = 2
set.expandtab = true
set.softtabstop = indent
set.shiftwidth = indent

-- colors
set.background = 'dark'
set.termguicolors = true
vim.cmd('colorscheme OceanicNext')
