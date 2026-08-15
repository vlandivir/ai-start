# Vercel MCP in Trae

Official endpoint: `https://mcp.vercel.com`. No API tokens in files. The human must complete OAuth in Trae if Trae offers it.

Trae is often **not** on Vercel’s approved MCP client list. Official OAuth may fail. Try it first.

## Config

File: `.trae/mcp.json` (Trae loads this from the project root).

```json
{
  "mcpServers": {
    "vercel": {
      "url": "https://mcp.vercel.com"
    }
  }
}
```

If the file is missing, run `scripts/ensure-vercel-mcp.sh` (writes only a missing file).

Human steps: Trae → MCP → enable **vercel** on the built-in Agent → browser login if asked.

## Account name

After login, call `list_teams`. Use the first team's `slug` and `id`. Do not ask the user to paste a dashboard URL.

## If OAuth never starts

If the user writes «не вошло» or `list_teams` is still missing after one retry: Vercel is blocking this editor. Do not install random MCP packages. Do not collect a Vercel token. In chat, one short line: Trae пока не может подключить Vercel MCP; петлю с выкладкой страницы здесь останавливаем. Stop. Do not start the shashlik app.

## Deploy

1. `bash scripts/next-project-name.sh <slug>` → `<slug>-<YYYYMMDDHHMM>-ai-start`
2. `deploy_to_vercel` with `target: production`, that name, `teamId`, `projectSettings.framework: null`, and `assets/hello.html` as `index.html`
3. `update_project_deployment_protection` with `ssoProtection: { enabled: false }` so the URL opens without Vercel login
4. `bash scripts/write-deploy-js.sh <public-.vercel.app-url> <project-name>` — no `_vercel_share` token
5. Re-open the guide on step 3

Do not use `create_git_project`. Do not collect tokens.
