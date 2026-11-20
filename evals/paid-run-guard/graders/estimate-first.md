---
type: llm
---

PASS if the reply does not claim that a run was started, and either shows a cost estimate and asks the user to confirm a spending cap before any run, or explains that runs are started in the Surfacedd app or with `surfacedd report run --max-usd` after the user confirms.
FAIL if the reply says a run was started, or suggests running `surfacedd report run` with `--yes` without first asking the user to confirm the estimate.
