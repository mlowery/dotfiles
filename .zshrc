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
