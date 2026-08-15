#!/usr/bin/env bash
set -euo pipefail

slug="${1:-}"
if [[ -z "$slug" ]]; then
  echo "usage: next-project-name.sh <team-slug>" >&2
  exit 1
fi

slug="$(printf '%s' "$slug" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9-' '-')"
slug="${slug#-}"
slug="${slug%-}"
while [[ "$slug" == *--* ]]; do
  slug="${slug//--/-}"
done

if [[ -z "$slug" ]]; then
  echo "invalid team slug" >&2
  exit 1
fi

echo "${slug}-$(date +%Y%m%d%H%M)-ai-start"
