# CLAUDE.md

## Tool usage

Prefer an MCP tool over an equivalent shell command when one exists for the task. Use shell when no MCP fits (the common case).

### Configured MCPs

The following MCP servers are configured and should be preferred:

* Git
  * `mcp__git__git_status`
  * `mcp__git__git_diff_unstaged`
  * `mcp__git__git_diff_staged`
  * `mcp__git__git_diff`
  * `mcp__git__git_commit`
  * `mcp__git__git_add`
  * `mcp__git__git_reset`
  * `mcp__git__git_log`
  * `mcp__git__git_create_branch`
  * `mcp__git__git_checkout`
  * `mcp__git__git_show`
  * `mcp__git__git_branch`

### Code Navigation

Prefer the LSP over grep for navigating code by symbol — go-to-definition,
find-references, and listing symbols. It's precise and returns only the
relevant locations, where grep floods context with text matches and misses
semantic links (a call vs. a definition vs. a string in a comment).

Reach for grep/ripgrep when there's no symbol to anchor on: literal text or
string search, comments, config and non-code files, and the initial discovery
pass before you know what you're navigating to. Grep is the fallback when no
language server is available for the file.
