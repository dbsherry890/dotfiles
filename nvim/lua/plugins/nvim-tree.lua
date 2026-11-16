return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle NvimTree' },
      { '<leader>fe', '<cmd>NvimTreeFocus<CR>', desc = 'Focus NvimTree' },
    },
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional icons
    },
    opts = function()
      local api = require 'nvim-tree.api'
      return {
        view = {
          width = 40,
          side = 'right',
          preserve_window_proportions = true,
          adaptive_size = true,
        },
        hijack_cursor = true,
        renderer = {
          highlight_git = true,
          highlight_opened_files = 'name',
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        git = {
          enable = true,
          ignore = false,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        filters = {
          -- dotfiles: when true, hides anything starting with "." (.git, .env, .zshrc...)
          --   false = dotfiles are SHOWN (what you have now)
          --   true  = dotfiles are HIDDEN
          -- Press `H` in the tree to toggle this on the fly either way.
          dotfiles = false,

          -- custom: list of VIM regexes (not Lua patterns!) matched against each
          -- file/dir NAME. Anything that matches is hidden.
          -- Press `U` in the tree to toggle these custom filters on/off.
          -- [[ ... ]] is a Lua long string, so backslashes reach Vim untouched.
          custom = {
            [[\.DS_Store$]],
            [[\.obsidian]],
            -- ^ = start of name, $ = end of name.
            -- Anchored so only a dir named exactly __pycache__ is hidden,
            -- not something like "my__pycache__notes.md".
            [[^__pycache__$]],

            -- \. = a literal dot (a bare . would mean "any character")
            -- pyc$ = name must END in pyc, so "foo.pyc" hides but "foo.pyc.bak" shows
            [[\.pyc$]],

            -- Same idea: hides clang's debug-symbol bundles like "hello.dSYM"
            [[\.dSYM$]],
          },
        },
        on_attach = function(bufnr)
          api.config.mappings.default_on_attach(bufnr)
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          local map = vim.keymap.set
          map('n', '<CR>', api.node.open.edit, opts 'Open')
          map('n', 'l', api.node.open.edit, opts 'Open')
          map('n', 'o', api.node.open.edit, opts 'Open')
          map('n', 'v', api.node.open.vertical, opts 'Open Vertical')
          map('n', 's', api.node.open.horizontal, opts 'Open Horizontal')
          map('n', 'a', api.fs.create, opts 'Create')
          map('n', 'd', api.fs.remove, opts 'Delete')
          map('n', 'r', api.fs.rename_sub, opts 'Rename')
          map('n', 'x', api.fs.cut, opts 'Cut')
          map('n', 'y', api.fs.copy.node, opts 'Copy')
          map('n', 'p', api.fs.paste, opts 'Paste')
          map('n', 'q', api.tree.close, opts 'Close')
          map('n', '?', api.tree.toggle_help, opts 'Help')
          map('n', '<leader>p', api.tree.change_root_to_node, opts 'Down')
          map('n', '<leader>P', api.tree.change_root_to_parent, opts 'Up')
          map('n', 'h', api.node.navigate.parent_close, opts 'close_node')
        end,
      }
    end,
  },
}
