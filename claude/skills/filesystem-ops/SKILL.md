---
description: ファイル読み取り・ディレクトリ一覧・ファイル情報取得・ファイル検索などファイルシステム操作タスク
---

# ファイルシステム操作

ファイルやディレクトリの操作が必要な場合、Filesystem MCP を使用する。

## 利用可能なツール

### 読み取り系（事前許可済み）
- `mcp__filesystem__read_file` — ファイル内容の読み取り
- `mcp__filesystem__read_multiple_files` — 複数ファイルの一括読み取り
- `mcp__filesystem__list_directory` — ディレクトリ内容の一覧
- `mcp__filesystem__directory_tree` — ディレクトリツリー表示
- `mcp__filesystem__search_files` — ファイル検索
- `mcp__filesystem__get_file_info` — ファイルメタ情報取得
- `mcp__filesystem__list_allowed_directories` — アクセス可能ディレクトリ一覧

### 書き込み系（都度承認が必要）
- `mcp__filesystem__write_file` — ファイル書き込み
- `mcp__filesystem__edit_file` — ファイル編集
- `mcp__filesystem__create_directory` — ディレクトリ作成
- `mcp__filesystem__move_file` — ファイル移動・リネーム

## ワークフロー例

### ファイル内容の確認
1. `list_directory` でディレクトリ構造を把握
2. `read_file` または `read_multiple_files` で必要なファイルを読み取り

### プロジェクト全体構造の把握
1. `list_allowed_directories` でアクセス可能な範囲を確認
2. `directory_tree` でプロジェクト構造を俯瞰
3. `search_files` で特定のファイルを検索

## 使用すべき場面

- ファイルの内容確認やディレクトリ構造の把握が必要なとき
- 複数ファイルを一括で読み取りたいとき
- ファイルの作成・編集・移動が必要なとき
