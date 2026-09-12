vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  callback = function()
    vim.bo.buflisted = true
    vim.cmd 'wincmd o' -- optional: close other windows so help takes over
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\r//ge]],
})

-- vim.api.nvim_create_autocmd('InsertLeave', {
--   pattern = '*',
--   command = 'silent! update',
-- })

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    if vim.bo.modified then
      vim.cmd 'update'
      print 'saved'
    end
  end,
})
