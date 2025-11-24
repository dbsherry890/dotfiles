local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('n', '<leader>e', ':NvimTreeToggle<cr>', opts)

-- Resize
keymap('n', '<C-Up>', ':resize +2<CR>', opts)
keymap('n', '<C-Down>', ':resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprev<CR>', opts)

keymap('n', '<leader>n', ':bnext<CR>', opts)
keymap('n', '<leader>p', ':bprev<CR>', opts)

keymap('n', '<leader>h', '^', opts)

-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- paste over currently selected text without yanking it
-- _ register is black hole. Unrecoverable
keymap('v', 'p', '"_dp', opts)
keymap('v', 'P', '"_dP', opts)
--
-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv=gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv=gv", opts)

-- Terminal --
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)
keymap('t', '<C-c>', '<C-\\><C-N>', term_opts)
keymap('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end)

keymap('n', '<leader>f', ':Format<cr>', opts)
keymap('n', '<leader>w', ':w<cr>', opts)
keymap('n', '<leader>q', ':q<cr>', opts)
keymap('n', '<leader>d', ':Bdelete<cr>', opts)

keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)

vim.keymap.set('n', '<c-a>', 'gg0VG', opts)

-- vim.keymap.set('n', 'YY', 'va{Vy', opts)
keymap('n', '<leader>rp', ':w<CR>:!python3 %<CR>', { noremap = true, silent = true })
keymap('n', '<leader>rl', ':w<CR>:!lua %<CR>', { noremap = true, silent = true })
keymap('n', '<leader>go', ':w<CR>:!go run .<CR>', { noremap = true, silent = true })
-- keymap('n', '<leader>x', ':.lua<CR>', opts) -- . means current line
-- keymap('v', '<leader>x', ':lua<CR>', opts)

-- undo word by word
keymap('i', '<space>', '<C-G>u<space>', opts)
keymap('n', '<leader>l', function()
  print(vim.api.nvim_get_current_line())
end, { desc = 'Print [Lua] [L]ine' })

keymap('n', '+', '<C-A>', opts)
keymap('n', '-', '<C-X>', opts)
