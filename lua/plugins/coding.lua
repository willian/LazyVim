return {
  -- Supertab
  {
    'L3MON4D3/LuaSnip',
    keys = function()
      return {}
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-emoji',
      'js-everts/cmp-tailwind-colors',
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
            == nil
      end

      local luasnip = require('luasnip')
      local cmp = require('cmp')

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = 'emoji' } }))

      opts.mapping = vim.tbl_extend('force', opts.mapping, {
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      })

      opts.formatting = vim.tbl_extend('force', opts.formatting, {
        format = function(entry, item)
          local new_item = require('cmp-tailwind-colors').format(entry, item)
          local icons = require('lazyvim.config').icons.kinds

          if icons[new_item.kind] then
            new_item.kind = icons[new_item.kind] .. new_item.kind
          end

          return new_item
        end,
      })
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = {
          os.getenv('HOME') .. '/.local/share/LazyVim/lazy/friendly-snippets',
          os.getenv('HOME') .. '/.config/LazyVim/my_snippets',
        },
      })
    end,
  },

  -- add more treesitter parsers
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        'comment',
        'css',
        'dockerfile',
        'elixir',
        'gitignore',
        'go',
        'graphql',
        'jsdoc',
        'nix',
        'php',
        'phpdoc',
        'prisma',
        'ruby',
        'scss',
        'sql',
        'svelte',
        'toml',
        'vue',
      })

      opts.autotag = {
        enable = true,
      }
    end,
  },

  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
