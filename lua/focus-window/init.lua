-- Author: Dionysus
-- Email : zetatez@icloud.com

local M = {}

-- 默认配置
local default_config = {
  disable = false,
  disable_vertical = false,
  disable_horizontal = false,
  min_win = 3,
  min_win_fullscreen = 16,
  width = 124,
  height = 26,
  disable_float = true,
  disable_diff = true,
  disabled_filetypes = {},
  disabled_buftypes = {},
  disabled_filenames = {},
}

-- 当前配置和状态
M.config = {}
local is_adjusting = false -- 是否正在调整窗口

-- 初始化配置
function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
  M._setup_autocmd()
end

-- 判断是否需要调整窗口
local function should_focus()
  local config = M.config
  local win_config = vim.api.nvim_win_get_config(0)

  if config.disable
      or (config.disable_float and win_config.relative ~= "")
      or (config.disable_diff and vim.wo.diff)
      or vim.tbl_contains(config.disabled_filetypes, vim.bo.filetype)
      or vim.tbl_contains(config.disabled_buftypes, vim.bo.buftype) then
    return false
  end

  -- 检查是否匹配禁用文件名
  local filename = vim.fn.expand("%:t")
  for _, pattern in ipairs(config.disabled_filenames) do
    if filename:match(pattern) then return false end
  end

  return true
end

-- 主调整逻辑
function M.focus()
  if not should_focus() then return end

  local config = M.config
  local win_count = vim.fn.winnr('$')

  -- 如果窗口数少于或等于 `min_win`
  if win_count <= config.min_win then
    if is_adjusting then
      vim.cmd("wincmd =") -- 平分窗口
      is_adjusting = false -- 停止调整
    end
    return
  end

  -- 如果窗口数大于 `min_win`，启动调整逻辑
  if win_count > config.min_win then
    if win_count >= config.min_win_fullscreen then
      -- 全屏调整
      if not config.disable_vertical then vim.cmd("wincmd |") end
      if not config.disable_horizontal then vim.cmd("wincmd _") end
    else
      -- 普通调整
      if not config.disable_vertical then vim.o.winwidth = config.width end
      if not config.disable_horizontal then vim.o.winheight = config.height end
      vim.cmd("wincmd =")
    end
    is_adjusting = true -- 标记为调整中
  end
end

-- 切换功能开关，并平分窗口
function M.toggle()
  M.config.disable = not M.config.disable
end

-- 自动命令
function M._setup_autocmd()
  vim.api.nvim_create_augroup("AlwaysFocus", { clear = true })
  vim.api.nvim_create_autocmd("WinEnter", {
    group = "AlwaysFocus",
    callback = M.focus,
  })
end

-- 快捷键映射
return M
