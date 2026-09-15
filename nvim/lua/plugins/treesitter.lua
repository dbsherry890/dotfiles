return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- 'master' is frozen; 'main' is the actively maintained rewrite (needs Neovim 0.12+)
  lazy = false,    -- this plugin doesn't support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ensure_installed = { 'python', 'javascript', 'go', 'bash', 'sql', 'markdown', 'markdown_inline' }
    require('nvim-treesitter').install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        local opts = { buffer = true }
        vim.keymap.set('x', '<C-space>', function() vim.treesitter.incremental_selection('init') end, opts)
        vim.keymap.set('x', '<C-space>', function() vim.treesitter.incremental_selection('node') end, opts)
        vim.keymap.set('x', '<bs>', function() vim.treesitter.incremental_selection('scope') end, opts)
      end,
    })
  end,
}
