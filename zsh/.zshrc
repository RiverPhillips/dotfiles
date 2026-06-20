# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"
