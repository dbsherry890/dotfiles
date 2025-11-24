return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'dracula',
      section_separators = '',
      component_separators = '',
      disabled_filetypes = {
        statusline = { 'NvimTree' }, -- disable lualine in Neo-tree
        winbar = {}, -- leave winbar untouched
      },
    },
    sections = {
      lualine_b = {},
      lualine_c = {
        {
          'filename',
          path = 1,
        },
      },
      lualine_x = { 'lsp_status' },
      lualine_y = { 'branch' },
      lualine_z = {},
    },
  },
}

--filename path defs
-- 0: Just the filename
-- 1: Relative path
-- 2: Absolute path
-- 3: Absolute path, with tilde as the home directory
-- 4: Filename and parent dir, with tilde as the home directory

-- symbol meaning
-- modified = '[+]'
-- readonly = '[-]'
