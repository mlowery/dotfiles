if filereadable(expand("~/.vim/autoload/pathogen.vim"))
    execute pathogen#infect()
endif

syntax on
filetype plugin indent on

" from spf13
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized
endif
