# Oslo Lights website

Single-page site for Oslo Lights. Plain HTML and CSS, no build step, no JavaScript, no cookies, no third-party requests.

## Run it locally

```sh
python3 -m http.server 8000
# open http://localhost:8000
```

## Files

| Path | What it is |
| --- | --- |
| `index.html` | The page: hero, social links, bio, photo strip, footer. Also holds meta tags, share cards and the MusicGroup structured data. |
| `404.html` | "Signal lost" error page. |
| `assets/css/style.css` | All styling and the glitch / laser effects. |
| `assets/icons.svg` | Social icons as an SVG sprite (from Simple Icons, CC0). |
| `assets/logo/` | Logo in AVIF and WebP, cropped from the 8K PNGs. |
| `assets/img/` | Photos as AVIF, WebP and a JPG fallback at several widths, plus share image and app icons. |
| `assets/fonts/` | Anton and JetBrains Mono, self-hosted (SIL OFL), so no Google Fonts calls. |
| `favicon.ico`, `favicon.svg`, `site.webmanifest` | Browser and home-screen icons. |
| `robots.txt`, `sitemap.xml` | For search engines. |
| `_headers`, `_redirects` | Headers and 404 rule for Netlify / Cloudflare Pages style hosts. |
| `.htaccess` | Headers, 404, HTTPS and www redirects for Apache / LiteSpeed hosts. |
| `vercel.json` | Headers for Vercel style hosts. |
| `deploy/nginx.conf` | Ready server block if the host runs nginx. |

## Swapping the logo (SVG or Lottie)

The logo lives inside `<h1 class="logo">` in `index.html`.

- **SVG:** drop the file in `assets/logo/`, replace the `<picture>` with `<img src="assets/logo/logo.svg" alt="Oslo Lights">`, and set `--logo-src` at the top of `assets/css/style.css` to the same file so the glitch layers match. If the SVG has a different shape, update `aspect-ratio` on `.logo`.
- **Lottie:** add the player script to `assets/js/`, put the player element inside `.logo`, and add the class `logo--lottie` to the `<h1>` (this turns off the CSS glitch copies). Keep a visually hidden "Oslo Lights" text in the `<h1>` for screen readers and search.

Remember to also refresh the preload line for the logo in `<head>`.

## Changing the domain

All absolute URLs (canonical, share cards, structured data, sitemap, robots, 404 base) point to `https://oslolights.com/`. To move to another address:

```sh
scripts/set-domain.sh https://new-domain.example/
```

## Hosting

The site is deployed by **ardacloud**, which reads this repo directly (the repo stays private). It's plain static files with no build step. In Arda pick the **Static HTML** preset (not Docker; there is no Dockerfile), leave the build command empty, publish directory = repo root.

The repo carries header and 404 config in every common format, so whichever one the host reads, it gets the same rules:

| Host reads | File | Gives |
| --- | --- | --- |
| `_headers` / `_redirects` (Netlify, Cloudflare Pages and similar) | `_headers`, `_redirects` | Security headers, caching, 404 |
| Apache or LiteSpeed | `.htaccess` | Security headers, caching, 404, HTTPS and www redirects, hides repo files |
| `vercel.json` (Vercel and similar) | `vercel.json` | Security headers, caching (404.html is picked up automatically) |
| nginx | `deploy/nginx.conf` | Paste into the server config |

Whatever the host, `index.html` and `404.html` also carry the CSP and referrer policy as `<meta>` tags, so the core protection is there even if none of the files above is read. HSTS and frame blocking need real headers.

The 404 page uses `<base href="https://oslolights.com/">`, so its styles load from any depth. Most hosts serve `404.html` for missing pages automatically; if ardacloud asks for an error page setting, point it at `/404.html`.

After the first deploy, check headers at https://securityheaders.com and the share card at https://www.opengraph.xyz.

## Motion

Glitch tears, laser flicker, the sweep line and film grain are all CSS. Anyone with "reduce motion" turned on in their OS gets the same look, still.

## Launch checklist

Based on the [Front-End Checklist](https://github.com/thedaviddias/Front-End-Checklist).

- [x] Doctype, `lang`, charset, viewport
- [x] Unique title and meta description
- [x] Canonical URL
- [x] Favicon set: `.ico`, SVG, Apple touch icon, manifest icons (incl. maskable)
- [x] Web app manifest and `theme-color`
- [x] Open Graph and Twitter cards with a 1200x630 image and alt text
- [x] MusicGroup JSON-LD with `sameAs` links to every profile
- [x] `robots.txt` and `sitemap.xml`
- [x] Custom 404 page (`noindex`)
- [x] Responsive images: AVIF + WebP + JPG fallback, `srcset`/`sizes`, width/height set, lazy loading below the fold
- [x] Fonts self-hosted, subset to Latin, WOFF2, preloaded, `font-display: swap`
- [x] No third-party requests, no cookies, no tracking (nothing to consent to under GDPR)
- [x] External links use `rel="noopener noreferrer"` and say they open a new tab
- [x] Skip link, visible focus ring, landmarks, one `h1`
- [x] Alt text on every photo; icons hidden from screen readers with text labels on each link
- [x] Text contrast meets WCAG AA (checked with axe-core: 0 violations)
- [x] `prefers-reduced-motion` respected
- [x] No horizontal scroll at 320px and up
- [x] Content-Security-Policy (meta + header), HSTS, nosniff, X-Frame-Options, Referrer-Policy, Permissions-Policy
- [x] Domain set to oslolights.com in all absolute URLs
- [ ] DNS for oslolights.com pointed at ardacloud
- [ ] Confirm headers arrived (securityheaders.com)
- [ ] HTTPS enforced on the host
- [ ] Submit sitemap in Google Search Console after launch
- [ ] Check share preview (e.g. opengraph.xyz) once live
- [ ] Optional: `/.well-known/security.txt` with a contact address
- [ ] Optional: privacy-friendly analytics (would need the CSP widened)
