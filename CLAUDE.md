# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## リポジトリ概要

macOS 向けの個人 dotfiles リポジトリ。シンボリックリンクでホームディレクトリに展開して使用する。

## セットアップ

```bash
./install.sh
```

`install.sh` は以下を行う:
- git submodule の初期化・更新
- リポジトリ直下のドットファイル（`.??*`）をすべて `~/` にシンボリックリンク
- Emacs (cask) が存在する場合のみ `.emacs.d` をセットアップ

## ファイル構成と役割

| パス | 役割 |
|------|------|
| `.zshrc` | zsh メイン設定。エイリアス・関数・ツール連携を一括管理 |
| `.zsh/` | zsh 追加設定ファイル置き場。`import` 関数で再帰的に読み込まれる |
| `.zsh/local/` | **gitignore 済み**のマシン固有設定置き場。本番には含めない |
| `.gitconfig` | Git エイリアス・ユーザー設定 |
| `.p10k.zsh` | Powerlevel10k プロンプト設定 |
| `.vimrc` | Vim 最小設定 |
| `iterm2/com.googlecode.iterm2.plist` | iTerm2 設定ファイル |
| `claude/CLAUDE.md` | Claude Code のグローバル指示（`~/.claude/CLAUDE.md` にリンク） |
| `claude/settings.json` | Claude Code の設定・フック（`~/.claude/settings.json` にリンク） |
| `codex/AGENTS.md` | Codex CLI のグローバル指示（`~/.codex/AGENTS.md` にリンク） |
| `codex/config.toml` | Codex CLI の設定・通知（`~/.codex/config.toml` にリンク） |
| `codex/notify.sh` | Codex CLI の通知スクリプト（`~/.codex/notify.sh` にリンク） |

## .zshrc のアーキテクチャ

- **ツール連携**: nvm（Node.js バージョン管理）、pyenv（Python）、bun、ghq（リポジトリ管理）、fzf（インタラクティブフィルタ）
- **カスタム関数**:
  - `ghq-fzf` (Ctrl+G): ghq 管理リポジトリを fzf で選択して cd
  - `open-intellij-with-ghq-fzf` (alias: `i`): ghq リポジトリを IntelliJ IDEA で開く
  - `docker-compose-exec/logs/up-d/restart` (alias: `de`/`dl`/`du`/`dr`): Docker Compose サービスを fzf で選択して操作

## マシン固有設定の追加方法

`.zsh/local/` 以下に `.zsh` ファイルを作成する（gitignore されているため、リポジトリには含まれない）。

```bash
# 例: ~/.zsh/local/work.zsh
export WORK_API_KEY="..."
```

## 変更時の注意点

- `.zshrc` を変更したら `source ~/.zshrc` で即時反映できる
- `iterm2/com.googlecode.iterm2.plist` はバイナリに近いため、差分は iTerm2 の設定 UI 経由で変更してから `git diff` で確認する
- `.zsh/local/` の内容はコミットしない（gitignore 設定済み）
