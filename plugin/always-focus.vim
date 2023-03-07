" --
" --	Author: Dionysus
" --	Email : zetatez@icloud.com

" let g:always_focus_disable = 0
" let g:always_focus_disable_vertical = 0
" let g:always_focus_disable_horizental = 0
" let g:always_focus_min_win = 5
" let g:always_focus_min_win_fullscreen = 10
" let g:always_focus_width = 124
" let g:always_focus_height = 26
" let g:always_focus_disable_float = 1
" let g:always_focus_disable_diff = 1
" let g:always_focus_disabled_filetypes  = []
" let g:always_focus_disabled_buftypes = []
" let g:always_focus_disabled_filenames = []
" nnoremap <LEADER>cw :call AlwaysFocusToggle()<cr>

if exists('g:always_focus_loaded')
  finish
endif

let g:always_focus_loaded = 1

if !exists('g:always_focus_disable')
  let g:always_focus_disable = 1
endif

if !exists('g:always_focus_disable_vertical')
  let g:always_focus_disable_vertical = 0
endif

if !exists('g:always_focus_disable_horizontal')
  let g:always_focus_disable_horizontal = 0
endif

if !exists('g:always_focus_min_win')
  let g:always_focus_min_win = 5
endif

if !exists('g:always_focus_min_win_fullscreen')
  let g:always_focus_min_win_fullscreen = 10
endif

if !exists('g:always_focus_width')
  let g:always_focus_width = 124
endif

if !exists('g:always_focus_height')
  let g:always_focus_height = 26
endif

if !exists('g:always_focus_disable_float')
  let g:always_focus_disable_float = 1
endif

if !exists('g:always_focus_disable_diff')
  let g:always_focus_disable_diff = 1
endif

if !exists('g:always_focus_disabled_filetypes')
  let g:always_focus_disabled_filetypes  = []
endif

if !exists('g:always_focus_disabled_buftypes')
  let g:always_focus_disabled_buftypes = []
endif

if !exists('g:always_focus_disabled_filenames')
  let g:always_focus_disabled_filenames = []
endif

function! AlwaysFocusToggle()
  let g:always_focus_disable = !g:always_focus_disable
  if g:always_focus_disable
    wincmd =
  endif
endfunction

function! AlwaysFocus()
  if g:always_focus_disable
    return
  endif

  if g:always_focus_disable_float && exists('*nvim_win_get_config') && nvim_win_get_config(0)['relative'] != ''
    return
  endif

  if g:always_focus_disable_diff == 1 && &diff == 1
    return
  endif

  if index(g:always_focus_disabled_filetypes, &filetype) != -1
    return
  endif

  if index(g:always_focus_disabled_buftypes, &buftype) != -1
    return
  endif

  if len(g:always_focus_disabled_filenames) > 0
    let l:filename = expand('%:t')
    for l:disabled_filename in g:always_focus_disabled_filenames
      if match(l:filename, l:disabled_filename) > -1
        return
      endif
    endfor
  endif

  if winnr('$') < g:always_focus_min_win
    exec "set winwidth=1"
    exec "set winheight=1"
    wincmd =
    return
  endif

  if winnr('$') > g:always_focus_min_win_fullscreen && !(g:always_focus_min_win > g:always_focus_min_win_fullscreen)
    if !g:always_focus_disable_vertical
      wincmd |
    endif

    if !g:always_focus_disable_horizontal
      wincmd _
    endif

    return
  endif

  if !g:always_focus_disable_vertical
    exec "set winwidth=".g:always_focus_width
  endif

  if !g:always_focus_disable_horizontal
    exec "set winheight=".g:always_focus_height
  endif

  wincmd =
endfunction

augroup AlwaysFocus
  autocmd!
  autocmd! WinEnter * :call AlwaysFocus()
augroup END

