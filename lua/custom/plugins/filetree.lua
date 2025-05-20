-- return {
--     'echasnovski/mini.files',
--   config = {
--     vim.keymap.set('n', '<C-e>', '<CMD>Oil<CR>', { desc = 'Open file [E]xplorer' }),
--   },
-- }

return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
    },
    keys = {
      { '<C-e>', '<CMD>Neotree toggle=true reveal=true<CR>', desc = 'Open file [E]xplorer', silent = true },
    },
  },

  -- Adds support for file operations in LSP
  {
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Uncomment whichever supported plugin(s) you use
      -- "nvim-tree/nvim-tree.lua",
      'nvim-neo-tree/neo-tree.nvim',
      -- "simonmclean/triptych.nvim"
    },
    opts = {},
  },

  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = {
      vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open file [E]xplorer' }),
    },
  },
}
