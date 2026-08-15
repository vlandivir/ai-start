# Agent instructions

This repository is beginner infrastructure: a person with no development experience should be able to describe an idea and get a working site on the internet.

The first example to prove the loop is **кто что несёт на шашлык** (shared link, name + what you bring). It is a sample, not the product of this repo.

If the user wants to start, launch their first project, writes «готово» / «не вошло», or asks what to do after cloning:

- **Trae** (TraeCode, trae.ai): read and follow [`.agents/skills/ai-start-trae/SKILL.md`](.agents/skills/ai-start-trae/SKILL.md). Trae also discovers [`.trae/skills/ai-start-trae/SKILL.md`](.trae/skills/ai-start-trae/SKILL.md).
- **Cursor**: read and follow [`.agents/skills/ai-start-cursor/SKILL.md`](.agents/skills/ai-start-cursor/SKILL.md).

Do not ask which editor they use. Pick the skill that matches this agent.

The current step lives on a local HTML page. Open it with that skill's script; do not duplicate the page in chat. After Vercel MCP works, deploy the hello page with `deploy_to_vercel` and show the live link on the guide. Do not scaffold the shashlik app, collect secrets, or link GitHub until that skill says those phases exist.
