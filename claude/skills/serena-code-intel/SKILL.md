---
description: コードベースの構造理解・シンボル検索・参照解析・パターン検索などコード解析タスク
---

# Serena コード解析

コードベースの構造理解やシンボル操作が必要な場合、Serena MCP を使用する。

## 利用可能なツール

### 読み取り系（事前許可済み）
- `mcp__serena__list_dir` — ディレクトリ内容の一覧
- `mcp__serena__find_file` — ファイルマスクによるファイル検索
- `mcp__serena__search_for_pattern` — 正規表現によるコード検索
- `mcp__serena__get_symbols_overview` — ファイル内シンボルの概要取得
- `mcp__serena__find_symbol` — シンボル名パスによるシンボル検索
- `mcp__serena__find_referencing_symbols` — シンボルへの参照検索
- `mcp__serena__list_memories` — 保存済みメモリの一覧
- `mcp__serena__read_memory` — メモリ内容の読み取り
- `mcp__serena__check_onboarding_performed` — オンボーディング状態の確認
- `mcp__serena__initial_instructions` — Serena 操作マニュアル取得

### 書き込み系（都度承認が必要）
- `mcp__serena__replace_content` — ファイル内容の置換
- `mcp__serena__replace_symbol_body` — シンボル本体の置換
- `mcp__serena__insert_after_symbol` — シンボル後にコード挿入
- `mcp__serena__insert_before_symbol` — シンボル前にコード挿入
- `mcp__serena__rename_symbol` — シンボルのリネーム（コードベース全体）
- `mcp__serena__write_memory` — メモリの書き込み
- `mcp__serena__edit_memory` — メモリの編集
- `mcp__serena__delete_memory` — メモリの削除
- `mcp__serena__onboarding` — オンボーディング実行

## ワークフロー例

### コード構造の理解
1. `list_dir` でプロジェクト構造を把握
2. `get_symbols_overview` で主要ファイルのシンボル構成を確認
3. `find_symbol` で特定のクラス・メソッドの詳細を取得

### シンボルの影響範囲調査
1. `find_symbol` で対象シンボルを特定
2. `find_referencing_symbols` で参照元を洗い出す
3. 必要に応じて `search_for_pattern` で補完的に検索

## 使用すべき場面

- コードベースの構造や依存関係を理解する必要があるとき
- クラス・メソッド・変数の定義や参照を探すとき
- リファクタリングの影響範囲を調査するとき
- コード内のパターンを横断的に検索するとき
