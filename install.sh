#!/usr/bin/env zsh
# Pull, run install.d (Homebrew, which provides stow), then link the repo
# into ~ with stow. --link-only skips install.d.

cd ${0:A:h} || exit 1

source .dotfiles-lib

if ! _dot_on_path git; then
    echo "ERROR: git is required"
    exit 1
fi

git pull origin master

if [[ $1 != --link-only ]]; then
    for file in install.d/*(N); do
        [[ -x $file ]] && source $file
    done
fi

if ! _dot_on_path stow; then
    echo "ERROR: stow is required (brew install stow)"
    exit 1
fi

# options (target ~, no folding) come from .stowrc; --restow also removes
# links to files deleted from the repo
stow --restow .
