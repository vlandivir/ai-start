#!/usr/bin/env bash
set -euo pipefail

path="${1:-}"
name="${2:-}"
url="${3:-}"

if [[ -z "$path" || -z "$name" || -z "$url" ]]; then
  echo "usage: merge-mcp-server.sh <mcp.json-path> <server-name> <url>" >&2
  exit 1
fi

python3 - "$path" "$name" "$url" <<'PY'
import json
import pathlib
import sys

path = pathlib.Path(sys.argv[1])
name = sys.argv[2]
url = sys.argv[3]

if path.exists():
    raw = path.read_text().strip() or "{}"
    data = json.loads(raw)
else:
    data = {}

if not isinstance(data, dict):
    data = {}

servers = data.setdefault("mcpServers", {})
if not isinstance(servers, dict):
    servers = {}
    data["mcpServers"] = servers

entry = servers.get(name)
if isinstance(entry, dict) and entry.get("url") == url:
    print(f"keep {name} in {path}")
else:
    servers[name] = {"url": url}
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2) + "\n")
    print(f"wrote {name} in {path}")
PY
