git clone dotfiles
Install iterm
install source code pro font from google
remap caps lock key to control




# dotfiles

These are my dotfiles. It is collection of scripts, almost all of which were written by people other than myself. Originally a fork of [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles), it's a little different now. It's still rsync-based but bootstrapping is done via `install.sh` which rsyncs then runs through the `install.d` directory, installing various tools. Also, `~/.zshrc` sources files in `~/.shell.d`.

A user can be bootstrapped in a way similar to the following:

```bash
bash <(curl -sL https://gist.github.com/mlowery/gist123/raw)
```

Where the gist contains something like this:

```bash
if ! which git &> null; then
  echo "Installing git..."
  # this will give you the latest git
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt-get -y update
  sudo apt-get -y install git
fi

install_dir=~/dotfiles

if [[ ! -d $install_dir ]]; then
  git clone https://github.com/mlowery/dotfiles.git "$install_dir"
else
  (cd "$install_dir" && git pull --ff-only)
fi

(cd "$install_dir" && ./install.sh)
```

## iTerm Profile

### Shell

General > Command > Command: `/opt/local/bin/zsh --login` (from MacPorts)

### Colors

Colors > Color Presets... > Snazzy (from https://github.com/sindresorhus/iterm2-snazzy)

### Keys

The following key mappings convert MacOS-style keys to emacs keys (which are in turn configured with zsh's `bindkey` builtin).

MacOS Keys|Behavior|emacs Keys|iTerm|Extra Steps
---|---|---|---|---
⌘z|Undo|`^_`|Send Hex Codes: `0x1f`|
⇧⌘Z|Redo|`^X^_`|Send Hex Codes: `0x18 0x1f`|`bindkey "^X^_" redo`
⌘←Delete|Delete to beginning of line|`^X DEL`|Send Hex Codes: `0x18 0x7f`|`bindkey "^X\\x7f" backward-kill-line`
⌘fn←Delete or ⌘Delete→|Delete to end of line|`^K`|Send Hex Codes: `0x0b`
⌥←Delete|Delete word left|?|Send Hex Codes: `0x1b 0x08`|
⌥fn←Delete or ⌥Delete→|Delete word right|?|Send Hex Codes: `0x01b 0x64`|
⌘←|Move to beginning of line|?|Send Hex Codes: `0x01`|
⌘→|Move to end of line|?|Send Hex Codes: `0x05`|
⌥←|Move word left|?|Send Hex Codes: `0x1b 0x62`|
⌥→|Move word right|?|Send Hex Codes: `0x1b 0x66`|
fn←Delete or Delete→|Delete character right|`^D`|Send Hex Codes: `0x04`|

## Credits

Typically the credit is in the script file itself, however here are some highlights:

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [Bash-it/bash-it](https://github.com/Bash-it/bash-it)
* [cowboy/dotfiles](https://github.com/cowboy/dotfiles)
* [holman/dotfiles](https://github.com/holman/dotfiles)
* [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* https://stackoverflow.com/a/32340345
* https://stackoverflow.com/a/22312856
* https://stackoverflow.com/a/29403520
