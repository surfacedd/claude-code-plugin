# Getting `surfacedd` onto a CI runner

The `surfacedd` command ships inside the Surfacedd desktop app (macOS and Windows). There is no standalone download or package-manager install yet, so a hosted runner such as `ubuntu-latest` or `macos-latest` doesn't have it. Say this plainly; don't invent an install step.

Options that work today:

1. **A self-hosted runner on a Mac or Windows machine that has Surfacedd installed**, with the command installed from Surfacedd › Settings › AI assistants & CLI › Install command-line tool. In GitHub Actions, target it with labels, for example `runs-on: [self-hosted, macOS]`. The URL form of the check needs no licence or database on that machine.
2. **Run the same command before you deploy, on your own computer** (a pre-push hook or a release checklist step), if a self-hosted runner isn't an option.

GitHub Actions example (self-hosted macOS runner):

```yaml
  agent-readiness:
    needs: deploy
    runs-on: [self-hosted, macOS]
    steps:
      - name: Check the deployed site for AI agents
        run: surfacedd agent-readiness check "$SITE_URL" --fail-under 70 --max-pages 50 --json > agent-readiness.json
        env:
          SITE_URL: https://staging.example.com
      - if: always()
        uses: actions/upload-artifact@v7
        with:
          name: agent-readiness
          path: agent-readiness.json
```

GitLab CI equivalent: a job with `needs: [deploy]`, `tags: [macos]` (your runner's tag), the same `script` line, and `artifacts: { when: always, paths: [agent-readiness.json] }`.
