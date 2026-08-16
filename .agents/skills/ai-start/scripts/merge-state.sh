#!/usr/bin/env bash
set -euo pipefail

patch="${1:-}"
if [[ -z "$patch" ]]; then
  echo "usage: merge-state.sh '<json-object>'" >&2
  exit 1
fi

home_state="$HOME/.ai-start/state.json"
project_state=""
if root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
  project_state="$root/.ai-start/state.json"
fi

python3 - "$patch" "$home_state" "$project_state" <<'PY'
import json
import pathlib
import sys

patch = json.loads(sys.argv[1])
if not isinstance(patch, dict):
    raise SystemExit("patch must be a JSON object")

paths = [pathlib.Path(sys.argv[2])]
if sys.argv[3]:
    paths.append(pathlib.Path(sys.argv[3]))

for path in paths:
    if path.exists():
        raw = path.read_text().strip() or "{}"
        data = json.loads(raw)
        if not isinstance(data, dict):
            data = {}
    else:
        data = {}
    data.update(patch)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2) + "\n")
    print(f"wrote {path}")
PY
