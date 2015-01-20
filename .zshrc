#
# ~/.zshrc
#
 
# prompt
#autoload -U colors
#colors
PROMPT='[%n@%m]# '
RPROMPT='[%d]'

 
# completion
autoload -Uz colors
colors

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
 
# alias
alias ls='ls -G --color=auto'
#alias ll='ls -lF'
alias ll='ls -all'
alias la='ls -A'
alias l='ls -CF'
#alias rm='rm -f -r'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias -g G='| grep'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sort'
alias -g W='| wc'
alias -g X='| xargs'
alias tsp='tmux new-session \; split-window -h -d'
alias tvsp='tmux new-session \; split-window -d'

# Python
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
