# Vercel MCP per editor

Official endpoint: `https://mcp.vercel.com`. No API tokens in files. The human must complete OAuth in their editor.

## Config files in this repo

| Editor | File | Notes |
| --- | --- | --- |
| Cursor | `.cursor/mcp.json` | `{ "url": "https://mcp.vercel.com" }` |
| Claude Code | `.mcp.json` | must include `"type": "http"` |
| Codex | `.codex/config.toml` | `[mcp_servers.vercel]` + `url` |

If a file is missing, run `scripts/ensure-vercel-mcp.sh` from the skill (it writes only missing files and does not overwrite extras).

## Login (human)

- **Cursor:** the guide button uses the [install deeplink](https://cursor.com/docs/mcp/install-links) (`cursor://…/mcp/install`). After Cursor confirms, complete OAuth. Fallback: Customize → MCP → Needs login.
- **Claude Code:** no browser install link. `/mcp` → Vercel → Authenticate.
- **Codex:** no browser install link. `/mcp`, or allow the browser window if Codex opened OAuth itself. Project `.codex/config.toml` loads only if the folder is trusted.

## Check

After they write «готово», call an authenticated Vercel MCP tool (`list_teams` or `list_projects`). If those tools are absent, login did not stick — send them back to the guide page and ask them to write «готово» again after the server shows as connected.

Do not create a Vercel project, do not link GitHub, do not collect tokens.
