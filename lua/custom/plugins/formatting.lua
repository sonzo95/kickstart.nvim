-- Use :ConformInfo to debug formatters

return {
  'stevearc/conform.nvim',
  config = function()
    local conform = require 'conform'
    conform.setup {
      formatters_by_ft = {
        elixir = { 'mix' },
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        php = { 'php_cs_fixer' },
      },
      format_on_save = {
        enabled = true,
      },
      formatters = {
        php_cs_fixer = {
          env = {
            -- ignores php version compatibilities
            PHP_CS_FIXER_IGNORE_ENV = true,
          },
        },
      },
      async = true,
      lsp_fallback = true,
    }
  end,
}
