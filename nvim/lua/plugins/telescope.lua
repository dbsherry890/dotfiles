local actions = require 'telescope.actions'

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      prompt_prefix = '>> ',
      selection_caret = '$ ',
      path_display = { 'smart' },
      mappings = {
        i = {
          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,
          -- ['<C-n>'] = actions.cycle_history_next,
          -- ['<C-p>'] = actions.cycle_history_prev,
          ['<C-p>'] = actions.move_selection_previous,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-c>'] = actions.close,
          ['<CR>'] = actions.select_default,
          ['<C-y>'] = actions.select_tab,
        },
      },
    },
    pickers = {
      planets = {
        show_pluto = true,
        show_moon = true,
      },
    },
    extensions = {
      media_files = {
        filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
        find_cmd = 'rg',
      },
    },
  },

  config = function(_, opts)
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local keymap = vim.keymap.set
    telescope.setup(opts)

    keymap('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    keymap('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    keymap('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    keymap('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    keymap('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    keymap('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    keymap('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    keymap('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    keymap('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    keymap('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    keymap('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 14,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })
    keymap('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })
    keymap('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
