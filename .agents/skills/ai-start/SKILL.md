---
name: ai-start
description: >-
  Guides a beginner through this template so they can program anything they want
  without development experience. Opens a local HTML guide, verifies each step:
  Vercel account, then Vercel MCP login in Cursor, Claude Code, or Codex. Use
  when the user says «запусти мой первый проект», «начнём», «готово», «start my
  first project», opens this repo to get started, or asks how to proceed after
  cloning the template.
---

# ai-start

You are walking a person who may not know IT. Use plain language. Do not ask them to run terminal commands themselves. Execute scripts yourself.

This repository is **infrastructure**, not a specific product. The first example to prove the loop is **«кто что несёт на шашлык»** — do not build that app until the guide reaches that phase.

The guide UI is **one local HTML page** (no backend): [assets/index.html](assets/index.html). Step 0 is the editor (Cursor by default); later steps show copy only for that editor. Re-open with `open-guide.sh <n>` so `#step-n` is highlighted. Keep chat short: do not paste the page copy. Do not ask which editor they use — that lives on the page.

Progress lives in gitignored `.ai-start/state.json`. Read it at the start of a turn if it exists.

Editor-specific MCP files: [references/mcp.md](references/mcp.md).

## Step 0 — verify they own this copy

Assume they launched the skill after creating a GitHub Template copy. Still check before opening the guide.

Run:

```bash
git remote get-url origin
```

Treat the remote as the **upstream template** (stop, do not open the guide) if the URL points at `vlandivir/ai-start` — including `git@github.com:vlandivir/ai-start.git`, `https://github.com/vlandivir/ai-start.git`, and the same URL without `.git`.

If origin is the upstream template:

1. Tell them they opened the original repository, not their copy.
2. Ask them to open https://github.com/vlandivir/ai-start, click **Use this template** → **Create a new repository**, then clone **that** repository and run the skill there.
3. Stop.

If origin is missing or git fails: ask them to open the folder they cloned from their GitHub account, then retry.

If origin is some other GitHub repo (their login in the URL): continue.

If `.ai-start/state.json` already has `vercel_mcp: true`, say Vercel is already connected and stop: the next guide step is not written yet.

If it has `vercel_slug` but not MCP, skip to Step 3.

## Step 1 — open the guide

Execute:

```bash
bash .agents/skills/ai-start/scripts/open-guide.sh 0
```

The page starts at editor choice (Cursor is already selected). In chat, one short line: the page opened; after Vercel (step 1) they should write **готово**.

Do not register for them.

## Step 2 — check the Vercel account

When they write «готово» and there is not yet a `vercel_slug` in state:

1. Ask them to copy the address from the browser after they reached the Vercel dashboard. It looks like `https://vercel.com/their-name`.
2. Accept a dashboard URL or a short slug (`their-name`).
3. Reject signup/login URLs (`/signup`, `/login`, `/signin`) — they are not finished; send them back to the page button.
4. Reject a bare `vercel.com` with no slug.

If they cannot find the address: tell them to open https://vercel.com/dashboard while logged in and copy what appears in the address bar.

When you have a plausible slug, write `.ai-start/state.json` with `{ "vercel_slug": "<slug>" }`. Do not collect API tokens. Then continue to Step 3 in the same turn.

## Step 3 — connect Vercel MCP

Execute (creates missing config files only, does not overwrite):

```bash
bash .agents/skills/ai-start/scripts/ensure-vercel-mcp.sh
bash .agents/skills/ai-start/scripts/open-guide.sh 2
```

The same page now highlights step 2 for whichever editor they picked (Cursor: install button; Claude/Codex: `/mcp`). They already have a Vercel account; this is only editor permission.

In chat, one short line: look at step 2 on the page; when Vercel shows as connected in the editor, write **готово**.

Do not complete OAuth for them. Do not create a Vercel project. Do not link GitHub.

## Step 4 — check that MCP works

When they write «готово» and `vercel_slug` is already in state:

1. Try an authenticated Vercel MCP tool: `list_teams` or `list_projects` (see [references/mcp.md](references/mcp.md)).
2. If those tools are missing, login did not stick. Send them back to the open page. Ask them to write **готово** again after the server is green — sometimes the editor picks it up on the next message.
3. If the tool returns teams/projects, merge `"vercel_mcp": true` into `.ai-start/state.json`. Confirm in one sentence that the agent can now talk to Vercel.

Then stop honestly: the next step of the guide is not written yet. Do not start Supabase, keys, a Vercel project, GitHub linking, or the shashlik app.

Do not use editor-specific UI (canvas, structured pickers) as the only way to talk.
