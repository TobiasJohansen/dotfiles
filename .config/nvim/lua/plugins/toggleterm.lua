return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    require('toggleterm').setup {
      persist_mode = false,
      start_in_insert = true,
      direction = 'float',
    }

    vim.keymap.set('n', '<leader>st', '<cmd>TermSelect<CR>', { desc = '[S]earch [T]erminals' })

    vim.keymap.set('n', '<leader>ot', function()
      require('toggleterm.terminal').Terminal:new():toggle()
    end, { desc = '[O]pen [T]erminal' })

    vim.keymap.set('n', '<leader>ol', function()
      local terminals = require('toggleterm.terminal').get_all()
      for _, term in pairs(terminals) do
        if term.display_name == 'lazygit' then
          term:open()
          return
        end
      end
      require('toggleterm.terminal').Terminal
        :new({
          cmd = vim.o.shell .. ' -ic ' .. 'lazygit',
          display_name = 'lazygit',
          close_on_exit = true,
        })
        :toggle()
    end, { desc = '[O]pen [L]azygit' })

    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = '[T]oggle [T]erminal' })

    vim.keymap.set('n', '<leader>ct', function()
      local terminals = require('toggleterm.terminal').get_all()
      for _, term in pairs(terminals) do
        if term:is_open() then
          term:shutdown()
        end
      end
    end, { desc = '[C]lose Open [T]erminals' })

    ---@param cmd string?
    ---@param toggle boolean
    ---@param open_in_normal_mode boolean
    local create_new_terminal = function(cmd, toggle, open_in_normal_mode)
      if not cmd or cmd == '' then
        return
      end

      local Terminal = require('toggleterm.terminal').Terminal

      local term = Terminal:new {
        cmd = vim.o.shell .. ' -ic ' .. vim.fn.shellescape(cmd),
        display_name = cmd,
        close_on_exit = false,
        on_open = function(t)
          if open_in_normal_mode then
            t:set_mode 'n'
          end
        end,
        on_exit = function(t)
          if t:is_open() then
            t:set_mode 'i'
          end
        end,
      }

      if toggle then
        term:toggle()
      else
        term:spawn()
      end
    end

    vim.keymap.set('n', '<leader>rc', function()
      vim.ui.input({
        prompt = 'Run Command: ',
        completion = 'shellcmd',
      }, function(cmd)
        create_new_terminal(cmd, true, true)
      end)
    end, { desc = '[R]un [C]ommand' })

    vim.keymap.set('n', '<leader>rb', function()
      vim.ui.input({
        prompt = 'Run Background Command: ',
        completion = 'shellcmd',
      }, function(cmd)
        create_new_terminal(cmd, false, true)
      end)
    end, { desc = '[R]un [B]ackground Command' })
  end,
}
