# Supabase MCP

Официальный адрес: `https://mcp.supabase.com/mcp`. Токенов в файлах нет. Вход — OAuth в браузере.

`npx`, personal access token и `project_ref` на этом шаге не использую: иначе пропадут `list_organizations`.

После клона пишу сервер в **проект**: `.cursor/mcp.json` и `.trae/mcp.json`.

```json
{
  "mcpServers": {
    "supabase": {
      "url": "https://mcp.supabase.com/mcp"
    }
  }
}
```

Дописываю тот же блок в JSON тулом записи, не скриптом. `vercel` и другие серверы не трогаю.

## Вход

Cursor: [deeplink](https://cursor.com/docs/mcp/install-links) `cursor://anysphere.cursor-deeplink/mcp/install?name=supabase&config=eyJ1cmwiOiJodHRwczovL21jcC5zdXBhYmFzZS5jb20vbWNwIn0=`. Запасной путь: Customize → MCP → Needs login.

Если deeplink нет: MCP → включить **supabase** на агенте → вход в браузере.

## Проверка

После входа вызываю `list_organizations`. Беру `id` первой организации. Пустой список проектов — нормально. Проект не создаю. URL кабинета и ключи не прошу.

Если OAuth не встаёт после одной повторной попытки — не ставлю случайные пакеты, не прошу токен Supabase, коротко останавливаю шаг с базой. Приложение про шашлык не начинаю.
