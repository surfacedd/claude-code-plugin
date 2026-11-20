---
plugins: ["../../plugins/surfacedd"]
description: The CI skill adds a threshold check after the deploy step and proposes it as a diff.
tags: [skill, repo, ci]
max_turns: 25
allowed_tools: [Skill, Read, Glob, Grep]
---

Add an agent readiness check to our GitHub Actions deploy workflow so the build fails if the score drops under 80. The production URL is https://example-tallyfox.com.
