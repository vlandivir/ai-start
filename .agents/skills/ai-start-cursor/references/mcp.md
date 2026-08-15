# Vercel MCP in Cursor

Official endpoint: `https://mcp.vercel.com`. No API tokens in files. The human must complete OAuth in Cursor.

## Config

File: `.cursor/mcp.json`

```json
{
  "mcpServers": {
    "vercel": {
      "url": "https://mcp.vercel.com"
    }
  }
}
```

If the file is missing, run `scripts/ensure-vercel-mcp.sh` from the skill (it writes only a missing file and does not overwrite extras).

## Login (human)

The guide button uses the [install deeplink](https://cursor.com/docs/mcp/install-links) (`cursor://…/mcp/install`). After Cursor confirms, complete OAuth. Fallback: Customize → MCP → Needs login.

## Account name

After login, call `list_teams`. Use the first team's `slug` and `id`. Do not ask the user to paste a dashboard URL.

## Deploy

1. `bash scripts/next-project-name.sh <slug>` → `<slug>-<YYYYMMDDHHMM>-ai-start`
2. `deploy_to_vercel` with `target: production`, that name, `teamId`, `projectSettings.framework: null`, and `assets/hello.html` as `index.html`
3. `update_project_deployment_protection` with `ssoProtection: { enabled: false }` so the URL opens without Vercel login
4. `bash scripts/write-deploy-js.sh <public-.vercel.app-url> <project-name>` — no `_vercel_share` token
5. Re-open the guide on step 3

Do not use `create_git_project`. Do not collect tokens.
