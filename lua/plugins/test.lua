return {
  'nvim-neotest/neotest',
  dependencies = {
    'haydenmeade/neotest-jest',
    'marilari88/neotest-vitest',
    'olimorris/neotest-rspec',
    'zidhuss/neotest-minitest',
  },
  keys = {
    {
      '<leader>tl',
      function()
        require('neotest').run.run_last()
      end,
      desc = 'Run Last Test',
    },
  },
  opts = function(_, opts)
    table.insert(
      opts.adapters,
      require('neotest-jest')({
        jestCommand = 'npm test --',
        jestConfig = 'jest.config.js',
        env = { CI = true },
        cwd = function()
          return vim.fn.getcwd()
        end,
      })
    )
    table.insert(opts.adapters, require('neotest-vitest'))
    table.insert(opts.adapters, require('neotest-rspec'))
    table.insert(opts.adapters, require('neotest-minitest'))
  end,
}
