--- @return string | nil
local function read_file(path)
  local file = io.open(path, 'rb') -- r read mode and b binary mode
  if not file then
    return nil
  end
  local content = file:read '*a' -- *a or *all reads the whole file
  file:close()
  return content
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local file_contents = read_file 'mix.exs'
    if not file_contents then
      return
    end

    local parser = vim.treesitter.get_string_parser(file_contents, 'elixir', {})
    local query_str = [[
(pair key: (keyword) @keyword (#match? @keyword "elixir:.*") value: (string (quoted_content) @content))
      ]]
    local query = vim.treesitter.query.parse(parser:lang(), query_str)
    local tree = parser:parse()[1]
    local root = tree:root()

    for id, node, metadata, match in query:iter_captures(root, file_contents, 0) do
      print(dump(match:captures()))
      -- print(node:sexpr())
      -- Print the node name and source text.
      -- vim.print { node:type(), vim.treesitter.get_node_text(node, file_contents) }
    end
  end,
})

function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end
