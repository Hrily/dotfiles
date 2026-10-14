#!/bin/sh
# Re-injects the ADHD prose rules every turn, so they survive long context and compaction.
# $1 = hook event name. Always exits 0: a broken reminder must cost nothing but a plain answer.
cat >/dev/null 2>&1
DIR=$(dirname "$0")
[ "$(cat "$DIR/../active-style" 2>/dev/null)" = ste ] && exit 0
jq -n --arg e "${1:-UserPromptSubmit}" --rawfile t "$DIR/adhd-reminder.txt" \
  '{hookSpecificOutput:{hookEventName:$e, additionalContext:$t}}' 2>/dev/null
exit 0
