---
name: fix-agent-readiness
description: Turn Surfacedd's agent readiness issues into code and config changes in this repository, proposed as diffs for review. Use when the user wants to fix what stops AI crawlers and agents from reaching, understanding or acting on their site, such as robots rules, bot walls, structured data, llms.txt, labels or sitemaps.
when_to_use: 'Trigger phrases: fix our agent readiness; why can''t AI agents read our site; fix the robots.txt for AI crawlers; add the missing structured data Surfacedd found.'
argument-hint: "[brand]"
allowed-tools: mcp__plugin_surfacedd_surfacedd__* Read Grep Glob
---

# Fix agent readiness

Read the latest agent readiness check for the brand, find the files in this repository that cause each failing rule, and propose fixes as diffs. You never deploy.

Get the data with the Surfacedd MCP tools. If they aren't available, read `${CLAUDE_PLUGIN_ROOT}/reference/data-access.md` and use the `surfacedd` command equivalents.

## Rules

- Work only from the check's evidence: the rule id, the URL, the fetched snippet or header. Quote it next to each fix.
- Propose every change as a diff and wait for the user's approval before you edit. Never commit, push, deploy, or change hosting, CDN or firewall settings yourself.
- Don't claim a fix will raise AI citations or recommendations. Say what it makes possible: an agent can now fetch the page, read the price, submit the form.
- Rules labelled informational (emerging agent protocols, llms.txt) are optional. Present them last, as optional, and say adoption is early.

## Steps

1. `list_brands`, then `agent_readiness` for the brand (`$ARGUMENTS` if given). If there's no check yet, tell the user to run a site audit in Surfacedd (Website › Agent readiness), or offer `surfacedd agent-readiness check <url> --json`, which is local and free, and stop until there's a result.
2. Order the failing rules by weight, as the check does. Show the Reach, Understand and Act scores and what changed since the previous check.
3. For each failing rule, find where it comes from in this repo:
   - robots rules: `robots.txt`, or the code that generates it (`app/robots.ts`, `public/robots.txt`, server config);
   - bot walls (403, 429 or a challenge for agent user agents): usually hosting, CDN or WAF settings, not code. Explain the setting to change and where, and don't edit;
   - structured data, price and availability in HTML, headings, landmarks, link text, form labels, button names: the templates and components that render the page in the evidence;
   - sitemap, canonical, llms.txt: the generator or the static file.
4. If the cause isn't in this repository, say so and give the user the exact change to make elsewhere.
5. Show one diff per rule, with the evidence it answers. Edit only after the user approves.
6. When the changes are live, offer a re-check: `surfacedd agent-readiness check <url> --json` (local, $0). Report which rules now pass and the new scores.

## Output

A table first, then the diffs:

| Rule | Weight | Page | Evidence | Fix | Where |
|---|---|---|---|---|---|
