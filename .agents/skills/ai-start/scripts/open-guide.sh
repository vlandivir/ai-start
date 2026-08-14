#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"
page="$skill_dir/assets/index.html"
step="${1:-0}"

if [[ ! -f "$page" ]]; then
  echo "Guide page not found: $page" >&2
  exit 1
fi

url="file://${page}#step-${step}"

if command -v open >/dev/null 2>&1; then
  open "$url"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$url"
elif command -v cygstart >/dev/null 2>&1; then
  cygstart "$url"
else
  echo "$url"
  exit 0
fi
