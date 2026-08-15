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

## Account name

After login, call `list_teams`. Use the first team's `slug` and `id`. Do not ask the user to paste a dashboard URL.

## Deploy

1. `bash scripts/next-project-name.sh <slug>` → `<slug>-<YYYYMMDDHHMM>-ai-start`
2. `deploy_to_vercel` with `target: production`, that name, `teamId`, `projectSettings.framework: null`, and `assets/hello.html` as `index.html`
3. `update_project_deployment_protection` with `ssoProtection: { enabled: false }` so the URL opens without Vercel login
4. `bash scripts/write-deploy-js.sh <public-.vercel.app-url> <project-name>` — no `_vercel_share` token
5. Re-open the guide on step 3

Do not use `create_git_project`. Do not collect tokens.
