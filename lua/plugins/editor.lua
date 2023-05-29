return {
  -- buffer remove
  {
    'echasnovski/mini.bufremove',
    -- stylua: ignore
    keys = {
      { "<S-q>",      function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      -- { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      -- { "<leader>bD", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  -- Inline git-blame
  {
    'f-person/git-blame.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      vim.g.gitblame_enabled = 1
      vim.g.gitblame_message_template = '<summary> • <date> • <author>'
      vim.g.gitblame_highlight_group = 'LineNr'
    end,
  },

  -- peeks lines of the buffer in non-obtrusive way
  {
    'nacro90/numb.nvim',
    opts = {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    },
  },

  -- persist and toggle multiple terminals during an editing session
  {
    'akinsho/toggleterm.nvim',
    lazy = false,
    keys = {
      { '<leader>t1', '<cmd>1ToggleTerm<CR>', desc = 'Toggle terminal #1' },
      { '<leader>t2', '<cmd>2ToggleTerm<CR>', desc = 'Toggle terminal #2' },
      { '<leader>t3', '<cmd>3ToggleTerm<CR>', desc = 'Toggle terminal #3' },
      { '<leader>t4', '<cmd>4ToggleTerm<CR>', desc = 'Toggle terminal #4' },
      {
        '<leader>gg',
        function()
          _LAZYGIT_TOGGLE()
        end,
        desc = 'Toggle lazygit',
      },
    },
    opts = {
      size = 20,
      open_mapping = [[\\]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = 'curved',
        winblend = 0,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    },
    config = function(_, opts)
      local toggleterm = require('toggleterm')

      toggleterm.setup(opts)

      function _G.set_terminal_keymaps()
        local keymap_opts = { noremap = true }
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], keymap_opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], keymap_opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], keymap_opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], keymap_opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = 'lazygit',
        hidden = true,
        direction = 'float',
        float_opts = {
          border = 'none',
          width = 100000,
          height = 100000,
        },
        on_open = function(_)
          vim.cmd('startinsert!')
          -- vim.cmd "set laststatus=0"
        end,
        on_close = function(_)
          -- vim.cmd "set laststatus=3"
        end,
        count = 99,
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
    end,
  },
  -- Telescope
  {
    'telescope.nvim',
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
  },
  {
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },

  {
    'mhanberg/output-panel.nvim',
    keys = {
      { '<leader>uo', '<cmd>OutputPanel<cr>', desc = 'Toggle LSP output panel' },
    },
    config = true,
  },
}
