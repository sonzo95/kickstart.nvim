-- Use :ConformInfo to debug formatters

return {
  'stevearc/conform.nvim',
  dependencies = { 'williamboman/mason.nvim' },
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'ConformFormat' },

  keys = {
    {
      '<leader>bf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[B]uffer [F]ormat',
    },
  },
  opts = {
    formatters_by_ft = {
      -- not from Mason
      elixir = { 'mix' },
      lua = { 'stylua' },
      -- not from Mason
      rust = { 'rustfmt' },
      php = { 'php_cs_fixer' },
      javascript = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      tsx = { 'prettierd', 'prettier' },
      python = { 'black', 'isort', stop_after_first = false },
    },
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 3000, -- isort and black are slow af
        lsp_format = lsp_format_opt,
      }
    end,
    formatters = {
      php_cs_fixer = {
        env = {
          -- ignores php version compatibilities
          PHP_CS_FIXER_IGNORE_ENV = true,
        },
      },
      black = {
        command = 'poetry',
        args = { 'run', 'black', '--quiet', '-' },
      },
      isort = {
        command = 'poetry',
        args = { 'run', 'isort', '--profile', 'black', '-' },
      },
    },
    async = true,
    lsp_fallback = true,
  },
}
