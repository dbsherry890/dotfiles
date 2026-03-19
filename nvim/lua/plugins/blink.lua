return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  opts = {
    snippets = { preset = 'default' },
    keymap = {
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' }, -- order matters
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
  },
}
