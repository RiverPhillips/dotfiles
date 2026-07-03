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
- `claude/` — Claude Code global config: `dot-claude/CLAUDE.md`, `dot-claude/settings.json`, plus empty `commands/`, `agents/`, `skills/` dirs for future use.

MCP servers are declared in the tracked `.mcp.json` at the repo root (Claude Code's project-scoped, committable MCP config) — edit it as text, pin versions in the args, commit. Do *not* configure them via `claude mcp add -s user`: that writes into `~/.claude.json`, an untracked live state blob (account identity, machine IDs, project paths, caches) that must never be committed, especially to this public repo.

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
- Prefer editing the tracked config files directly (text edits) over running commands that mutate config in place (e.g. CLI subcommands that rewrite a JSON/TOML file). This repo's value is in having the actual desired config readable and diffable in-tree; a command that reaches out and edits state elsewhere bypasses that. Only fall back to a command when there's no config-file equivalent (e.g. `claude mcp add -s user`, which necessarily writes into the untracked `~/.claude.json`).
