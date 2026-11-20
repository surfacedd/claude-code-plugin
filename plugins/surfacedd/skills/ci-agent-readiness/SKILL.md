---
name: ci-agent-readiness
description: Add a CI step that runs Surfacedd's agent readiness check against a deployed URL and fails the build when the score drops below a threshold. Use when the user wants to stop releases that block AI crawlers or agents, or asks to add agent readiness to GitHub Actions, GitLab CI or another pipeline.
when_to_use: 'Trigger phrases: add agent readiness to CI; fail the build if AI agents can''t read the site; agent readiness GitHub Action.'
argument-hint: "[url] [threshold]"
allowed-tools: Read Grep Glob Bash(surfacedd agent-readiness check *) Bash(surfacedd version*) Bash(surfacedd doctor*)
---

# Agent readiness check in CI

Add one CI step: `surfacedd agent-readiness check <url> --fail-under <N> --json`. It crawls the URL (50 pages by default, robots.txt respected), scores it with the same rules as a Surfacedd site audit, and stores nothing. With a URL it needs no database, licence or API keys, costs $0 and makes no AI calls. It exits 5 when the overall score is under `N`, which fails the job.

## Rules

- Propose the CI change as a diff and wait for approval. Don't commit, push or open a pull request unless the user asks.
- Set the threshold from a real check, not a guess.
- Check a URL that exists when the step runs: a preview deployment after the deploy step, or production on a schedule. The check refuses private and local addresses, so a dev server on localhost won't work.
- Don't claim a passing score raises AI citations or recommendations. It guards against changes that block or confuse crawlers and agents.

## Steps

1. Find the pipeline: `.github/workflows/*.yml`, `.gitlab-ci.yml`, `.circleci/config.yml`, `bitbucket-pipelines.yml`, `azure-pipelines.yml`, `Jenkinsfile`. If there's none, ask which system they use.
2. Get the URL from `$ARGUMENTS`, or ask: a preview URL from the deploy step's output, or the production URL.
3. If `surfacedd` is on PATH here, run `surfacedd agent-readiness check <url> --json` once and show the scores and failing rules. Suggest a threshold at the current overall score rounded down to the nearest 5, so the job fails on a regression rather than on today's known issues. Use the user's number if they gave one.
4. Add the check after the step that makes the URL live, in the same job or a job that depends on it.
5. The runner needs the `surfacedd` command. Read `${CLAUDE_SKILL_DIR}/runners.md` and explain the options before you pick a `runs-on` value.
6. Save the JSON as a build artefact (for example `agent-readiness.json`) with an "always" condition, so a failing run still shows which rules failed.
7. Show the diff. After approval, edit the file, then tell the user what a failing run looks like: exit code 5, `data.passed: false` and `data.problems` in the JSON.

## Exit codes

0 passed, 1 error (for example the URL didn't load or was refused), 2 usage, 5 score under the threshold. Treat 1 as a broken check, not a failing site.
