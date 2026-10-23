" Vim's own defaults (incremental search, syntax highlighting, filetype
" detection, ...); not loaded automatically once a .vimrc exists
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" defaults.vim does this only when it detects a color terminal; be explicit
syntax on

" defaults.vim enables the mouse; keep the terminal's own text selection
set mouse=

" no colorscheme: use the terminal's colors, which follow Ghostty's
" light/dark theme
