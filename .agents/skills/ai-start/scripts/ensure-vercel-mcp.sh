#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")" && pwd)"
merge="$skill_dir/merge-mcp-server.sh"
url="https://mcp.vercel.com"
root="$(git rev-parse --show-toplevel)"

bash "$merge" "$root/.cursor/mcp.json" vercel "$url"
bash "$merge" "$root/.trae/mcp.json" vercel "$url"
