#!/usr/bin/env bash
set -euo pipefail
mkdir -p .github/workflows
cat > .github/workflows/deploy.yml <<'YML'
name: Deploy
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      - run: npm ci
      - run: npm run build
      - name: Deploy
        run: npx vercel deploy --prod --token "$VERCEL_TOKEN"
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
YML
