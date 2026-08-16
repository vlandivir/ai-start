# GitHub MCP

URL: `https://api.githubcopilot.com/mcp/`. Токенов в файлах нет. Куда писать и как просить вход: [connect-mcp.md](connect-mcp.md).

Проверка: схема тулы, затем `get_me`, беру `login`. URL кабинета и ключи не прошу.

Fork: `fork_repository` `owner=vlandivir` `repo=ai-start`. Если fork уже есть — клонирую его в `$HOME/dev/ai-start` или `$HOME/dev/<login>-ai-start`.

Случайные MCP-пакеты не ставлю. PAT не собираю. Если OAuth не встаёт после одной повторной попытки — коротко останавливаюсь.
