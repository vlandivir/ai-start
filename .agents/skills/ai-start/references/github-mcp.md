# GitHub MCP

Официальный адрес: `https://api.githubcopilot.com/mcp/`. Токенов в файлах нет. Вход — OAuth в браузере. PAT я не прошу и в git не кладу.

До клона пишу сервер в **корень открытой папки**: `.trae/mcp.json` и `.cursor/mcp.json`. Список MCP берётся оттуда, не из `~/.trae/mcp.json`. Плюс `~/.cursor/mcp.json`, если есть Cursor.

```json
{
  "mcpServers": {
    "github": {
      "url": "https://api.githubcopilot.com/mcp/"
    }
  }
}
```

Дописываю тот же блок тулом записи. Другие серверы не стираю.

## Вход

Cursor: [deeplink](https://cursor.com/docs/mcp/install-links) `cursor://anysphere.cursor-deeplink/mcp/install?name=github&config=eyJ1cmwiOiJodHRwczovL2FwaS5naXRodWJjb3BpbG90LmNvbS9tY3AvIn0=`. Сервер сразу в списке — остаётся OAuth. Запасной путь: Customize → MCP → Needs login у **github**.

Без deeplink: после записи `.trae/mcp.json` в чате говорю, что **github** уже в списке (настройки → MCP). Нужен только вход в браузере. Если сервера нет: Add → Add Manually и подтвердить JSON из файла.

## Проверка

Сначала смотрю схему тулы. Потом вызываю `get_me` и беру `login`. URL и ключи в чат не прошу.

## Fork

`fork_repository`: `owner=vlandivir`, `repo=ai-start`. Если fork уже есть — клонирую его. Затем `git clone https://github.com/<login>/ai-start.git` в `$HOME/dev/ai-start` или `$HOME/dev/<login>-ai-start`, если папка занята.

Не ставлю случайные MCP-пакеты. Не собираю PAT. Если OAuth не встаёт после одной повторной попытки — коротко говорю, что редактор пока не пускает GitHub MCP, и останавливаюсь.
