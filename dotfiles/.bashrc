# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Variables

GREEN="\[$(tput setaf 155)\]"
RESET="\[$(tput sgr0)\]"

# Scripts

_vault_complete() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  local completions="$(vault --cmplt "$word")"
  COMPREPLY=( $(compgen -W "$completions" -- "$word") )
}

# Autocompletions

## complete -f -F _vault_complete vault
shopt -s checkwinsize autocd
source /usr/share/doc/pkgfile/command-not-found.bash

# Exports

export GOPATH="/home/madamek/github/GO"
export VISUAL="vim"
export PS1="${GREEN}[\A \u@\H \W]$ ${RESET}"
