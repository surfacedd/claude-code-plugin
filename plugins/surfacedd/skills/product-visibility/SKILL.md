---
name: product-visibility
description: Show which of the brand's products AI answers name and recommend, which rival products win instead, and which pages those answers cite, then check the matching product pages in this repository. Use when the user asks how their products show up in ChatGPT, Gemini or Google AI answers, or why a rival product gets recommended.
when_to_use: 'Trigger phrases: which of our products does AI recommend; product visibility in AI answers; why does AI recommend their product; shopping answers.'
argument-hint: "[brand] [product or category] [30d|90d]"
allowed-tools: mcp__plugin_surfacedd_surfacedd__* Read Grep Glob
---

# Product visibility

Report how AI answers treat the brand's products, product by product, with the answers behind each number.

Get the data with the Surfacedd MCP tools. If they aren't available, read `${CLAUDE_PLUGIN_ROOT}/reference/data-access.md` and use the `surfacedd` command equivalents.

## Rules

- Report mention rate, recommended rate and share of voice with their 95% ranges and answer counts. Call a gap between two products clear only when their ranges don't overlap, and a change real only when Surfacedd marks it significant. With fewer than 20 answers for a product, say the sample is small.
- Every rival win names the prompt, engine and answer id.
- No guarantees that a page change gets a product recommended.
- Free and read-only. Don't start runs.

## Steps

1. `list_brands`, then pick the brand from `$ARGUMENTS`, or ask. Default range `30d`.
2. `product_share` for the brand (with `category` if the user named one). If it returns no products, the catalogue is empty: tell the user to add products in Surfacedd (from Brand analysis, a CSV file, the site's Product JSON-LD, a Shopify store's public product list, or by hand), and stop.
3. Pick the products to look at: the ones the user named, or the three with the most answers and the lowest recommended rate.
4. `product_results` for each: rates by engine, the answers that name it, the rival products in the same answers, and the pages those answers cite.
5. In this repository, find each product's page. Check what an agent or engine can read in the server HTML: Product JSON-LD with an Offer (price, currency, availability), GTIN or SKU, the price in visible text, and the product name as the answers write it.
6. If `agent_readiness` reports Product or Offer issues on these pages, include them.

## Output

| Product | Mentioned | Recommended | Category share | Top rival in the same answers | Evidence |
|---|---|---|---|---|---|

Then, per product, what its page is missing that the cited pages have, with the answer ids. Propose code changes (for example Product JSON-LD) as diffs for review only if the user asks.
