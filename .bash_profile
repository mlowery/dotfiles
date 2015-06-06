bash_dir=~/.bash.d
if [[ -d $bash_dir ]]; then
    for file in $bash_dir/*; do
        if [[ -x $file ]]; then
            source $file
        fi
    done
fi
unset bash_dir
unset file