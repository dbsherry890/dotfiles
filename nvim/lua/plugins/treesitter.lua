return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- 'master' is frozen; 'main' is the actively maintained rewrite (needs Neovim 0.12+)
  lazy = false, -- this plugin doesn't support lazy-loading
  build = ':TSUpdate',
  config = function()
    local ensure_installed = { 'python', 'javascript', 'go' }
    require('nvim-treesitter').install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
