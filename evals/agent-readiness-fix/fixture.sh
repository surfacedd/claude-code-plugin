#!/usr/bin/env bash
# A small Next.js site matching the sample workspace's agent readiness evidence:
# /pricing has Product JSON-LD without availability and no stock wording, /demo-request has an
# unlabelled email field, /contact uses reCAPTCHA. The bot wall is a Cloudflare setting, not code.
set -euo pipefail
mkdir -p app/pricing app/demo-request app/contact public
cat > public/robots.txt <<'TXT'
User-agent: *
Allow: /
Sitemap: https://example-tallyfox.com/sitemap.xml
TXT
cat > app/layout.tsx <<'TSX'
export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        <nav aria-label="Main"><a href="/pricing">Pricing</a></nav>
        <main>{children}</main>
      </body>
    </html>
  );
}
TSX
cat > app/pricing/page.tsx <<'TSX'
const product = {
  "@context": "https://schema.org",
  "@type": "Product",
  name: "Tallyfox Pro",
  offers: { "@type": "Offer", price: "29", priceCurrency: "USD" },
};

export default function Pricing() {
  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(product) }} />
      <h1>Pricing</h1>
      <PriceTable />
    </>
  );
}

function PriceTable() {
  // Prices load in the browser from /api/prices.
  return <div id="price-table" />;
}
TSX
cat > app/demo-request/page.tsx <<'TSX'
export default function DemoRequest() {
  return (
    <form action="/api/demo" method="post">
      <h1>Book a demo</h1>
      <label htmlFor="name">Name</label>
      <input id="name" name="name" />
      <input type="email" name="email" placeholder="Work email" />
      <button type="submit">Request a demo</button>
    </form>
  );
}
TSX
cat > app/contact/page.tsx <<'TSX'
export default function Contact() {
  return (
    <form action="/api/contact" method="post">
      <h1>Contact us</h1>
      <label htmlFor="msg">Message</label>
      <textarea id="msg" name="message" />
      <div className="g-recaptcha" data-sitekey="site-key" />
      <button type="submit">Send</button>
    </form>
  );
}
TSX
