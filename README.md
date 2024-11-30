# focus-window

A Neovim plugin to manage and optimize window focus dynamically.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "zetatez/focus-window",
  config = function()
    require("focus-window").setup({
      disable = false,
      disable_vertical = false,
      disable_horizontal = false,
      min_win = 3,
      min_win_fullscreen = 8,
      width = 124,
      height = 26,
    })
    vim.keymap.set("n", "<LEADER>cw", function() require("focus-window").toggle() end, { noremap = true, silent = true, desc = "平分窗口" })
  end
}
```
