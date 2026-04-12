return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nsidorenco/neotest-vstest',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-vstest' {
          dap_settings = {
            type = 'coreclr',
          },
        },
      },
    }
  end,
  keys = {
    {
      '<leader>td',
      function()
        require('neotest').run.run { strategy = 'dap' }
      end,
      desc = 'Run [T]est and [D]ebug',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open { enter = true }
      end,
      desc = 'Open [T]est [O]utput',
    },
    {
      '<leader>ts',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Toggle [T]est [S]ummary',
    },
  },
}
