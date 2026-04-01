return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    {
      '<leader>oo',
      function()
        vim.api.nvim_exec_autocmds('User', {
          pattern = 'ChangeBuffer',
        })
        if vim.bo.filetype ~= 'oil' then
          require('oil').open()
        end
      end,
      desc = '[O]pen [O]il',
    },
  },
}
