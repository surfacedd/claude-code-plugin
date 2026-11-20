# Surfacedd for Claude Code

Let Claude Code, Cursor and your scripts work with your AI visibility data.

This repository is a Claude Code plugin marketplace with one plugin, `surfacedd`. The plugin connects Claude Code to the [Surfacedd](https://surfacedd.com) desktop app on your computer. It gives Claude read-only MCP tools over your local workspace and six skills for common jobs. Your data stays on your computer: the tools read Surfacedd's local database and make no network calls.

## What you need

- Surfacedd for Mac or Windows, opened at least once.
- The `surfacedd` command on your PATH: in Surfacedd, open **Settings › AI assistants & CLI** and click **Install command-line tool**. Check it with `surfacedd doctor`.
- Claude Code.

## Install

In Claude Code:

```text
/plugin marketplace add surfacedd/claude-code-plugin
/plugin install surfacedd@surfacedd
```

Or in one step (Claude Code v2.1.275 or later):

```text
/plugin install surfacedd --marketplace surfacedd/claude-code-plugin
```

Or from your shell (Claude Code v2.1.292 or later):

```bash
claude plugin install surfacedd --marketplace surfacedd/claude-code-plugin
```

Run `/reload-plugins` or start a new session, then `/mcp` should list `plugin:surfacedd:surfacedd` as connected.

## What you get

**MCP server.** The plugin starts `surfacedd mcp`, the same read-only server the app ships. Claude can read visibility with 95% ranges, prompts, stored answers, competitors, cited sources, fan-out searches, products, tasks, runs, crawler visits, site audit issues, agent readiness, and Search Console and GA4 data if you connected Google in Surfacedd. Tool names start with `mcp__plugin_surfacedd_surfacedd__`.

**Skills.** Claude picks them up from what you ask, or you can run them as `/surfacedd:<name>`:

| Skill | What it does |
|---|---|
| `ai-visibility-briefing` | A weekly visibility note per engine, with the answers behind each point and only significant changes called changes |
| `fix-agent-readiness` | Maps failing agent readiness rules to files in your repository and proposes fixes as diffs. Never deploys |
| `traffic-drop` | Explains a Search Console click drop: lost queries, position, click-through, devices, countries and Google updates |
| `competitor-gap` | Prompts where AI names a competitor instead of you, the pages those answers cite, and your closest page |
| `product-visibility` | Which of your products AI names and recommends, and which rival products win instead |
| `ci-agent-readiness` | Adds `surfacedd agent-readiness check <url> --fail-under N` to your CI pipeline |

**Spending money.** Everything above is free. The only paid action is a run, through `surfacedd report run <report> --max-usd <X>`. The skills show the estimate first (`surfacedd report estimate`) and run only after you say yes in the conversation.

## Without the plugin

Cursor and other MCP clients can run the same server. Add this to `~/.cursor/mcp.json` (or your client's `mcpServers` config):

```json
{
  "mcpServers": {
    "surfacedd": {
      "command": "surfacedd",
      "args": ["mcp"]
    }
  }
}
```

If the client can't find `surfacedd` (apps opened from the Dock don't always see your shell's PATH), use the full path that `surfacedd doctor` prints, or the copy-ready entry in Surfacedd's **Settings › AI assistants & CLI**.

Scripts and CI can call the command directly. It prints JSON when its output isn't a terminal:

```bash
surfacedd visibility --range 7d > visibility.json
surfacedd agent-readiness check https://example.com --fail-under 70
```

Docs: [command reference](https://surfacedd.com/docs/cli/commands), [JSON output](https://surfacedd.com/docs/cli/json-output), [exit codes](https://surfacedd.com/docs/cli/exit-codes), [CI recipe](https://surfacedd.com/docs/cli/ci).

## Code Mode

[Code Mode](https://code.claude.com/docs/en/code-mode) is an experimental Claude Code feature in which Claude writes JavaScript that runs tool calls, including shell commands. The `surfacedd` command is an ordinary shell command, so it can be called there like any other. The skills fall back to it when the MCP tools aren't available. Code Mode may change or be removed in any release; nothing here depends on it.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `/mcp` shows the server failed | Run `surfacedd doctor` in a terminal. If the command isn't found, install it from Surfacedd's settings and start a new terminal |
| "database not found" | Open Surfacedd once, or point at your workspace with `SURFACEDD_DB` |
| Google tools return an error | Connect Google in Surfacedd › Settings › Google |
| A skill doesn't trigger | Run it directly, for example `/surfacedd:competitor-gap` |

## Develop

```bash
claude plugin validate plugins/surfacedd     # manifest, skills and MCP config
claude plugin validate .                     # marketplace manifest
claude --plugin-dir plugins/surfacedd        # try it locally without installing
claude plugin eval . --eval-dir evals --scaffold --runs 1 --ablation none --judge-model sonnet --trust-plugin --no-publish
```

The eval suite under `evals/` answers the MCP tools from mocks recorded from Surfacedd's sample workspace (the fictional brand Tallyfox), so the evals need no Surfacedd install and no real data.
