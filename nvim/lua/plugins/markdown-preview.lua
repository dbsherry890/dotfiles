return {
  "iamceo/markdown-preview.nvim",
  -- enabled = false,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    -- Use a custom function to open the preview URL
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    vim.cmd([[
      function! OpenMarkdownPreview(url) abort
        if has('wsl')
          silent execute '!wslview ' . a:url
        elseif has('mac')
          silent execute '!open ' . a:url
        else
          silent execute '!xdg-open ' . a:url
        endif
      endfunction
    ]])

    -- Auto-close the preview when you leave the markdown buffer
    vim.g.mkdp_auto_close = 1

    -- Refresh on save rather than on every edit (better performance)
    vim.g.mkdp_refresh_slow = 0

    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown Preview" })
  end,
}
