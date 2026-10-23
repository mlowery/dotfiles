# dotfiles

These are my dotfiles for zsh on macOS. Originally a fork of [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles), it's a little different now. It's still rsync-based but bootstrapping is done via `install.sh` which rsyncs then runs through the `install.d` directory, installing various tools. Also, `~/.zshrc` sources files in `~/.shell.d`.

## Installation: MacOS

These are notes specific to me but perhaps are of use for anyone.

1. Install git (from Xcode). (It will be upgraded later via `install.sh`.)
1. Install brew.
1. Clone dotfiles.
1. Install Ghostty. (Config and themes: `.config/ghostty`.)
1. Install the Ubuntu Mono font from Google.
1. Remap caps lock key to control.

## Ghostty

The config lives in `.config/ghostty/config.ghostty` and the custom themes it references live in `.config/ghostty/themes`. Both are installed by `install.sh` along with everything else. Ghostty reloads its config with ⇧⌘,.

### Shell

`command = direct:/opt/homebrew/bin/zsh -l` (from brew, as a login shell so macOS's `path_helper` adds `/usr/local/bin` and `/etc/paths.d`)

### Colors

`theme = light:Monokai Pro Light Custom,dark:Monokai Pro Custom` follows the macOS light/dark appearance.

### Keys

The following key mappings convert MacOS-style keys to emacs keys (which are in turn configured with zsh's `bindkey` builtin in `.shell.d/05-keys`). Rows marked "default" are Ghostty's built-in macOS bindings and need no config (see `ghostty +list-keybinds --default`).

MacOS Keys|Behavior|emacs Keys|Ghostty|Extra Steps
---|---|---|---|---
⌘z|Undo|`^_`|`keybind = super+z=text:\x1f`|
⇧⌘Z|Redo|`^X^_u`|`keybind = super+shift+z=text:\x18\x1fu`|`bindkey '\x18\x1fu' redo`
⌘←Delete|Delete to beginning of line|`^U`|default: `super+backspace=text:\x15`|`bindkey '^U' backward-kill-line`
⌘fn←Delete or ⌘Delete→|Delete to end of line|`^[[3;9~`|default (no keybind needed)|`bindkey '^[[3;9~' kill-line`
⌥fn←Delete or ⌥Delete→|Delete word right|`^[[3;3~`|default (no keybind needed)|`bindkey '^[[3;3~' kill-word`
⌘←|Move to beginning of line|`^A`|default: `super+arrow_left=text:\x01`|
⌘→|Move to end of line|`^E`|default: `super+arrow_right=text:\x05`|
⌥←|Move word left|`M-b`|default: `alt+arrow_left=esc:b`|
⌥→|Move word right|`M-f`|default: `alt+arrow_right=esc:f`|

## Credits

Typically the credit is in the script file itself, however here are some highlights:

* [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [robbyrussell/oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
