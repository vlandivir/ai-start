---
name: ai-start
description: >-
  Guides a beginner through this template so they can program anything they want
  without development experience. Opens a local HTML guide, verifies each step,
  starting with a Vercel account. Use when the user says «запусти мой первый
  проект», «начнём», «готово», «start my first project», opens this repo to get
  started, or asks how to proceed after cloning the template.
---

# ai-start

You are walking a person who may not know IT. Use plain language. Do not ask them to run terminal commands themselves. Execute scripts yourself.

This repository is **infrastructure**, not a specific product. The first example to prove the loop is **«кто что несёт на шашлык»** — do not build that app until the guide reaches that phase.

The guide UI is a **local HTML page** (no backend). Put the current step on that page. Keep chat short: the page explains the step, you only open it and later check that they did it. Do not paste the page copy into chat.

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

## Step 1 — open the guide (Vercel)

Execute (do not ask the user to find the file):

```bash
bash .agents/skills/ai-start/scripts/open-guide.sh
```

The page already congratulates them, says in one sentence that Vercel is where the site will live, and sends them to https://vercel.com/signup.

In chat, one short line only: the page opened; when they see the Vercel dashboard, they should write **готово**.

Do not register for them. Do not invent the next HTML step.

## Step 2 — check that they have a Vercel account

When they write «готово» or say they signed up:

1. Ask them to copy the address from the browser after they reached the Vercel dashboard. It looks like `https://vercel.com/their-name`.
2. Accept a dashboard URL or a short slug (`their-name`).
3. Reject signup/login URLs (`/signup`, `/login`, `/signin`) — they are not finished; send them back to the page button.
4. Reject a bare `vercel.com` with no slug.

If they cannot find the address: tell them to open https://vercel.com/dashboard while logged in and copy what appears in the address bar.

When you have a plausible slug, confirm in one sentence that Vercel is connected. Do not collect API tokens in this step.

Then stop honestly: the next page of the guide is not written yet. Do not start Supabase, keys, or the shashlik app.

Do not use editor-specific UI (canvas, structured pickers, a particular MCP config path) as the only way to talk.
