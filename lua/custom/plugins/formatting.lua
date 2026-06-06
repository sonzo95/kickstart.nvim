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
        require('conform').format { async = true }
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
      html = { 'prettierd', 'prettier' },
      -- python = { 'black', 'isort', stop_after_first = false },
      glsl = { 'clang-format' },
      odin = { 'odinfmt' },
    },
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Fix: Use dictionary keys so we can look them up by filetype string
      local disable_filetypes = { yml = true, yaml = true }

      -- If the filetype is in our disable list, return nil to skip formatting entirely
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      end

      return {
        timeout_ms = 3000, -- isort and black are slow af
        lsp_format = 'fallback',
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
