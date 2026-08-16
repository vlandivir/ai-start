# Vercel MCP

URL: `https://mcp.vercel.com`. Токенов в файлах нет. Куда писать и как просить вход: [connect-mcp.md](connect-mcp.md).

После входа вызываю `list_teams`. Беру у первой команды `slug` и `id`. URL кабинета не прошу.

1. Имя: `<slug>-<YYYYMMDDHHMM>-ai-start` (slug в нижнем регистре, только `a-z0-9-`)
2. `deploy_to_vercel` с `target: production`, этим именем, `teamId`, `projectSettings.framework: null`, и `assets/hello.html` как `index.html`
3. `update_project_deployment_protection` с `ssoProtection: { enabled: false }`
4. В чат — публичный `.vercel.app`, без `_vercel_share`

`create_git_project` не вызываю. Токены не собираю. Если OAuth не встаёт после одной повторной попытки — останавливаю выкладку. Шашлык не начинаю.
