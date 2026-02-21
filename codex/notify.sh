#!/bin/bash

# Codex CLI の通知イベントに応じて terminal-notifier で通知を送る
# notify 設定から呼び出され、JSON ペイロードを引数として受け取る

ICON="$HOME/.codex/icon.icns"
JSON_PAYLOAD="${1:-}"

if [ -z "$JSON_PAYLOAD" ]; then
    exit 0
fi

# JSON から type フィールドを抽出
EVENT_TYPE=$(echo "$JSON_PAYLOAD" | python3 -c "import sys, json; print(json.load(sys.stdin).get('type', ''))" 2>/dev/null)
PROJECT_NAME=$(echo "$JSON_PAYLOAD" | python3 -c "import sys, json, os; print(os.path.basename(json.load(sys.stdin).get('cwd') or ''))" 2>/dev/null)
if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME="unknown"
fi

case "$EVENT_TYPE" in
    "approval-requested")
        terminal-notifier \
            -title 'Codex CLI' \
            -subtitle "in $PROJECT_NAME" \
            -message '🔔 質問したので入力してください' \
            -sound 'Funk' \
            -contentImage "$ICON"
        ;;
    "agent-turn-complete")
        terminal-notifier \
            -title 'Codex CLI' \
            -subtitle "in $PROJECT_NAME" \
            -message '✅ 処理が完了しました' \
            -sound 'Bottle' \
            -contentImage "$ICON"
        ;;
esac
