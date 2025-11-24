-- autocorrect abbreviations for Insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = function()
    local abbrevs = {
      teh = 'the',
      adn = 'and',
      recieve = 'receive',
    }

    for wrong, right in pairs(abbrevs) do
      vim.api.nvim_buf_set_keymap(0, 'i', wrong, right, { noremap = true, expr = false })
    end
  end,
})
