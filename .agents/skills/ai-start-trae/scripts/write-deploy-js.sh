#!/usr/bin/env bash
set -euo pipefail

url="${1:-}"
name="${2:-}"
if [[ -z "$url" ]]; then
  echo "usage: write-deploy-js.sh <url> [project-name]" >&2
  exit 1
fi

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"
js="$skill_dir/assets/deploy.js"

python3 - "$js" "$url" "$name" <<'PY'
import json, sys
path, url, name = sys.argv[1], sys.argv[2], sys.argv[3]
payload = {"url": url, "name": name}
with open(path, "w", encoding="utf-8") as f:
    f.write("window.AI_START_DEPLOY = " + json.dumps(payload, ensure_ascii=False) + ";\n")
print(path)
PY
