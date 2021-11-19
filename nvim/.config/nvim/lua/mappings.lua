local map = vim.api.nvim_set_keymap

map('n', '<c-p>', '<cmd>Telescope find_files find_command=fd,--type,f,--hidden<cr>', { noremap = true })
map('n', 'gb', '<cmd>Telescope buffers<cr>', { noremap = true })
