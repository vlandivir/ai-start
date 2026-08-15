---
name: ai-start-cursor
description: >-
  Guides a beginner in Cursor through this template so they can program anything
  they want without development experience. Walks them in chat: Vercel account,
  Vercel MCP, then deploys a hello page and pastes the live URL. Use when the
  user is in Cursor and says «запусти мой первый проект», «начнём», «готово»,
  «start my first project», opens this repo to get started, or asks how to
  proceed after cloning the template.
---

# ai-start-cursor

You are walking a person who may not know IT. Use plain language. Do not ask them to run terminal commands themselves. Execute scripts yourself.

This repository is **infrastructure**, not a specific product. The first example to prove the loop is **«кто что несёт на шашлык»** — do not build that app yet. First proof is a hello page on Vercel.

This skill is **Cursor only**. Do not mention Trae, Claude Code, or Codex. Do not ask which editor they use.

The guide is **this chat**. One step per message. Markdown links are fine. Do not open a local HTML page. Do not use canvas or pickers as the only way to talk.

Progress lives in gitignored `.ai-start/state.json`. Read it at the start of a turn if it exists.

Vercel MCP: [references/mcp.md](references/mcp.md).

## Step 0 — verify they own this copy

Assume they launched the skill after creating a GitHub Template copy. Still check before the Vercel step.

Run:

```bash
git remote get-url origin
```

Treat the remote as the **upstream template** (stop) if the URL points at `vlandivir/ai-start` — including `git@github.com:vlandivir/ai-start.git`, `https://github.com/vlandivir/ai-start.git`, and the same URL without `.git`.

If origin is the upstream template:

1. Tell them they opened the original repository, not their copy.
2. Ask them to open https://github.com/vlandivir/ai-start, click **Use this template** → **Create a new repository**, then clone **that** repository and run the skill there.
3. Stop.

If origin is missing or git fails: ask them to open the folder they cloned from their GitHub account, then retry.

If origin is some other GitHub repo (their login in the URL): continue.

If `.ai-start/state.json` already has a `vercel_url`, skip to Step 5.

If Vercel MCP already works (`list_teams` succeeds) and there is no `vercel_url`, skip to Step 4.

If MCP is not ready but they already saw the MCP step, wait for «готово» and go to Step 3.

## Step 1 — Vercel account

In chat, in Russian:

Сайт будет жить в интернете на Vercel — нужен бесплатный аккаунт. Откройте [vercel.com/signup](https://vercel.com/signup), нажмите Continue with GitHub. Когда увидите панель Vercel, напишите **готово**.

Do not register for them.

## Step 2 — after first «готово» (account)

Do **not** ask them to paste a Vercel dashboard URL.

Execute:

```bash
bash .agents/skills/ai-start-cursor/scripts/ensure-vercel-mcp.sh
```

Write `.ai-start/state.json` with `{ "mcp_prompted": true }` (keep other keys).

In chat, in Russian: one-time login so the agent can publish the site. Show this link: [Подключить Vercel в Cursor](cursor://anysphere.cursor-deeplink/mcp/install?name=vercel&config=eyJ1cmwiOiJodHRwczovL21jcC52ZXJjZWwuY29tIn0=). After Cursor confirms, finish login in the browser. When Vercel in MCP is active (not «нужен вход»), write **готово**. Fallback if the link does nothing: Customize → MCP → Needs login.

Do not complete OAuth for them. Do not link GitHub.

## Step 3 — check that MCP works

When they write «готово» after the MCP step (or any «готово» if you have not confirmed MCP yet):

1. Call Vercel MCP `list_teams` (see [references/mcp.md](references/mcp.md)).
2. If the tool is missing or fails: login did not stick. Repeat Step 2 in chat. Ask them to write **готово** again after the server is green.
3. If it returns teams: take the first team's `slug` and `id`. Merge into `.ai-start/state.json`: `vercel_slug`, `vercel_team_id`, `vercel_mcp: true`. Then continue to Step 4 in the same turn.

## Step 4 — deploy the hello page

Do this only if `vercel_url` is not already in state.

1. Run (pass the team slug from `list_teams`):

```bash
bash .agents/skills/ai-start-cursor/scripts/next-project-name.sh <team-slug>
```

Use that exact name (`<slug>-<YYYYMMDDHHMM>-ai-start`). Lowercase, already sanitized by the script.

2. Read [assets/hello.html](assets/hello.html). Deploy it with Vercel MCP `deploy_to_vercel`:
   - `target`: `production`
   - `name`: the script output
   - `teamId`: the team id or slug from `list_teams`
   - `projectSettings.framework`: `null` (static HTML)
   - `files`: one file, path `index.html`, `data` = contents of `hello.html`, encoding `utf-8`

3. From the tool result, take the public URL that ends with `.vercel.app`. Prefer an alias without a random suffix (not a dashboard/inspector URL, not `_vercel_share`).

4. Immediately call `update_project_deployment_protection` with `projectId` = the project name, `teamId` = the team id or slug, and `ssoProtection: { enabled: false }`. New file deploys often require Vercel login otherwise — the hello page must open on a phone without an account.

5. Merge `vercel_url` and `vercel_project` into `.ai-start/state.json`.

6. Continue to Step 5.

Do not create a git-linked project. Do not buy a domain. Do not leave Vercel Authentication on.

## Step 5 — show the live link

In chat, in Russian: the site is on the internet (not on their computer). Paste the public `.vercel.app` URL as a markdown link. One short extra line is enough.

Do not start Supabase or the shashlik app.
