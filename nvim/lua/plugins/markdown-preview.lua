-- Live preview of the current markdown file in your browser.
-- Disabled for now: render-markdown.nvim (markdown.lua) renders in the
-- buffer instead. Flip `enabled` to true to try this, then :Lazy sync.
return {
  'iamcco/markdown-preview.nvim',
  enabled = false,
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  -- Downloads the prebuilt preview server (no node/yarn needed).
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  keys = {
    { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Toggle Markdown Preview', ft = 'markdown' },
  },
  -- `init` runs at startup, before the plugin loads, which is when
  -- markdown-preview reads its g: settings.
  init = function()
    -- Open the preview URL with vim.ui.open (handles mac / WSL / linux)
    vim.cmd [[
      function! OpenMarkdownPreview(url) abort
        call v:lua.vim.ui.open(a:url)
      endfunction
    ]]
    vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'

    -- Auto-close the preview when you leave the markdown buffer
    vim.g.mkdp_auto_close = 1

    -- Refresh on save / leaving insert mode rather than on every keystroke
    vim.g.mkdp_refresh_slow = 1
  end,
}
