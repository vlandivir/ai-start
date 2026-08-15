#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
path="$root/.trae/mcp.json"

if [[ -e "$path" ]]; then
  echo "keep $path"
  exit 0
fi

mkdir -p "$(dirname "$path")"
printf '%s\n' '{
  "mcpServers": {
    "vercel": {
      "url": "https://mcp.vercel.com"
    }
  }
}' > "$path"
echo "wrote $path"
