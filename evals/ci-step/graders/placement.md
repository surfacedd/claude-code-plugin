---
type: llm
---

PASS if the reply proposes a change to .github/workflows/deploy.yml that runs the agent readiness check against https://example-tallyfox.com after the Deploy step, explains that the job fails when the score is under 80, says the runner needs the surfacedd command (for example a self-hosted macOS or Windows runner with Surfacedd installed), and asks for approval before editing.
FAIL if it says it already committed or pushed, puts the check before the deploy, or claims a passing score raises AI citations.
