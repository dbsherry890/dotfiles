return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    -- {
    --   'windwp/nvim-autopairs',
    --   config = function()
    --     require('nvim-autopairs').setup {}
    --     local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    --     local blink = require 'blink.cmp'
    --     blink.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    --   end,
    -- },
  },
  opts = {
    snippets = { preset = 'default' },
    keymap = {
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      -- ['<CR>'] = { 'select_and_accept', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      documentation = { auto_show = true },
      menu = { border = 'rounded' },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { enabled = true },
    fuzzy = { implementation = 'lua' },
    -- lsp = {
    --   capabilities = function()
    --     local blink = require 'blink.cmp'
    --     local caps = blink.get_lsp_capabilities()
    --     return caps
    --   end,
    --   servers = {
    --     gopls = {
    --       settings = {
    --         gopls = {
    --           completeUnimported = true,
    --           usePlaceholders = true,
    --           staticcheck = true,
    --         },
    --       },
    --     },
    --   },
    -- },
  },
}
