#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")"

_DOT_NET_OK=true
if [[ $1 == --no-net ]]; then
    _DOT_NET_OK=false
fi

source .dotfiles-lib

if _dot_net_ok && ! _dot_on_path git; then
    echo "ERROR: git is required"
    exit 1
fi

if _dot_net_ok; then
    git pull origin master
fi

function _dot_install() {

    rsync --exclude ".git/" --exclude ".gitignore" --exclude ".DS_Store" \
          --exclude "install.sh" --exclude "install.d"  --exclude "README.md" \
          --exclude "LICENSE-MIT.txt" --exclude ".idea" \
          -avK --no-perms --executability . ~

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