# dotfiles

These are my dotfiles. It is collection of scripts, almost all of which were 
written by people 
other than myself. Originally a fork of [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles), 
it's a little different now. It's still rsync-based but bootstrapping is done via `install.sh` which rsyncs then runs through
the `install.d` directory, installing various tools. Also, `.bash_profile` and `.bashrc` source files in 
`.bash.d`.

A user can be bootstrapped with this script (which I keep as a snippet in 
[ClipMenu](http://www.clipmenu.com/) for easy pasting):

```bash
__f=$(mktemp); wget -q -O $__f https://gist.github.com/mlowery/gist123/raw; $__f; /bin/rm $__f
```

Where the gist contains something like this:

```bash
#!/bin/sh
 
if ! which git &> null; then
    echo "Installing git..."
    sudo apt-get update && sudo apt-get install -y git-core
fi
 
install_dir=~/dotfiles
 
if [[ ! -d $install_dir ]]; then
    git clone https://github.com/mlowery/dotfiles.git "$install_dir"
else
    (cd "$install_dir" && git pull --ff-only)
fi
 
(cd "$install_dir" && source install.sh)

source ~/.bashrc
```

## Credits

I haven't been very good at keeping tabs on where I steal from but typically the 
credit is in the script file itself. Here are some highlights:

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Bash-it/bash-it](https://github.com/Bash-it/bash-it)
* [cowboy/dotfiles](https://github.com/cowboy/dotfiles)
* [holman/dotfiles](https://github.com/holman/dotfiles)
