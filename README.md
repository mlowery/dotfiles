# dotfiles

These are my dotfiles for zsh on macOS. The repo mirrors `~`, and [GNU Stow](https://www.gnu.org/software/stow/) symlinks each file into place, so editing `~/.zshrc` edits the repo. `install.sh` pulls, runs `install.d` (Homebrew and the `Brewfile`), then links with `stow --restow .`; `./install.sh --link-only` skips `install.d`. `~/.zshrc` sources the files in `~/.shell.d`.

## Stow cheat sheet

Run these from the repo root. `.stowrc` supplies `--target=~ --no-folding`, and `.stow-local-ignore` lists repo files that are never linked (`install.sh`, `README.md`, ...).

`--no-folding` means stow never symlinks a whole directory: `~/.config/ghostty` stays a real directory holding one link per tracked file, so files an app writes there stay local instead of landing in the repo.

| Task | Command |
|---|---|
| Preview any change (touches nothing) | add `-n -v`, e.g. `stow -n -v --restow .` |
| Relink everything; remove links to files deleted from the repo | `stow --restow .` |
| Start tracking a file | `mkdir -p .config/foo && mv ~/.config/foo/bar .config/foo/ && stow --restow .` |
| Start tracking a directory | `mkdir -p .config && mv ~/.config/foo .config/ && stow --restow .` (links each file; the directory itself stays real) |
| Take over files that already exist in `~` (e.g. a new machine) | `stow --adopt .` then `git diff` to review: adopt moves the `~` copy into the repo, overwriting the repo's version. `git checkout -- <file>` keeps the repo's version instead. |
| Stop tracking a file but keep a local copy | `cp --remove-destination "$(realpath ~/.foo)" ~/.foo && git rm .foo` |
| Stop tracking a file and delete it | `git rm .foo && stow --restow .` |
| Remove every link (back out of stow) | `stow -D .` |
| See what changed vs. the repo | `git status` / `git diff`: the files in `~` are the repo's files |
| Find broken links under `~` that point into the repo | `find ~ -path ~/Library -prune -o -xtype l -lname '*src/dotfiles*' -print` |

Stow refuses to overwrite a regular file or a symlink it didn't create; the error names the file. Move it aside (or `--adopt` it) and rerun. Some apps save by writing a new file and renaming it over the old one, which replaces the link with a plain file; `git status` then stops showing that app's changes, and `stow --adopt .` relinks it.

## Pre-push checks

`.githooks/pre-push` blocks `git push` when the commits being pushed:

- contain a secret (gitleaks' built-in rules: API keys, tokens, private keys, ...) or a private string from the `private-strings` rule in `.gitleaks.toml` (employer names, work-machine paths), or
- were authored or committed with an email other than `user.email`.

The git config also sets `user.useConfigOnly`, so git refuses to commit without a configured email instead of inventing one like `me@laptop.local`.

Setup, once per clone (`install.sh` does both):

1. `brew install gitleaks` (it's in the `Brewfile`)
2. `git config core.hooksPath .githooks` (a repo-local setting; other repos are unaffected)

| Task | Command |
|---|---|
| Scan the working tree | `gitleaks dir .` |
| Scan all history | `gitleaks git .` |
| Run the hook without pushing | `echo "refs/heads/master $(git rev-parse HEAD) refs/heads/master $(git rev-parse origin/master)" \| .githooks/pre-push` |
| Add a private string | extend `regex` (and `keywords`) of the `private-strings` rule in `.gitleaks.toml` |
| Accept a false positive | add a `gitleaks:allow` comment on that line, or put the finding's fingerprint in `.gitleaksignore` |
| Skip the checks once (avoid) | `git push --no-verify` |

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
