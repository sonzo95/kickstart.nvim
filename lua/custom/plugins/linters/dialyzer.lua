local function commit_item(item, commit_diagnostic, diagnostics, qf_list)
  -- ONLY attach the diagnostic if the error belongs to the file you are currently looking at
  if commit_diagnostic then
    table.insert(diagnostics, {
      source = 'dialyzer',
      lnum = item.lnum - 1, -- Neovim's diagnostic API expects 0-indexed line numbers!
      col = item.col - 1,
      message = item.message,
      severity = vim.diagnostic.severity.WARN, -- Dialyzer issues are treated as warnings
    })
  end

  table.insert(qf_list, {
    filename = item.file,
    lnum = item.lnum,
    col = item.col,
    text = item.message,
    type = 'W',
  })
end

local function reset_item(item)
  item.file = nil
  item.lnum = nil
  item.col = 0
  item.message = nil
end

local function trim(s)
  return s:match '^%s*(.-)%s*$'
end

local function ends_with(str, ending)
  return ending == '' or str:sub(-#ending) == ending
end

return {
  cmd = 'mix',
  stdin = false,
  args = { 'dialyzer', '--quiet', '--format', 'short' },
  stream = 'stderr',
  ignore_exitcode = true,
  parser = function(output, bufnr)
    local diagnostics = {}
    local qf_list = {}

    -- Get the relative path of your current buffer (e.g., "lib/thresher/my_file.ex")
    -- This ensures we can match it against Dialyzer's output.
    local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':.')

    local item = {}
    reset_item(item)

    for _, line in ipairs(vim.split(output, '\n')) do
      -- Matches format: "lib/thresher/my_file.ex:14:1: The call..."
      -- And fallbacks to format: "lib/thresher/my_file.ex:14: The call..."

      local file, lnum, col, message = string.match(line, '^(.+):(%d+):(%d+):%s*(.+)$')
      if not file then
        file, lnum, message = string.match(line, '^(.+):(%d+):%s*(.+)$')
      end

      if file and lnum and message then
        item.file = file
        item.lnum = tonumber(lnum)
        item.message = message
        if col then
          item.col = tonumber(col)
        end

        if ends_with(message, '.') then
          commit_item(item, item.file == buf_name, diagnostics, qf_list)
          reset_item(item)
        end
      else
        if item.message then
          local trimmed_line = trim(line)
          if trimmed_line == '.' then
            commit_item(item, item.file == buf_name, diagnostics, qf_list)
            reset_item(item)
          else
            item.message = item.message .. '\n' .. line
          end
        end
      end
    end

    vim.fn.setqflist({}, ' ', {
      title = 'Dialyzer Warnings',
      items = qf_list,
    })

    return diagnostics
  end,
}
