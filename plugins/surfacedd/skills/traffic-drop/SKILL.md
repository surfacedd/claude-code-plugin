---
name: traffic-drop
description: Explain a Google search traffic drop from the Search Console data in Surfacedd, splitting the change into lost queries, rankings, click-through, lost pages, devices, countries and Google updates. Use when the user says organic clicks or traffic fell, asks why Search Console dropped, or wants a drop diagnosis.
when_to_use: 'Trigger phrases: our traffic dropped; why did clicks fall; Search Console drop; did a Google update hit us.'
argument-hint: "[brand] [7d|28d|90d] [previous|year]"
allowed-tools: mcp__plugin_surfacedd_surfacedd__* Read Grep Glob Bash(git log *)
---

# Traffic drop diagnosis

Explain a click change between two periods with Surfacedd's Search Console data. The diagnosis is deterministic: the parts add up to the total change.

Get the data with the Surfacedd MCP tools. If they aren't available, read `${CLAUDE_PLUGIN_ROOT}/reference/data-access.md` and use the `surfacedd` command equivalents.

## Rules

- Report the parts as the tool returns them. Don't invent causes the data doesn't show. Anything not explained stays "unattributed".
- Name a Google update only when the tool annotates it in the window, and call it a possible factor, not the cause.
- No promises that a fix will bring traffic back.
- Free and read-only. Don't start runs.

## Steps

1. `list_brands`, then pick the brand from `$ARGUMENTS` or ask.
2. `gsc_drop_diagnosis` with the range (default `28d`) and `compare` (default `previous`; use `year` for seasonal businesses). If it errors because Google isn't connected, tell the user to connect Google in Surfacedd › Settings › Google, and stop.
3. Read the decomposition: lost and new queries, impressions, position, CTR, unattributed (anonymised) clicks, lost pages, device and country split, data gaps, update annotations.
4. `gsc_top` with `dim: page`, `sort: change` to list the pages that lost the most clicks. For the top three, `gsc_page_queries` to see which queries moved.
5. `ai_traffic` for the same periods. If AI assistant visits rose while search clicks fell, say so, with the numbers. It's context, not proof of a cause.
6. If the losing pages live in this repository, run `git log --since=<start of the earlier period> -- <file>` on their source files. A template, title, canonical or robots change near the drop is worth showing, with the commit.

## Output

```markdown
# Search clicks: <brand>, <period> vs <comparison>

Clicks <now> vs <before> (<change>, <percent>).

| Part of the change (as the tool names it) | Clicks |
|---|---|
| <one row per part> | |
| **Total** | <equals the change> |

## Pages that lost the most
## What the data doesn't explain
## Checks worth doing next
```
