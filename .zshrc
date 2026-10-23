# keep PATH and FPATH free of duplicates (e.g. in nested shells)
typeset -U path fpath

shell_dir=~/.shell.d
if [[ -d $shell_dir ]]; then
    for file in $shell_dir/*; do
        if [[ -x $file ]]; then
            source $file
        fi
    done
fi
unset shell_dir
unset file
