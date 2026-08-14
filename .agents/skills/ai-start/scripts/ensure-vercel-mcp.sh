#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"

write_if_missing() {
  local path="$1"
  local body="$2"
  if [[ -e "$path" ]]; then
    echo "keep $path"
    return
  fi
  mkdir -p "$(dirname "$path")"
  printf '%s\n' "$body" > "$path"
  echo "wrote $path"
}

write_if_missing "$root/.cursor/mcp.json" '{
  "mcpServers": {
    "vercel": {
      "url": "https://mcp.vercel.com"
    }
  }
}'

write_if_missing "$root/.mcp.json" '{
  "mcpServers": {
    "vercel": {
      "type": "http",
      "url": "https://mcp.vercel.com"
    }
  }
}'

write_if_missing "$root/.codex/config.toml" '# Project MCP config for Codex. No secrets — login happens in the editor via OAuth.

[mcp_servers.vercel]
url = "https://mcp.vercel.com"'
