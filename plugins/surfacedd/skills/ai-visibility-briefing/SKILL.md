---
name: ai-visibility-briefing
description: Write a weekly AI visibility briefing from the local Surfacedd workspace, with the evidence behind every point. Use when the user asks how their brand did in ChatGPT, Claude, Gemini, Perplexity or Google AI answers this week, what changed, or for a visibility summary or status note.
when_to_use: 'Trigger phrases: weekly AI visibility update; how did we do in AI answers; what changed in our AI visibility; write the visibility note.'
argument-hint: "[brand] [7d|30d]"
allowed-tools: mcp__plugin_surfacedd_surfacedd__*
---

# AI visibility briefing

Write a short briefing on one brand's AI visibility for a period (default `7d`), with the evidence for every point.

Get the data with the Surfacedd MCP tools. If they aren't available, read `${CLAUDE_PLUGIN_ROOT}/reference/data-access.md` and use the `surfacedd` command equivalents.

## Rules

- Tie every claim to its source: prompt, engine, run date, and an answer id or URL.
- Call a change real only when Surfacedd marks it significant: the 95% range of the change excludes zero. Otherwise write "no clear change". Never call noise a trend.
- No guarantees about rankings, recommendations, citations or traffic.
- Everything here is free and read-only. Don't start runs.

## Steps

1. `list_brands`. Use the brand the user named (`$ARGUMENTS`). If there are several brands and none was named, ask which one.
2. `list_runs` for the brand. If no run finished in the period, say when the latest run was and stop: there's nothing new to brief on.
3. `visibility_summary` for the period. It already compares each rate with the previous period and marks significant changes. Use those marks; don't recompute them.
4. `competitor_share` for the period. Take the top answers won without the brand.
5. `top_sources` (`kind: domain`) for the period: which sites the engines cite most, and whether the brand's own site is among them.
6. `list_tasks` (`status: todo`, then `in_progress`). Pick up to three tasks whose evidence matches what changed.
7. Optional, only if the tool answers without an error: `agent_readiness` (changes since the last check) and `ai_traffic` (visits from AI assistants).

## Output

Keep it under 400 words unless the user asks for more:

```markdown
# AI visibility: <brand>, <from> to <to>

**Headline:** <visibility> (95% range <lo>–<hi>, <n> answers), <change> vs the previous period. <"Significant change" or "No clear change">.

| Engine | Visibility | Range | Change | Significant? |
|---|---|---|---|---|

## What changed
- <only clear changes, each with the prompts and answer ids behind it>

## Won without you
- <prompt> on <engine>: <who was named instead>, cited <URL> (answer <id>)

## Sources AI cites
- <domain>: <citations>, <trend>

## Next steps
- <task title>: <evidence>, from Surfacedd's task list

Data: runs <dates>, <answers> answers, cost <from list_runs>.
```

Write it to a file only if the user asks, for example `docs/visibility/<date>.md`.
