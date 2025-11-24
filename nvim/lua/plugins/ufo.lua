return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async' },
  opts = {},
  config = function(_, opts)
    -- Neovim fold settings
    vim.o.foldcolumn = '1' -- show fold column
    vim.o.foldenable = true -- enable folding
    vim.o.foldmethod = 'expr' -- use expr-based folding
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()' -- treesitter folds
    vim.o.foldlevel = 99 -- huge number: folds start open
    vim.o.foldlevelstart = 99 -- start with all folds open

    require('ufo').setup(opts)

    -- Optional keymaps to toggle folds easily
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  end,
}
