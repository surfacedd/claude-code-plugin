---
type: llm
---

PASS if the reply ties at least two failing rules from the agent readiness result to files in this repository (for example the Product markup or price on app/pricing/page.tsx, or the unlabelled email field in app/demo-request/page.tsx), proposes a concrete change for each (a diff or the exact new code), says that the Perplexity-User bot wall is a Cloudflare, CDN or firewall setting rather than code in the repo, and asks for approval before editing.
FAIL if it claims the changes will raise AI citations or recommendations, says it deployed or committed anything, or proposes changes that no rule in the tool result supports.
