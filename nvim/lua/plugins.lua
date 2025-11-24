return {
  {
    'folke/tokyonight.nvim',
    lazy = false, -- load on startup
    priority = 1000, -- make sure it loads before other plugins
    config = function()
      vim.g.tokyonight_style = 'storm' -- options: storm, night, day
      vim.g.tokyonight_italic_comments = true
      vim.g.tokyonight_italic_keywords = false
      vim.g.tokyonight_transparent = false
      vim.g.tokyonight_enable_italic = true

      vim.cmd 'colorscheme tokyonight'
    end,
  },
  'moll/vim-bbye',
}
