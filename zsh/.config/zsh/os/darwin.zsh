# macOS-specific settings (sourced from ~/.zshrc when $OSTYPE is darwin*)

PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export CLANG_FORMAT=/opt/homebrew/opt/llvm/bin/clang-format

[ -s "/Users/river/.bun/_bun" ] && source "/Users/river/.bun/_bun"

PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

alias terraform=tofu
