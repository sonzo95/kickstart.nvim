return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = {
        elixir = { 'mix' }
      },
      format_on_save = {
        enabled = true
      },
      formatters = {
        mix = {},
      },
      async = true,
    }
  end,
}
