---
name: ai-start-trae
description: >-
  Guides a beginner in Trae (TraeCode, trae.ai) through this template so they
  can program anything they want without development experience. Opens a local
  HTML guide, connects Vercel MCP in Trae, then deploys a hello page to a
  Vercel URL. Use when the user is in Trae and says «запусти мой первый проект»,
  «начнём», «готово», «не вошло», «start my first project», opens this repo to
  get started, or asks how to proceed after cloning the template.
---

# ai-start-trae

You are walking a person who may not know IT. Use plain language. Do not ask them to run terminal commands themselves. Execute scripts yourself.

This repository is **infrastructure**, not a specific product. The first example to prove the loop is **«кто что несёт на шашлык»** — do not build that app yet. First proof is a hello page on Vercel.

This skill is **Trae only** (international app from [trae.ai](https://www.trae.ai/), not the China app trae.cn). Do not mention Cursor, Claude Code, or Codex. Do not ask which editor they use.

The guide UI is **one local HTML page** (no backend): [assets/index.html](assets/index.html). Re-open with `open-guide.sh <n>` so `#step-n` is highlighted. Keep chat short: do not paste the page copy.

Progress lives in gitignored `.ai-start/state.json`. Read it at the start of a turn if it exists.

Vercel MCP: [references/mcp.md](references/mcp.md).

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

If `.ai-start/state.json` already has a `vercel_url`, skip to Step 5 (re-open the guide on step 3).

If Vercel MCP already works (`list_teams` succeeds) and there is no `vercel_url`, skip to Step 4.

If MCP is not ready but they already saw the MCP step, wait for «готово» or «не вошло» and go to Step 3.

## Step 1 — open the guide

Execute:

```bash
bash .agents/skills/ai-start-trae/scripts/open-guide.sh 1
```

The page starts at the Vercel account step. In chat, one short line: the page opened; after Vercel they should write **готово**.

Do not register for them.

## Step 2 — after first «готово» (account)

Do **not** ask them to paste a Vercel dashboard URL. Next check is MCP.

Execute:

```bash
bash .agents/skills/ai-start-trae/scripts/ensure-vercel-mcp.sh
bash .agents/skills/ai-start-trae/scripts/open-guide.sh 2
```

Write `.ai-start/state.json` with `{ "mcp_prompted": true }` (keep other keys). In chat, one short line: look at step 2; when Vercel is connected in Trae, write **готово**. If the login window never appears, they should write **не вошло**.

Do not complete OAuth for them. Do not link GitHub. Do not put API tokens in git.

## Step 3 — check that MCP works

When they write «готово» or «не вошло» after the MCP step (or any «готово» if you have not confirmed MCP yet):

1. Call Vercel MCP `list_teams` (see [references/mcp.md](references/mcp.md)).
2. If the tool exists and returns teams: take the first team's `slug` and `id`. Merge into `.ai-start/state.json`: `vercel_slug`, `vercel_team_id`, `vercel_mcp: true`. Then continue to Step 4 in the same turn.
3. If the tool is missing or fails after «готово»: login did not stick. Send them back to step 2 once. Ask them to write **готово** again after Vercel is connected, or **не вошло** if Trae refuses the login.
4. If they wrote **не вошло**, or the second attempt still has no `list_teams`: follow **If OAuth never starts** in [references/mcp.md](references/mcp.md). Do not loop on OAuth forever.

## Step 4 — deploy the hello page

Do this only if `vercel_url` is not already in state.

1. Run (pass the team slug from `list_teams`):

```bash
bash .agents/skills/ai-start-trae/scripts/next-project-name.sh <team-slug>
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

5. Save the **unprotected** public URL (no share token):

```bash
bash .agents/skills/ai-start-trae/scripts/write-deploy-js.sh <public-url> <project-name>
```

Merge `vercel_url` and `vercel_project` into `.ai-start/state.json`.

6. Continue to Step 5.

Do not create a git-linked project. Do not buy a domain. Do not leave Vercel Authentication on.

## Step 5 — show the result on the guide

```bash
bash .agents/skills/ai-start-trae/scripts/open-guide.sh 3
```

The guide step 3 becomes visible with the live link (via gitignored `assets/deploy.js`). In chat, one short line: the site is on the internet; the link is on the page.

Do not start Supabase or the shashlik app.

Do not use editor-specific UI (canvas, structured pickers) as the only way to talk.
