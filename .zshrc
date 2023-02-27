# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

import() {
  if [ -d $1 ] && [ -r $1 ] && [ -x $1 ]; then
    for file in ${1}/**/*.zsh; do
      [ -r $file ] && source $file
    done
  fi
}
import "${HOME}/.zsh"

# alias
alias g="git"
# compdef g=git
alias d="docker"
alias dc="docker-compose"
alias ll="ls -l"

# コマンドの結果を標準出力しつつクリップボードにもコピーする
# ex) echo 'Hello, World!' | teee
alias teee='tee >(pbcopy)'

# catコマンドの拡張コマンドbatをエイリアスに設定
# https://github.com/sharkdp/bat
alias cat='bat'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source-highlight
export LESS='-R'
export LESSOPEN='| /opt/homebrew/bin/source-highlight-esc.sh %s'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# mysql-client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# lsコマンドの拡張コマンとexaをエイリアスに設定
# https://github.com/ogham/exa
alias ls='exa'

# 履歴保存管理
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
# 他のzshと履歴を共有
setopt inc_append_history
setopt share_history

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview 'bat -n --color=always {}'"
export FZF_CTRL_T_OPTS="--bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --layout=reverse
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# ghqとの連携。ghqの管理化にあるリポジトリを一覧表示する。ctrl+Gにバインド。
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

dce() {
  local cid
  cid=$(docker-compose ps | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" bash
}
dcm() {
  local cid
  cid=$(docker-compose ps | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" python manage.py $1
}
# docker-compose logsにする。複数選択可能にする。
dcl() {
  local cid
  cid=$(docker-compose ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker logs -f --tail=200 "$cid"
}
dcr() {
  local cid
  cid=$(docker-compose ps -a | sed 1d | fzf -m -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && echo $cid | xargs docker restart
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
