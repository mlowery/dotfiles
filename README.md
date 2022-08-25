# dotfiles

These are my dotfiles. It is collection of scripts, almost all of which were written by people other than myself. Originally a fork of [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles), it's a little different now. It's still rsync-based but bootstrapping is done via `install.sh` which rsyncs then runs through the `install.d` directory, installing various tools. Also, `~/.zshrc` sources files in `~/.shell.d`.

## Installation: MacOS

These are notes specific to me but perhaps are of use for anyone.

1. Install git (from Xcode). (It will be upgraded later via `install.sh`.)
1. Install brew.
1. Clone dotfiles.
1. Install iTerm2.
1. Install source code pro font from Google.
1. Remap caps lock key to control.
1. Set up `pre-commit` hook to check for no-no strings before commits:

```bash
#!/usr/bin/env bash

set -euo pipefail

fatal() { printf "%s\n" "$*" >&2; exit 1; }

search() {
	local s=${1?"search string is required"}
	if rg -i $s; then
		fatal "One or more files contain string \"$s\""
	fi
}

search s1
search s2
```

## iTerm2 Profile

All of the following can be imported from the `.iterm` directory but are additionally documented here.

### Shell

General > Command > Command: `/opt/local/bin/zsh --login` (from brew)

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
* [Stack Overflow: iTerm2: delete line?](https://stackoverflow.com/a/32340345)
* [Stack Overflow: iTerm 2: How to set keyboard shortcuts to jump to beginning/end of line?](https://stackoverflow.com/a/22312856)
* [Stack Overflow: iTerm 2: How to set keyboard shortcuts to jump to beginning/end of line?](https://stackoverflow.com/a/29403520)
* [Ask HN: What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11070797)

