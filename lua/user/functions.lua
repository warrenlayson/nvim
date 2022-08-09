local M = {}

function M.isempty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local present, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not present then
    return nil
  else
    return buf_option
  end
end

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd "q!"
      end
    end)
  else
    vim.cmd "q!"
  end
end

return M
