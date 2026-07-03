# dotfiles

Personal dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/) and [just](https://github.com/casey/just).

## Packages

| Package    | Provides                                              |
|------------|--------------------------------------------------------|
| `git/`     | `~/.gitconfig`, `~/.gitignore`                          |
| `zsh/`     | `~/.zshrc` and OS-specific fragments (macOS/Linux)       |
| `nvim/`    | Neovim config (lazy.nvim)                             |
| `starship` | `~/.config/starship.toml` prompt config                 |
| `ghostty`  | `~/.config/ghostty/config` terminal config               |

Each directory is a stow package: its contents are symlinked into `$HOME`, mirroring the relative path. Files/directories prefixed `dot-` are expanded to a leading `.` (stow's `--dotfiles` mode), e.g. `git/dot-gitignore` → `~/.gitignore`.

## Usage

Requires `stow` and `just`.

```sh
just dry-run    # preview what would be symlinked, no changes made
just install    # create the symlinks
just restow     # re-link everything (run after adding/moving files in a package)
just uninstall  # remove the symlinks stow created
```

## Machine-specific config

Secrets and machine-local overrides are kept outside this repo, untracked:

- `~/.gitconfig.local` — included from `git/.gitconfig` (e.g. `gpg.ssh.program`)
- `~/.zsh_secrets` — sourced from `zsh/.zshrc` if present
