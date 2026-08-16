# Vercel MCP

Официальный адрес: `https://mcp.vercel.com`. Токенов в файлах нет. Вход — OAuth в браузере.

После клона пишу сервер в **проект**: `.cursor/mcp.json` и `.trae/mcp.json`.

```json
{
  "mcpServers": {
    "vercel": {
      "url": "https://mcp.vercel.com"
    }
  }
}
```

Дописываю тот же блок в JSON тулом записи, не скриптом. Чужие серверы не трогаю.

## Вход

Cursor: [deeplink](https://cursor.com/docs/mcp/install-links) `cursor://anysphere.cursor-deeplink/mcp/install?name=vercel&config=eyJ1cmwiOiJodHRwczovL21jcC52ZXJjZWwuY29tIn0=`. Запасной путь: Customize → MCP → Needs login.

Если deeplink нет: MCP → включить **vercel** на агенте → вход в браузере.

## Команда и деплой

После входа вызываю `list_teams`. Беру у первой команды `slug` и `id`. URL кабинета не прошу.

1. Имя: `<slug>-<YYYYMMDDHHMM>-ai-start` (slug в нижнем регистре, только `a-z0-9-`)
2. `deploy_to_vercel` с `target: production`, этим именем, `teamId`, `projectSettings.framework: null`, и `assets/hello.html` как `index.html`
3. `update_project_deployment_protection` с `ssoProtection: { enabled: false }`, чтобы ссылка открылась без логина Vercel
4. В чат — публичный `.vercel.app`, без `_vercel_share`

`create_git_project` не вызываю. Токены не собираю.

Если OAuth не встаёт после одной повторной попытки — не ставлю случайные пакеты, не прошу Vercel-токен, коротко останавливаю выкладку страницы. Приложение про шашлык не начинаю.
