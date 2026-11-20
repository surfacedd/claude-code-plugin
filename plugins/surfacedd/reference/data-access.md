# Reading Surfacedd data

Surfacedd keeps its data in a local SQLite workspace on this computer. Two ways in, with the same output:

1. **MCP tools** (preferred). The plugin starts `surfacedd mcp`. Tools are named `mcp__plugin_surfacedd_surfacedd__<tool>`, all read-only and free.
2. **The `surfacedd` command** (fallback). Use it when the MCP tools aren't listed, when `/mcp` shows the server failed, or when you work through the shell (for example in Code Mode). Always pass `--json`. Read commands reuse the MCP tool code, so the JSON matches.

| MCP tool | CLI equivalent (`--json`) |
|---|---|
| `list_brands` | `surfacedd brands` |
| `visibility_summary` | `surfacedd visibility --brand <id> --range 7d` |
| `list_prompts` | `surfacedd prompts --brand <id>` |
| `search_answers` | `surfacedd answers search "<query>" --brand <id>` |
| `get_answer` | `surfacedd answer <answer_id>` |
| `competitor_share` | `surfacedd competitors --brand <id>` |
| `top_sources` | `surfacedd sources --brand <id> --kind domain\|page` |
| `fanouts` | `surfacedd fanouts --brand <id>` |
| `product_share` | `surfacedd products --brand <id>` |
| `product_results` | `surfacedd product <product_id>` |
| `list_tasks` | `surfacedd tasks --brand <id>` |
| `list_runs` | `surfacedd runs --brand <id>` |
| `gsc_summary` / `gsc_top` / `gsc_opportunities` / `gsc_drop_diagnosis` | `surfacedd gsc summary\|top\|opportunities\|drop --brand <id>` (`gsc top --dim page --sort change`) |
| `ga4_traffic` / `ai_traffic` | `surfacedd traffic --brand <id>` / `surfacedd traffic --ai --brand <id>` |
| `crawler_stats` | `surfacedd crawlers --brand <id>` |
| `site_audit_issues` | `surfacedd audit issues --brand <id>` |
| `agent_readiness` | `surfacedd agent-readiness --brand <id>` |
| `humans_summary` | `surfacedd humans <person id or name>` |
| `estimate_run_cost` | `surfacedd report estimate <report id or name>` |

`--brand` takes an id or a name and defaults to your only brand. `--range` takes `7d`, `30d`, `90d` or `<from>..<to>` (dates as `YYYY-MM-DD`). `--db <path>` (or `SURFACEDD_DB`) points at another workspace. `surfacedd help <command>` lists a command's options.

Exit codes: 0 ok, 1 error, 2 usage, 3 licence, 4 budget or confirmation needed, 5 threshold failed. Run `surfacedd doctor` when a command fails for a reason you can't read from its message.

## Ranges

- AI answer tools take `range`: `7d`, `30d`, `90d` (default), `365d`, `all`, or `from`/`to` as `YYYY-MM-DD`.
- Google tools (`gsc_*`, `ga4_traffic`, `ai_traffic`) take `range`: `7d`, `28d` (default), `90d`, `180d`, `365d`, `16m`, and `compare`: `previous` (default), `year`, `none`.

## When data is missing

- A Google tool error that says the brand has no linked property means Google isn't connected: tell the user to connect it in Surfacedd › Settings › Google. Don't guess traffic numbers.
- No runs in the range: say when the latest run was (`list_runs`) and stop. New answers come from runs the user starts in the app, or from a paid `surfacedd report run` (see the cost rule in each skill).
- `database not found`: Surfacedd hasn't been opened on this computer yet, or the workspace is elsewhere.

## Spending money

Every tool above is free and read-only. The only paid action is `surfacedd report run <report> --max-usd <X>`. Before it:

1. Run `surfacedd report estimate <report> --json` and show the estimate: the middle figure, the likely range and the engines.
2. Ask the user to confirm the run and a spending limit in this conversation. Suggest a limit at or above the high end of the likely range: `--max-usd` is a hard limit on actual spend, so a lower one can stop the run part-way. Their earlier messages don't count as confirmation.
3. Only after a clear yes, run `surfacedd report run <report> --max-usd <X> --yes --json`, with `<X>` no higher than the limit they agreed.
4. Exit 4 means a limit stopped it. If `data.limit.reached` is true, the run started, stopped before passing the limit and kept its answers (partial; `data.limit.skipped` answers weren't asked). Otherwise it was refused before anything was spent. Report which, and stop.
