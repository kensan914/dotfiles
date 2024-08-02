# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
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
alias la="ls -al"

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
export FZF_CTRL_R_OPTS=$(cat <<"EOF"
--height 60%
--preview '
  echo {} \
  | awk "{ sub(/\s*[0-9]*?\s*/, \"\"); gsub(/\\\\n/, \"\\n\"); print }" \
  | bat --color=always --language=sh --style=plain
'
--preview-window 'down,40%,wrap'
EOF
)

# ghqとの連携。ghqの管理化にあるリポジトリを一覧表示する。ctrl+Gにバインド。
function ghq-fzf() {
  local src=$(ghq list | fzf --header 'cd ${Any GihHub Repository}!!!' --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

# ghqで管理しているリポジトリをIntelliJ IDEAで開く。ctrl+Iにバインド。
function open-intellij-with-ghq-fzf() {
  local src=$(ghq list | fzf --header 'open IntelliJ IDEA ${Any GihHub Repository}!!!' --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="idea $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N open-intellij-with-ghq-fzf
bindkey '^i' open-intellij-with-ghq-fzf

docker-exec() {
  local cid
  cid=$(docker ps --format 'table {{ .Names }}\t{{ .Status }}\t{{ .ID }}' | fzf --header-lines=1 --select-1 --preview-window hidden -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker exec -it "$cid" bash
}
alias de="docker-exec"
docker-test() {
  local file
  file=$(fzf -q "$1" | awk '{print $1}')
  docker exec -it fullfii_app python -m pytest "$file"
  print -s "docker exec -it fullfii_app python -m pytest $file"
}
alias dt="docker-test"
docker-logs() {
  local cid
  cid=$(docker ps --format 'table {{ .Names }}\t{{ .Status }}\t{{ .ID }}' | fzf --header-lines=1 --select-1 --preview-window hidden -q "$1" | awk '{print $1}')
  [ -n "$cid" ] && docker logs -f --tail=200 "$cid"
}
alias dl="docker-logs"
docker-restart() {
  local cid
  cid=$(docker ps --format 'table {{ .Names }}\t{{ .Status }}\t{{ .ID }}' | fzf --header-lines=1 --select-1 --preview-window hidden -m --header '[multi select mode]: TAB or SHIFT+TAB' -q "$1" | awk '{print $1}')
  revolver --style 'bouncingBall' start '  restarting...'
  [ -n "$cid" ] && xargs docker restart <<< $cid && echo $cid has been restarted!!
  revolver stop
}
alias dr="docker-restart"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export REACT_EDITOR="code"

# NOTE: https://github.com/nvm-sh/nvm?tab=readme-ov-file#zsh
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# HACK: fig→codewhisperer移行に伴いfig pluginが使えなくなったので暫定対応↓
[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"
# bun completions
[ -s "/Users/toriumik/.bun/_bun" ] && source "/Users/toriumik/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
