return {
  'mason-org/mason-lspconfig.nvim',
  opts = {
    handlers = {
      -- default handler for all servers
      function(server_name)
        require('lspconfig')[server_name].setup {}
      end,
      -- gopls override
      gopls = function()
        require('lspconfig').gopls.setup {
          settings = {
            gopls = {
              hoverKind = 'FullDocumentation',
            },
          },
        }
      end,
    },
  },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
}
