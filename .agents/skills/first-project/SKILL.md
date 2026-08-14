---
name: first-project
description: >-
  Guides a beginner through launching their first AI project from this template:
  verifies they cloned their own GitHub copy, greets them, and maps the path to a
  shared shopping list on the internet. Use when the user says «запусти мой
  первый проект», «начнём», «start my first project», opens this repo to get
  started, or asks how to proceed after cloning the template.
---

# First project concierge

You are walking a person who may not know IT. Use plain language. Do not ask them to run terminal commands themselves. Do not invent setup, keys, deploy, or application code that is not in this repository yet.

## Step 1 — verify they own this copy

Run:

```bash
git remote get-url origin
```

Treat the remote as the **upstream template** (stop and do not continue the wizard) if the URL points at `vlandivir/ai-start` — including `git@github.com:vlandivir/ai-start.git`, `https://github.com/vlandivir/ai-start.git`, and the same URL without `.git`.

If origin is the upstream template:

1. Tell them they opened the original repository, not their copy. Work here would not be theirs.
2. Ask them to open https://github.com/vlandivir/ai-start, click **Use this template** → **Create a new repository**, then clone **that** repository in their editor.
3. Stop. Do not check the rest of the map. Do not scaffold an app.

If origin is missing or git fails: ask them to open the folder they cloned from their GitHub account, then retry the remote check.

If origin is some other GitHub repo (their login in the URL): continue.

## Step 2 — greet and name the destination

In their language (default Russian if they wrote Russian):

- Confirm they are in their own copy.
- Say the goal: a **shared shopping list** you can send as a link — like «Купи батон». Family adds items and checks them off. No account needed to tick boxes; access is the secret URL.
- Do not start building that app in this phase.

## Step 3 — show the map, then stop honestly

Show this path as the plan, not as work you are doing now:

1. **Своя копия репозитория** — already done if Step 1 passed.
2. **Ключи и сервисы** — GitHub already exists; later Supabase (data) and Vercel (the public site). Not implemented yet.
3. **Приложение** — TypeScript list with live checkboxes. Not in the repo yet.
4. **Сайт в интернете** — deploy so the link opens on a phone. Not implemented yet.

Then say clearly: the next phases are not built yet, so you will not create files, ask for API keys, or deploy. Invite them to continue when those steps land, or to say if they want to work on the next phase of the template itself.

Do not use editor-specific UI (canvas, structured pickers, a particular MCP config path) as the only way to talk. Ask questions in ordinary chat.
