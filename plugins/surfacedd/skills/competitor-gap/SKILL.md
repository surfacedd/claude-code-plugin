---
name: competitor-gap
description: Find the prompts where AI answers name a competitor instead of the user's brand, show which pages those answers cite, and match each gap to the page in this repository that should compete. Use when the user asks who AI recommends instead of them, why a competitor wins in ChatGPT or Perplexity, or which content gaps to close.
when_to_use: 'Trigger phrases: who does AI recommend instead of us; why does a competitor win in ChatGPT; competitor gap; prompts we lose.'
argument-hint: "[brand] [competitor] [30d|90d]"
allowed-tools: mcp__plugin_surfacedd_surfacedd__* Read Grep Glob
---

# Competitor gap

List the prompts a competitor wins without the brand, read the answers and their cited pages, and map each gap to a page in this repository.

Get the data with the Surfacedd MCP tools. If they aren't available, read `${CLAUDE_PLUGIN_ROOT}/reference/data-access.md` and use the `surfacedd` command equivalents.

## Rules

- Every gap names its prompt, engine, run date and answer id. Quote the sentence from the answer that names the competitor.
- Say what the cited pages contain only if you read them (answer text, or a fetched page). Don't guess why an engine chose them.
- Changes count only when Surfacedd marks them significant. When you compare two brands or prompts, call a gap clear only if their 95% ranges don't overlap.
- No guarantees that a change wins the prompt. Write "raises the odds" and suggest a re-check after the next run.
- Don't write articles or rewrite pages for the user. Point to the page, the missing facts and the evidence.

## Steps

1. `list_brands`, then pick the brand (and the competitor, if named) from `$ARGUMENTS`, or ask. Default range `30d`.
2. `competitor_share` for the range: who leads, their share of voice, and how many answers each won without the brand.
3. `list_prompts`: take the prompts with the lowest visibility, or the ones the user cares about.
4. `prompt_results` for each of those prompts: per engine and run, whether the brand was named, who was named instead and the answer ids. Take the answers where the brand wasn't named.
5. `get_answer` for up to five of them: the text, who was named and in what order, the citations and the fan-out searches.
6. `top_sources` with `kind: page` for the range: the pages engines cite most for this brand's prompts.
7. In this repository, find the page that should answer each prompt (search routes, content and headings for its topic). If none exists, say so. If the working directory has no site code, skip this step and say so.
8. For each gap, compare what the cited pages give the engine (as the answer shows it: a price, a comparison table, a named feature, a review) with what the brand's page has.

## Output

| Prompt | Engine | Named instead | Cited pages | Your closest page | What's missing (evidence) |
|---|---|---|---|---|---|

Then up to three next steps, ordered by how many lost answers each touches, each with the answer ids it would answer.
