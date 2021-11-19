vim.api.nvim_exec([[
augroup quickfix
  autocmd!
  " Automatically open the location/quickfix window after `:make`, `:grep`,
  " `:lvimgrep` and friends if there are valid locations/errors
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    cwindow
  autocmd VimEnter        *     cwindow
augroup END
]], false)
