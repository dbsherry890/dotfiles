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
    -- Use a custom function to open the preview URL
    vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
    vim.cmd [[
      function! OpenMarkdownPreview(url) abort
        if has('wsl')
          silent execute '!wslview ' . a:url
        elseif has('mac')
          silent execute '!open ' . a:url
        else
          silent execute '!xdg-open ' . a:url
        endif
      endfunction
    ]]

    -- Auto-close the preview when you leave the markdown buffer
    vim.g.mkdp_auto_close = 1

    -- Refresh on save / leaving insert mode rather than on every keystroke
    vim.g.mkdp_refresh_slow = 1
  end,
}
