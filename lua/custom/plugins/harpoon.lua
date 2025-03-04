return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {},
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = 'Harpoon append file' })

    vim.keymap.set('n', '<leader>w', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon list files' })

    vim.keymap.set('n', '<C-b>', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon prev' })
    vim.keymap.set('n', '<C-n>', function()
      harpoon:list():next()
    end, { desc = 'Harpoon next' })
  end,
}
