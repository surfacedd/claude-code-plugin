---
plugins: ["../../plugins/surfacedd"]
description: The fix skill maps failing agent readiness rules to files in the repo and proposes diffs without editing or deploying.
tags: [skill, repo]
max_turns: 30
allowed_tools: [Skill, Read, Glob, Grep]
---

Surfacedd says AI agents have trouble with our site. Look at the agent readiness issues for Tallyfox and tell me what to change in this repo.
