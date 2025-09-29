return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    lazy = false,
    name = 'catppuccin',
    background = { -- :h background
      light = 'latte',
      dark = 'mocha',
    },
    opts = {
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = 'dark',
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      transparent_background = false,
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = {
          enabled = true,
          border = {
            completion = true,
            documentation = true,
          },
        },
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            information = { 'italic' },
            warnings = { 'italic' },
            errors = { 'italic' },
            hints = { 'italic' },
          },
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'lualine' },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = {
          enabled = true,
        },
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },

  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      filter = 'ristretto',
    },
  },

  {
    'lunacookies/vim-colors-xcode',
    lazy = false,
    priority = 1000,
  },

  {
    'xiyaowong/transparent.nvim',
    opts = {},
  },
}
