---
description: Web ページの表示確認・スクリーンショット取得・ブラウザ操作・フォーム入力などブラウザ関連タスク
---

# Playwright ブラウザ操作

Web ページの確認やブラウザ操作が必要な場合、Playwright MCP を使用する。

## 利用可能なツール

### 読み取り系（事前許可済み）
- `mcp__Playwright__browser_snapshot` — ページのアクセシビリティスナップショット取得
- `mcp__Playwright__browser_take_screenshot` — ページのスクリーンショット取得
- `mcp__Playwright__browser_console_messages` — コンソールメッセージ取得
- `mcp__Playwright__browser_network_requests` — ネットワークリクエスト一覧
- `mcp__Playwright__browser_tabs` — タブ一覧・操作

### 操作系（都度承認が必要）
- `mcp__Playwright__browser_navigate` — URL に移動
- `mcp__Playwright__browser_click` — 要素クリック
- `mcp__Playwright__browser_type` — テキスト入力
- `mcp__Playwright__browser_fill_form` — フォーム入力
- `mcp__Playwright__browser_select_option` — ドロップダウン選択
- `mcp__Playwright__browser_hover` — ホバー
- `mcp__Playwright__browser_drag` — ドラッグ&ドロップ
- `mcp__Playwright__browser_press_key` — キー入力
- `mcp__Playwright__browser_file_upload` — ファイルアップロード
- `mcp__Playwright__browser_handle_dialog` — ダイアログ処理
- `mcp__Playwright__browser_evaluate` — JavaScript 実行
- `mcp__Playwright__browser_run_code` — Playwright コード実行
- `mcp__Playwright__browser_navigate_back` — ページ戻る
- `mcp__Playwright__browser_wait_for` — テキスト/時間待機
- `mcp__Playwright__browser_resize` — ウィンドウリサイズ
- `mcp__Playwright__browser_close` — ページを閉じる
- `mcp__Playwright__browser_install` — ブラウザインストール

## ワークフロー例

### Web ページの表示確認
1. `browser_navigate` でページに移動
2. `browser_snapshot` でページ構造を確認
3. `browser_take_screenshot` でビジュアル確認

### フォーム操作テスト
1. `browser_navigate` でフォームページに移動
2. `browser_fill_form` でフォームに入力
3. `browser_click` で送信ボタンをクリック
4. `browser_snapshot` で結果を確認

## 使用すべき場面

- Web アプリケーションの動作確認を求められたとき
- ページのスクリーンショットが必要なとき
- フォーム入力やボタン操作のテストを行うとき
- フロントエンドのデバッグでコンソールやネットワークを確認するとき
