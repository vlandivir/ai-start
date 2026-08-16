# GitHub MCP

Официальный адрес: `https://api.githubcopilot.com/mcp/`. Токенов в файлах нет. Вход — OAuth в браузере. PAT я не прошу и в git не кладу.

До клона проекта пишу сервер в **глобальный** конфиг редактора: `~/.cursor/mcp.json` или `~/.trae/mcp.json`.

```json
{
  "mcpServers": {
    "github": {
      "url": "https://api.githubcopilot.com/mcp/"
    }
  }
}
```

Дописываю тот же блок в JSON тулом записи, не скриптом и не через `chmod`. Другие серверы не стираю.

## Вход

Cursor: [deeplink](https://cursor.com/docs/mcp/install-links) `cursor://anysphere.cursor-deeplink/mcp/install?name=github&config=eyJ1cmwiOiJodHRwczovL2FwaS5naXRodWJjb3BpbG90LmNvbS9tY3AvIn0=`. Запасной путь: Customize → MCP → Needs login.

Если deeplink нет: MCP в настройках → включить **github** на агенте → вход в браузере.

## Проверка

Сначала смотрю схему тулы. Потом вызываю `get_me` и беру `login`. URL и ключи в чат не прошу.

## Fork

`fork_repository`: `owner=vlandivir`, `repo=ai-start`. Если fork уже есть — клонирую его. Затем `git clone https://github.com/<login>/ai-start.git` в `$HOME/dev/ai-start` или `$HOME/dev/<login>-ai-start`, если папка занята.

Не ставлю случайные MCP-пакеты. Не собираю PAT. Если OAuth не встаёт после одной повторной попытки — коротко говорю, что редактор пока не пускает GitHub MCP, и останавливаюсь.
