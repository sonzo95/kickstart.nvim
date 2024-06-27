return {
  'stevearc/oil.nvim',
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = {
    vim.keymap.set('n', '<C-e>', '<CMD>Oil<CR>', { desc = 'Open file [E]xplorer' }),
  },
}
