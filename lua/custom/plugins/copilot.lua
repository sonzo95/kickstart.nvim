-- INFO: Run `:Copilot setup` to set up the plugin

local prompts = {
  -- Code related prompts
  Explain = 'Please explain how the following code works.',
  Review = 'Please review the following code and provide suggestions for improvement.',
  Tests = 'Please explain how the selected code works, then generate unit tests for it.',
  Refactor = 'Please refactor the following code to improve its clarity and readability.',
  FixCode = 'Please fix the following code to make it work as intended.',
  FixError = 'Please explain the error in the following text and provide a solution.',
  BetterNamings = 'Please provide better names for the following variables and functions.',
  Documentation = 'Please provide documentation for the following code.',
  SwaggerApiDocs = 'Please provide documentation for the following API using Swagger.',
  SwaggerJsDocs = 'Please write JSDoc for the following API using Swagger.',
  -- Text related prompts
  Summarize = 'Please summarize the following text.',
  Spelling = 'Please correct any grammar and spelling errors in the following text.',
  Wording = 'Please improve the grammar and wording of the following text.',
  Concise = 'Please rewrite the following text to make it more concise.',
}

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
  -- {
  --   'CopilotC-Nvim/CopilotChat.nvim',
  --   dependencies = {
  --     { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
  --     { 'nvim-telescope/telescope.nvim' }, -- Use telescope for help actions
  --     { 'nvim-lua/plenary.nvim' },
  --   },
  --   opts = {
  --     question_header = '## User ',
  --     answer_header = '## Copilot ',
  --     error_header = '## Error ',
  --     prompts = prompts,
  --     -- model = "claude-3.7-sonnet",
  --     mappings = {
  --       -- Use tab for completion
  --       complete = {
  --         detail = 'Use @<Tab> or /<Tab> for options.',
  --         insert = '<C-y>',
  --       },
  --       -- Close the chat
  --       close = {
  --         normal = 'q',
  --         insert = '<C-c>',
  --       },
  --       -- Reset the chat buffer
  --       reset = {
  --         normal = '<C-x>',
  --         insert = '<C-x>',
  --       },
  --       -- Submit the prompt to Copilot
  --       submit_prompt = {
  --         normal = '<CR>',
  --         insert = '<C-CR>',
  --       },
  --       -- Accept the diff
  --       accept_diff = {
  --         normal = '<C-y>',
  --         insert = '<C-y>',
  --       },
  --       -- Show help
  --       show_help = {
  --         normal = 'g?',
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     local chat = require 'CopilotChat'
  --     chat.setup(opts)
  --
  --     local select = require 'CopilotChat.select'
  --     vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
  --       chat.ask(args.args, { selection = select.visual })
  --     end, { nargs = '*', range = true })
  --
  --     -- Inline chat with Copilot
  --     vim.api.nvim_create_user_command('CopilotChatInline', function(args)
  --       chat.ask(args.args, {
  --         selection = select.visual,
  --         window = {
  --           layout = 'float',
  --           relative = 'cursor',
  --           width = 1,
  --           height = 0.4,
  --           row = 1,
  --         },
  --       })
  --     end, { nargs = '*', range = true })
  --
  --     -- Restore CopilotChatBuffer
  --     vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
  --       chat.ask(args.args, { selection = select.buffer })
  --     end, { nargs = '*', range = true })
  --
  --     -- Custom buffer for CopilotChat
  --     -- vim.api.nvim_create_autocmd('BufEnter', {
  --     --   pattern = 'copilot-*',
  --     --   callback = function()
  --     --     vim.opt_local.relativenumber = true
  --     --     vim.opt_local.number = true
  --     --
  --     --     -- Get current filetype and set it to markdown if the current filetype is copilot-chat
  --     --     local ft = vim.bo.filetype
  --     --     if ft == 'copilot-chat' then
  --     --       vim.bo.filetype = 'markdown'
  --     --     end
  --     --   end,
  --     -- })
  --   end,
  --   event = 'VeryLazy',
  --   keys = {
  --     -- Show prompts actions with telescope
  --     {
  --       '<leader>mp',
  --       function()
  --         require('CopilotChat').select_prompt {
  --           context = {
  --             'buffers',
  --           },
  --         }
  --       end,
  --       desc = 'CopilotChat - Prompt actions',
  --     },
  --     {
  --       '<leader>mp',
  --       function()
  --         require('CopilotChat').select_prompt()
  --       end,
  --       mode = 'x',
  --       desc = 'CopilotChat - Prompt actions',
  --     },
  --     -- Code related commands
  --     { '<leader>me', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
  --     { '<leader>mt', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
  --     { '<leader>mr', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - Review code' },
  --     { '<leader>mR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - Refactor code' },
  --     { '<leader>mn', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better Naming' },
  --     -- Chat with Copilot in visual mode
  --     {
  --       '<leader>mv',
  --       ':CopilotChatVisual',
  --       mode = 'x',
  --       desc = 'CopilotChat - Open in vertical split',
  --     },
  --     {
  --       '<leader>mx',
  --       ':CopilotChatInline',
  --       mode = 'x',
  --       desc = 'CopilotChat - Inline chat',
  --     },
  --     -- Custom input for CopilotChat
  --     {
  --       '<leader>mi',
  --       function()
  --         local input = vim.fn.input 'Ask Copilot: '
  --         if input ~= '' then
  --           vim.cmd('CopilotChat ' .. input)
  --         end
  --       end,
  --       desc = 'CopilotChat - Ask input',
  --     },
  --     -- Generate commit message based on the git diff
  --     {
  --       '<leader>mm',
  --       '<cmd>CopilotChatCommit<cr>',
  --       desc = 'CopilotChat - Generate commit message for all changes',
  --     },
  --     -- Quick chat with Copilot
  --     {
  --       '<leader>mq',
  --       function()
  --         local input = vim.fn.input 'Quick Chat: '
  --         if input ~= '' then
  --           vim.cmd('CopilotChatBuffer ' .. input)
  --         end
  --       end,
  --       desc = 'CopilotChat - Quick chat',
  --     },
  --     -- Fix the issue with diagnostic
  --     { '<leader>mf', '<cmd>CopilotChatFixError<cr>', desc = 'CopilotChat - Fix Diagnostic' },
  --     -- Clear buffer and chat history
  --     { '<leader>ml', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
  --     -- Toggle Copilot Chat Vsplit
  --     { '<leader>mv', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
  --     -- Copilot Chat Models
  --     { '<leader>m?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
  --     -- Copilot Chat Agents
  --     { '<leader>ma', '<cmd>CopilotChatAgents<cr>', desc = 'CopilotChat - Select Agents' },
  --   },
  -- },

  -- NOTE: install Gemini cli with `brew install gemini-cli`

  {
    'folke/sidekick.nvim',
    -- opts = {
    --   -- add any options here
    --   cli = {
    --     mux = {
    --       backend = 'zellij',
    --       enabled = true,
    --     },
    --   },
    -- },
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
