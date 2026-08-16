#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")" && pwd)"
merge="$skill_dir/merge-mcp-server.sh"
url="https://api.githubcopilot.com/mcp/"

wrote=0
if [[ -d "$HOME/.cursor" ]]; then
  bash "$merge" "$HOME/.cursor/mcp.json" github "$url"
  wrote=1
fi
if [[ -d "$HOME/.trae" ]]; then
  bash "$merge" "$HOME/.trae/mcp.json" github "$url"
  wrote=1
fi

if [[ "$wrote" -eq 0 ]]; then
  bash "$merge" "$HOME/.cursor/mcp.json" github "$url"
fi
