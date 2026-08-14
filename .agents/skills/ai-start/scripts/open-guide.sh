#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"
page="$skill_dir/assets/index.html"

if [[ ! -f "$page" ]]; then
  echo "Guide page not found: $page" >&2
  exit 1
fi

if command -v open >/dev/null 2>&1; then
  open "$page"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$page"
elif command -v cygstart >/dev/null 2>&1; then
  cygstart "$page"
else
  echo "$page"
  exit 0
fi
