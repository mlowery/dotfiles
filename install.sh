#!/usr/bin/env zsh

cd $(dirname $0)

if [[ $1 == --rsync-only ]]; then
    _DOT_RSYNC_ONLY=true
fi

source .dotfiles-lib

if ! _dot_on_path git; then
    echo "ERROR: git is required"
    exit 1
fi

git pull origin master

function _dot_install() {

    rsync --exclude ".git/" --exclude ".gitignore" --exclude ".DS_Store" \
          --exclude "install.sh" --exclude "install.d"  --exclude "README.md" \
          --exclude "LICENSE-MIT.txt" --exclude ".idea" \
          -avK --no-perms --executability . ~

    if [[ $_DOT_RSYNC_ONLY ]]; then
        exit 0
    fi

    local install_dir=install.d
    if [[ -d $install_dir ]]; then
        for file in $install_dir/*; do
            if [[ -x $file ]]; then
                source $file
            fi
        done
    fi
    unset install_dir
    unset file

}

_dot_install

unset _dot_install

cd -