#!/bin/bash

ICON="$HOME/.claude/icon.icns"
INPUT=$(cat)

if [ -z "$INPUT" ]; then
    exit 0
fi

PROJECT_NAME=$(echo "$INPUT" | jq -r '.cwd // empty' | xargs basename 2>/dev/null)
if [ -z "$PROJECT_NAME" ]; then
    PROJECT_NAME="unknown"
fi

HOOK_EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')

case "$HOOK_EVENT" in
    "Notification")
        terminal-notifier \
            -title 'Claude Code' \
            -subtitle "in $PROJECT_NAME" \
            -message '🔔 ユーザの操作が必要です' \
            -sound 'Funk' \
            -contentImage "$ICON"
        ;;
    "Stop")
        terminal-notifier \
            -title 'Claude Code' \
            -subtitle "in $PROJECT_NAME" \
            -message '✅ 処理が完了しました' \
            -sound 'Bottle' \
            -contentImage "$ICON"
        ;;
esac

exit 0
