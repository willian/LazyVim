-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require('lazy.core.handler').handlers.keys

  -- do not create the keymap if a lazy keys handler exists
  ---@diagnostic disable-next-line: undefined-field
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Normal

-- select all
map('n', '<C-a>', 'gg<S-v>G')

-- Keeps cursor at the middle of the screen when jupping top and bottom
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Keeps cursor at the middle while searching
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- use jk to exit insert mode
map('i', 'jk', '<ESC>')

-- overwrite lazyvim mappings with vim-tmux-navigator mappings
-- see: https://github.com/christoomey/vim-tmux-navigator/blob/master/plugin/tmux_navigator.vim
map('n', '<C-h>', ':<C-U>TmuxNavigateLeft<CR>', { silent = true })
map('n', '<C-j>', ':<C-U>TmuxNavigateDown<CR>', { silent = true })
map('n', '<C-k>', ':<C-U>TmuxNavigateUp<CR>', { silent = true })
map('n', '<C-l>', ':<C-U>TmuxNavigateRight<CR>', { silent = true })
map('n', '<C-\\>', ':<C-U>TmuxNavigatePrevious<CR>', { silent = true })

-- Visual --

-- move selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move up' })

-- Command

map('c', 'Q', 'q')
map('c', 'W', 'w')
map('c', 'WA', 'wa')
map('c', 'WQ', 'wq')
map('c', 'wQ', 'wq')
map('c', 'WQA', 'wqa')
map('c', 'Wqa', 'wqa')
map('c', 'wQA', 'wqa')
map('c', 'WQa', 'wqa')
map('c', 'Wa', 'wa')
map('c', 'Wq', 'wq')
map('c', 'X', 'x')
