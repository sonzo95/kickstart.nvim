-- INFO: Run `:Copilot setup` to set up the plugin

return {
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>m', group = 'AI [M]odels' },
      },
    },
  },

  -- NOTE: install Gemini cli with `brew install gemini-cli`

  {
    'folke/sidekick.nvim',
    opts = {
      cli = {
        prompts = {
          -- Add your custom prompts here. Available context placeholders:
          -- {this}, {selection}, {file}, {function}, {class}, {line}, {position},
          -- {diagnostics}, {diagnostics_all}, {buffers}, {quickfix}
          commit = 'Write a conventional commit message for my changes',
          refactor = 'Refactor {this} to improve readability and maintainability',
          implement = 'Implement {this}',
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>mm",
        function() require("sidekick.cli").toggle() end,
        mode = { "n", "v" },
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>mc",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Sidekick Select CLI",
      },
      {
        "<leader>mt",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>ms",
        function() require("sidekick.cli").send({ selection = true }) end,
        mode = { "v" },
        desc = "Sidekick Send Visual Selection",
      },
      {
        "<leader>mp",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "v" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
    },
  },
}
