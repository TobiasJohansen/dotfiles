local function get_dll()
  return coroutine.create(function(dap_run_co)
    local items = vim.fn.globpath(vim.fn.getcwd(), '**/bin/Debug/**/*.dll', false, true)
    local opts = {
      format_item = function(path)
        return vim.fn.fnamemodify(path, ':t')
      end,
    }
    local function cont(choice)
      if choice == nil then
        return nil
      else
        coroutine.resume(dap_run_co, choice)
      end
    end

    vim.ui.select(items, opts, cont)
  end)
end

return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'

    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = get_dll,
      },
    }

    local widgets = require 'dap.ui.widgets'

    vim.keymap.set('n', '<leader>tb', dap.toggle_breakpoint, { desc = 'Debug: [T]oggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>tB', dap.clear_breakpoints, { desc = 'Debug: Clear [T]oggled [B]reakpoints' })

    vim.keymap.set('n', '<F1>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F2>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F4>', dap.step_back, { desc = 'Debug: Step Back' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })

    vim.keymap.set('n', '<leader>os', function()
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Debug: [O]pen [S]copes Float' })
  end,
}
