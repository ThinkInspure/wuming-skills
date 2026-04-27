# AGENTS.md

## Project
This repository is WuMing's public collection of practical Agent Skills. It is primarily Markdown-based and optimized for reusable AI workflows, project configuration review, document interpretation, operations runbooks, and skill distribution.

## Commands
- Validate marketplace JSON: `python3 -m json.tool .claude-plugin/marketplace.json >/dev/null`
- Validate one skill: `python3 ~/.agents/skills/.system/skill-creator/scripts/quick_validate.py skills/<skill-name>`
- List skills: `find skills -maxdepth 2 -type f -name 'SKILL.md' | sort`

## Project Structure
- `skills/<skill-name>/SKILL.md` - required skill entry point with YAML frontmatter.
- `skills/<skill-name>/references/` - optional detailed docs loaded only when needed.
- `skills/<skill-name>/scripts/` - optional executable helpers for deterministic workflows.
- `skills/<skill-name>/assets/` - optional templates or media used by the skill.
- `skills/<skill-name>/agents/openai.yaml` - optional UI metadata for Codex skill lists.
- `.claude-plugin/marketplace.json` - plugin marketplace listing; update it when adding or removing public skills.
- `README.md` - human-facing skill map; keep it aligned with marketplace entries.

## Skill Conventions
- Keep `SKILL.md` frontmatter to `name` and `description` only.
- Write descriptions as trigger rules: what the skill does, when to use it, and any important non-use case.
- Keep `SKILL.md` as a dispatcher. Move long guidance to `references/` and reusable deterministic logic to `scripts/`.
- Do not add extra docs like `README.md`, changelogs, or install guides inside a skill unless the user explicitly asks.
- For reviewer/planning skills, default to diagnose first; only modify files when the user asks to execute or optimize.
- For high-impact actions such as restarts, config writes, publishing, or destructive cleanup, state the action before running it.

## Adding Or Updating Skills
- Create new skills under `skills/<lowercase-hyphen-name>/`.
- Include `agents/openai.yaml` when the skill should appear cleanly in UI skill lists.
- Update both `README.md` and `.claude-plugin/marketplace.json` for public skills.
- Run `quick_validate.py` on changed skills and `json.tool` on the marketplace before finishing.

## Safety
- Do not include secrets, tokens, private keys, production credentials, or personal local overrides in shared files.
- Do not change license, marketplace owner metadata, git remotes, or publishing configuration unless explicitly requested.
- Ask before deleting skills, rewriting many existing skills, or pushing changes.
