---
description: Issue・PR・リポジトリ検索・ブランチ操作など GitHub 関連タスク
---

# GitHub 操作

GitHub 上のリソース操作が必要な場合、GitHub MCP を使用する。

## 利用可能なツール

### 読み取り系（事前許可済み）
- `mcp__github__search_repositories` — リポジトリ検索
- `mcp__github__get_file_contents` — ファイル内容取得
- `mcp__github__list_commits` — コミット一覧
- `mcp__github__list_issues` / `mcp__github__get_issue` — Issue 一覧・詳細
- `mcp__github__search_code` — コード検索
- `mcp__github__search_issues` — Issue/PR 横断検索
- `mcp__github__search_users` — ユーザー検索
- `mcp__github__list_pull_requests` / `mcp__github__get_pull_request` — PR 一覧・詳細
- `mcp__github__get_pull_request_files` — PR 変更ファイル一覧
- `mcp__github__get_pull_request_status` — PR ステータスチェック
- `mcp__github__get_pull_request_reviews` — PR レビュー一覧
- `mcp__github__get_pull_request_comments` — PR コメント一覧

### 書き込み系（都度承認が必要）
- `mcp__github__create_issue` — Issue 作成
- `mcp__github__update_issue` — Issue 更新
- `mcp__github__create_pull_request` — PR 作成
- `mcp__github__merge_pull_request` — PR マージ
- `mcp__github__create_branch` — ブランチ作成
- `mcp__github__create_or_update_file` — ファイル作成・更新
- `mcp__github__push_files` — ファイル一括プッシュ
- `mcp__github__fork_repository` — リポジトリフォーク

## ワークフロー例

### Issue 確認
1. `list_issues` で対象リポジトリの Issue 一覧を取得
2. `get_issue` で詳細を確認
3. 必要に応じて `add_issue_comment` でコメント

### PR レビュー
1. `get_pull_request` で PR 概要を確認
2. `get_pull_request_files` で変更ファイルを確認
3. `get_pull_request_comments` / `get_pull_request_reviews` で既存レビューを確認
4. `create_pull_request_review` でレビューを投稿

## 使用すべき場面

- Issue や PR の情報を聞かれたとき
- リポジトリやコードの検索を依頼されたとき
- PR のレビューやステータス確認を求められたとき
- GitHub 上のリソースを作成・更新する操作を依頼されたとき
