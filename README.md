# Always Focus

A Vim plugin: always focus.

## Installation

Install with your favorite plugin manager. Ex:

- vim-plug
  ```vimscript
  Plug 'zetatez/always-focus.vim'

  " config
  let g:always_focus_disable = 0
  let g:always_focus_disable_vertical = 0
  let g:always_focus_disable_horizontal = 1
  let g:always_focus_min_win = 4
  let g:always_focus_min_win_fullscreen = 10
  let g:always_focus_width = 124
  let g:always_focus_height = 26
  let g:always_focus_disable_float = 1
  let g:always_focus_disable_diff = 1
  let g:always_focus_disabled_filetypes = []
  let g:always_focus_disabled_buftypes = []
  let g:always_focus_disabled_filenames = []

  nnoremap <leader>cw :call AlwaysFocusToggle()<cr>
  ```

- packer
  ```lua
  use ({ 'zetatez/always-focus.vim' })

  -- config
  local g = vim.g
  g.always_focus_disable = 0
  g.always_focus_disable_vertical = 0
  g.always_focus_disable_horizontal = 1
  g.always_focus_min_win = 4
  g.always_focus_min_win_fullscreen = 8
  g.always_focus_width = 124
  g.always_focus_height = 26
  g.always_focus_disable_float = 1
  g.always_focus_disable_diff = 1
  g.always_focus_disabled_filetypes  = {}
  g.always_focus_disabled_buftypes = {}
  g.always_focus_disabled_filenames = {}

  local map = vim.keymap.set
  map('n' , '<leader>cw' , ':call AlwaysFocusToggle()<cr>' , { desc = 'AlwaysFocusToggle' })
  ```

### More
See `:h alway-focus`.
