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
| `claude/`  | `~/.claude/settings.json`, `~/.claude/CLAUDE.md` (+ empty `commands/`, `agents/`, `skills/` dirs) |

Each directory is a stow package: its contents are symlinked into `$HOME`, mirroring the relative path. Files/directories prefixed `dot-` are expanded to a leading `.` (stow's `--dotfiles` mode), e.g. `git/dot-gitignore` → `~/.gitignore`.

## Usage

Requires `stow` and `just`.

```sh
just dry-run    # preview what would be symlinked, no changes made
just install    # create the symlinks
just restow     # re-link everything (run after adding/moving files in a package)
just uninstall  # remove the symlinks stow created
```

## Claude Code MCP servers

MCP servers are declared in the tracked `.mcp.json` at the repo root — Claude Code's project-scoped,
version-controlled MCP config. Edit it as plain text (add/remove servers, bump pinned versions) and
commit; it holds only server definitions, no secrets or state. On first use in the repo Claude Code
prompts once to approve the servers. Pin versions in the args, e.g.
`"args": ["--from", "mcp-server-git==<version>", "mcp-server-git"]`.

This is deliberately *not* configured via `claude mcp add -s user`, which writes into `~/.claude.json`
— an untracked live state blob holding account identity, machine IDs, and caches (never commit it,
especially to a public repo). To use these servers in another repo, add a `.mcp.json` there too.

## Machine-specific config

Secrets and machine-local overrides are kept outside this repo, untracked:

- `~/.gitconfig.local` — included from `git/.gitconfig` (e.g. `gpg.ssh.program`)
- `~/.zsh_secrets` — sourced from `zsh/.zshrc` if present
