return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = { 'rafamadriz/friendly-snippets' },
  opts = {
    snippets = { preset = 'default' },
    keymap = {
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      ['<C-j>'] = { 'snippet_forward', 'fallback' },
      ['<C-k>'] = { 'snippet_backward', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' }, -- order matters
      providers = {
        lsp = { score_offset = 3 },
      },
    },
    completion = {
      documentation = { auto_show = true },
      menu = { border = 'rounded' },
      ghost_text = {
        enabled = true,
      },
    },
    signature = {
      enabled = true,
      window = { show_documentation = true },
    },
    fuzzy = { implementation = 'lua' },
  },
}
