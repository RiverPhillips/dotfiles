# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/), targeting macOS and Linux. Each top-level directory is a "stow package" whose contents get symlinked into `$HOME`, preserving the relative path structure. Files/dirs prefixed `dot-` are expanded to a leading `.` by stow's `--dotfiles` mode (e.g. `git/dot-gitignore` → `~/.gitignore`).

Packages:
- `git/` — `.gitconfig` and `dot-gitignore` (→ `~/.gitignore`)
- `zsh/` — `.zshrc` plus OS-specific fragments in `.config/zsh/os/{darwin,linux}.zsh`
- `nvim/` — Neovim config (lazy.nvim-based, plugin specs consolidated in `.config/nvim/lua/plugins.lua`)
- `starship/` — `.config/starship.toml` prompt config
- `ghostty/` — `.config/ghostty/config` terminal config

## Commands

All via `just` (see `justfile`):

```
just dry-run    # stow -nv --dotfiles -t ~  — preview what would be symlinked, no changes made
just install    # stow -v  --dotfiles -t ~  — create the symlinks
just uninstall  # stow -Dv --dotfiles -t ~  — remove the symlinks stow created
just restow     # stow -Rv --dotfiles -t ~  — re-link everything (run after adding/moving files in a package)
```

There is no build, lint, or test suite — this repo is config files. Always run `just dry-run` before `just install`/`just restow` when changing package contents, to confirm the resulting symlink targets are what's expected.

## Conventions

- New packages must follow the stow layout: mirror the path relative to `$HOME`, and use the `dot-` prefix for dotfiles/dirs at the package root (stow's `--dotfiles` flag, always used here) rather than a literal leading `.` in-tree.
- Machine-specific or secret config is kept *outside* this repo and pulled in via includes, not committed:
  - `~/.gitconfig.local` (untracked) is included from `git/.gitconfig` for machine-specific overrides like `gpg.ssh.program`.
  - `~/.zsh_secrets` (untracked) is sourced from `zsh/.zshrc` if present.
- OS-specific zsh behavior is split into `zsh/.config/zsh/os/darwin.zsh` and `linux.zsh`, sourced conditionally from `.zshrc` based on `$OSTYPE`.
