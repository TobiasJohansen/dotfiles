return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>r', group = '[R]un' },
      { '<leader>o', group = '[O]pen' },
      { '<leader>c', group = '[C]lose' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
