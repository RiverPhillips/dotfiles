# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt extendedglob
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY INC_APPEND_HISTORY
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
# End of lines added by compinstall
#
alias gp='git push'

# OS-specific settings
case "$OSTYPE" in
  darwin*) [ -f ~/.config/zsh/os/darwin.zsh ] && source ~/.config/zsh/os/darwin.zsh ;;
  linux*)  [ -f ~/.config/zsh/os/linux.zsh ]  && source ~/.config/zsh/os/linux.zsh ;;
esac

[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
PATH="$HOME/.local/bin:$GOBIN:$PATH"

unfunction zle-keymap-select 2>/dev/null
eval "$(starship init zsh)"

export EDITOR=nvim
export VISUAL=nvim

source <(fzf --zsh)

export GPG_TTY=$TTY
