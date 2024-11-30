-- Author: Dionysus
-- Email : zetatez@icloud.com

local M = {}

local default_config = {
  disable = false,
  disable_vertical = false,
  disable_horizontal = false,
  min_win = 3,
  min_win_fullscreen = 16,
  win_width = 84,
  win_height = 26,
}

M.config = {} -- current config

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
  M._setup_autocmd()
end

function M.focus()
  if M.config.disable then
    return
  end

  local win_count = vim.fn.winnr('$')
  if win_count <= M.config.min_win then
    -- vim.cmd("wincmd =") -- 平分窗口
    return
  end

  if win_count > M.config.min_win and win_count < M.config.min_win_fullscreen then
      if not M.config.disable_vertical then vim.o.winwidth = M.config.win_width end
      if not M.config.disable_horizontal then vim.o.winheight = M.config.win_height end
      vim.cmd("wincmd =")
    return
  else -- if win_count >= M.config.min_win_fullscreen then
    if not M.config.disable_vertical then vim.cmd("wincmd |") end
    if not M.config.disable_horizontal then vim.cmd("wincmd _") end
  end
end

function M.toggle()
  M.config.disable = not M.config.disable
end

function M._setup_autocmd()
  vim.api.nvim_create_augroup("AlwaysFocus", { clear = true })
  vim.api.nvim_create_autocmd("WinEnter", {
    group = "AlwaysFocus",
    callback = M.focus,
  })
end

return M
