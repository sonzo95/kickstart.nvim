return {
  {
    'A7Lavinraj/fyler.nvim',
    dependencies = { 'nvim-mini/mini.icons' },
    branch = 'stable',
    opts = {
      win = {
        kind_presets = {
          split_left_most = {
            width = '40abs',
          },
        },
      },
    },
    keys = {
      { '<leader>e', '<CMD>Fyler kind=float<CR>', desc = 'Open floating file [E]xplorer', silent = true },
      { '<C-e>', '<CMD>Fyler kind=split_left_most<CR>', desc = 'Toggle file tree', silent = true },
    },
  },
}
