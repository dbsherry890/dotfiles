return {
  'christoomey/vim-tmux-navigator',
  lazy = false, -- load immediately so mappings always work
  keys = {
    { '<C-h>', '<cmd>TmuxNavigateLeft<CR>', desc = 'Navigate left (tmux)' },
    { '<C-j>', '<cmd>TmuxNavigateDown<CR>', desc = 'Navigate down (tmux)' },
    { '<C-k>', '<cmd>TmuxNavigateUp<CR>', desc = 'Navigate up (tmux)' },
    { '<C-l>', '<cmd>TmuxNavigateRight<CR>', desc = 'Navigate right (tmux)' },
    { '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', desc = 'Navigate previous (tmux)' },
  },
}
