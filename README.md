# focus-window

A Neovim plugin to manage and optimize window focus dynamically.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "zetatez/focus-window",
  config = function()
    require("always_focus").setup({
      disable = 0,
      width = 120,
      height = 30,
      disabled_filetypes = { "NvimTree", "packer" },
    })
  end
}
```
