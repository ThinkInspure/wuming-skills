# AGENTS.md / CLAUDE.md Best Practices

## Core Mental Model

`AGENTS.md` and `CLAUDE.md` are context injection files for AI coding agents. They are not README replacements, API manuals, style encyclopedias, or generic “be careful” reminders.

Use them to tell an otherwise stateless coding agent:

- **WHY** this project exists and what it optimizes for
- **WHAT** the stack, architecture, and important directories are
- **HOW** to work safely: commands, tests, conventions, permissions, and done criteria

The best files are short, accurate, and operational. Every line should earn its place.

## File Choice

### AGENTS.md

Use `AGENTS.md` for cross-tool AI coding instructions. It is plain Markdown and works well as the shared, tool-neutral standard.

Recommended placement:

- Root `AGENTS.md` for repo-wide guidance
- Nested `AGENTS.md` files for monorepos or domains with distinct rules
- The nearest/narrowest file should contain the most specific rules

### CLAUDE.md

Use `CLAUDE.md` for Claude Code project memory and Claude-specific guidance.

Recommended placement:

- Root `CLAUDE.md` for shared project guidance
- Nested `CLAUDE.md` for subproject-specific guidance
- `CLAUDE.local.md` or user-level memory for personal, unshared preferences

### Compatibility

If the same content should serve multiple tools, prefer `AGENTS.md` as the source of truth and use a `CLAUDE.md` companion or symlink only when that fits the team's tooling. Do not maintain two diverging copies unless there is a real tool-specific difference.

## Length Targets

- Starter file: 20-30 lines
- `AGENTS.md`: aim for under 150 lines
- `CLAUDE.md`: aim for under 200 lines
- Over 300 lines: usually split into references, nested files, rules, commands, or skills

Shorter is better when it remains specific. Long files reduce instruction-following reliability and bury important constraints.

## What Belongs

Include:

- One or two lines of project context
- Exact setup, build, lint, typecheck, and test commands
- File-scoped commands for fast feedback
- Major directory map and “where new code goes” rules
- Non-default conventions the agent cannot infer reliably
- Safety boundaries and operations requiring approval
- Testing requirements and done criteria
- Known gotchas that repeatedly cause mistakes
- Pointers to authoritative docs with “Read when” triggers
- Good patterns and anti-patterns using real file paths

## What Does Not Belong

Avoid:

- Long project history or marketing copy
- Full API docs, database schemas, or tutorials
- Standard language conventions the model already knows
- Linter/formatter rules that tools enforce deterministically
- File-by-file descriptions of the whole repository
- Obvious instructions like “write clean code”
- Frequently changing facts that will go stale
- Actual secrets, credentials, tokens, production URLs, or customer data
- Task-specific instructions that should live in a command, skill, rule file, or separate doc

## Recommended Structure

Use this order unless the project strongly suggests otherwise:

1. Project overview: what it is, who it is for, what matters most
2. Tech stack: frameworks, package managers, runtime versions, forbidden alternatives
3. Commands: exact commands, especially fast file-scoped checks
4. Project structure: important directories and placement rules
5. Conventions: only non-default patterns
6. Testing and quality bar: what to test, how to verify, done criteria
7. Safety and permissions: what is allowed, what needs confirmation
8. Reference documents: “Read when” triggers for deeper docs
9. Good examples / avoid: real paths showing preferred and deprecated patterns

## Commands

Commands should be copy-pasteable and current.

Prefer this pattern:

```md
## Commands

### File-scoped checks (preferred)
- Test one file: `pnpm vitest run src/foo.test.ts`
- Lint one file: `pnpm eslint src/foo.ts`
- Typecheck: `pnpm tsc --noEmit`

### Full checks
- Test suite: `pnpm test`
- Build: `pnpm build`
```

Avoid vague commands such as “run the usual checks.”

## Progressive Disclosure

Keep the root file as a router plus critical constraints. Move long or task-specific content into:

- `docs/*.md` with “Read when” triggers
- nested `AGENTS.md` or `CLAUDE.md` files for subdirectories
- `.claude/rules/*.md` or tool-specific rule systems when path-scoped loading is useful
- skills for specialized workflows and domain procedures
- commands for repeatable prompts or checklists
- hooks/scripts for deterministic validation

Prefer pointers to copies. Link to authoritative files rather than pasting long snippets that will rot.

## Safety And Security

Instruction files are often committed and may be widely visible. Treat them as public unless proven otherwise.

Always include rules such as:

- Never commit `.env` or credential files
- Never hardcode credentials
- Never log secret values
- Use the team's secret manager or local `.env.example` pattern
- Ask before destructive operations, infrastructure changes, package installs, or git pushes

Document where secrets live and how to access them, never the values themselves.

## Maintenance

Treat agent instruction files like code:

- Review them when commands or architecture change
- Update them when the agent repeats the same mistake
- Remove stale or unused rules
- Keep them synchronized with README and CI
- Audit periodically for length, secrets, and drift

## Capability Levels

Use these levels as a maturity model, not a score chase:

- **L0 Absent**: no instruction file
- **L1 Basic**: file exists and is tracked
- **L2 Scoped**: explicit project-specific constraints
- **L3 Structured**: external references and modular docs
- **L4 Abstracted**: path-scoped or nested loading
- **L5 Maintained**: current, reviewed, and pruned
- **L6 Adaptive**: skills, commands, MCP, hooks, or dynamic context for specialized work

Most small projects only need L2-L3. Complex monorepos may benefit from L4-L6.
