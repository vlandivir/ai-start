# Куда я пишу MCP

Один URL на сервер, без токенов в файлах. Вход — OAuth в браузере. PAT не прошу.

Я смотрю, **этот** агент какой конфиг реально читает, и пишу **только туда**. Чужие форматы не пложу. Редактор не спрашиваю. В чате другие редакторы не называю.

## Как понять, куда

Признаки по очереди (первый совпавший):

1. Есть `move_agent_to_root` или живут ссылки `cursor://` — Cursor: JSON `mcpServers` в `.cursor/mcp.json` открытой папки и в `~/.cursor/mcp.json`. В чате могу дать deeplink.
2. Есть `.codex/config.toml` или команда `codex` — Codex: TOML в `.codex/config.toml` открытой папки и/или `~/.codex/config.toml`. Если умею — `codex mcp add <name> --url "<url>"`, вход `codex mcp login <name>` (браузер). Иначе только файл, в чате: открой MCP и войди.
3. Есть `.mcp.json` или команда `claude` — Claude Code: JSON с `"type": "http"` в `.mcp.json` открытой папки. Если умею — `claude mcp add`. В чате: MCP → Authenticate / войти в браузере.
4. Иначе (часто Trae): JSON `mcpServers` в `.trae/mcp.json` **корня открытой папки** (не `~/.trae/mcp.json` — список его часто не видит). В чате: настройки → MCP, сервер уже в списке, только вход. Если нет в списке: Add → Add Manually по файлу.

Если ни один признак не ясен: пишу тот MCP-файл, который уже лежит в открытой папке.

Другие серверы в файле не стираю.

## Форматы

JSON (Cursor / Trae), url как в шаге:

```json
{
  "mcpServers": {
    "ИМЯ": {
      "url": "URL"
    }
  }
}
```

JSON (Claude Code):

```json
{
  "mcpServers": {
    "ИМЯ": {
      "type": "http",
      "url": "URL"
    }
  }
}
```

TOML (Codex):

```toml
[mcp_servers.ИМЯ]
url = "URL"
```

## Deeplink только если этот редактор его открывает

- github: `cursor://anysphere.cursor-deeplink/mcp/install?name=github&config=eyJ1cmwiOiJodHRwczovL2FwaS5naXRodWJjb3BpbG90LmNvbS9tY3AvIn0=`
- vercel: `cursor://anysphere.cursor-deeplink/mcp/install?name=vercel&config=eyJ1cmwiOiJodHRwczovL21jcC52ZXJjZWwuY29tIn0=`
- supabase: `cursor://anysphere.cursor-deeplink/mcp/install?name=supabase&config=eyJ1cmwiOiJodHRwczovL21jcC5zdXBhYmFzZS5jb20vbWNwIn0=`

## В чате человеку

Одна мысль: я уже добавил **имя**. Войди в браузере. Когда сервер живой (зелёный, не «нужен вход») — **готово**. Если окна входа не было — **не вошло**.

Не прошу собирать JSON руками, если файл уже записал. Не прошу терминал.

## URL

| Имя | URL |
| --- | --- |
| github | `https://api.githubcopilot.com/mcp/` |
| vercel | `https://mcp.vercel.com` |
| supabase | `https://mcp.supabase.com/mcp` |
