# surfacedd (Claude Code plugin)

Read-only MCP tools over your local [Surfacedd](https://surfacedd.com) workspace, plus six skills: `ai-visibility-briefing`, `fix-agent-readiness`, `traffic-drop`, `competitor-gap`, `product-visibility` and `ci-agent-readiness`.

It needs Surfacedd for Mac or Windows and the `surfacedd` command on your PATH (Surfacedd › Settings › AI assistants & CLI › Install command-line tool). The MCP server is `surfacedd mcp`: it reads your local database read-only and makes no network calls. The only paid action, `surfacedd report run --max-usd`, runs only after you confirm the estimate.

Install it in Claude Code (v2.1.275 or later):

```text
/plugin install surfacedd --marketplace surfacedd/claude-code-plugin
```

Skills and troubleshooting: see the README at the root of this repository, or https://surfacedd.com/integrations/claude-code.
