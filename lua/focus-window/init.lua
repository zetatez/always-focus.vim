-- Author: Dionysus
-- Email : zetatez@icloud.com

local M = {}

-- 默认配置
local default_config = {
  disable = 0,
  disable_vertical = 0,
  disable_horizontal = 0,
  min_win = 3,
  min_win_fullscreen = 8,
  width = 124,
  height = 26,
  disable_float = 1,
  disable_diff = 1,
  disabled_filetypes = {},
  disabled_buftypes = {},
  disabled_filenames = {},
}

M.config = {}

-- 配置初始化
function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
  M.setup_autocmd()
  M.setup_keymaps()
end

-- 检查条件是否满足
local function should_focus()
  local config = M.config
  if config.disable == 1 then return false end

  if config.disable_float == 1 and vim.api.nvim_win_get_config(0).relative ~= "" then
    return false
  end

  if config.disable_diff == 1 and vim.wo.diff then
    return false
  end

  if vim.tbl_contains(config.disabled_filetypes, vim.bo.filetype) then
    return false
  end

  if vim.tbl_contains(config.disabled_buftypes, vim.bo.buftype) then
    return false
  end

  local filename = vim.fn.expand("%:t")
  for _, pattern in ipairs(config.disabled_filenames) do
    if filename:match(pattern) then return false end
  end

  return vim.fn.winnr('$') >= config.min_win
end

-- 主逻辑
function M.focus()
  local config = M.config
  if not should_focus() then return end

  local win_count = vim.fn.winnr('$')

  if win_count >= config.min_win_fullscreen then
    if config.disable_vertical == 0 then vim.cmd("wincmd |") end
    if config.disable_horizontal == 0 then vim.cmd("wincmd _") end
  else
    if config.disable_vertical == 0 then vim.o.winwidth = config.width end
    if config.disable_horizontal == 0 then vim.o.winheight = config.height end
    vim.cmd("wincmd =")
  end
end

-- 切换功能开关
function M.toggle()
  M.config.disable = M.config.disable == 1 and 0 or 1
  if M.config.disable == 1 then vim.cmd("wincmd =") end
end

-- 自动命令
function M.setup_autocmd()
  vim.api.nvim_create_augroup("AlwaysFocus", { clear = true })
  vim.api.nvim_create_autocmd("WinEnter", {
    group = "AlwaysFocus",
    callback = M.focus,
  })
end

-- 映射快捷键
function M.setup_keymaps()
  vim.api.nvim_set_keymap(
    "n",
    "<LEADER>cw",
    ":lua require('always_focus').toggle()<CR>",
    { noremap = true, silent = true }
  )
end

return M

