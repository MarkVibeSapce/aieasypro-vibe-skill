#!/usr/bin/env bash
# ติดตั้ง Vibe Coding skills เข้า ~/.claude/skills/ (Mac / Linux)
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/skills" && pwd)"
DEST="$HOME/.claude/skills"

echo "📦 ติดตั้ง Vibe Coding skills"
echo "   จาก: $SRC"
echo "   ไป:  $DEST"
echo

mkdir -p "$DEST"

count=0
for dir in "$SRC"/*/; do
  name="$(basename "$dir")"
  if [ -e "$DEST/$name" ]; then
    echo "   ↻ อัปเดต $name"
    rm -rf "$DEST/$name"
  else
    echo "   + ติดตั้ง $name"
  fi
  cp -R "$dir" "$DEST/$name"
  count=$((count+1))
done

echo
echo "✅ เสร็จ — ติดตั้ง $count skills"
echo "   เปิด Claude Code ใหม่ แล้วพิมพ์ /help เพื่อดู skills ทั้งหมด"
