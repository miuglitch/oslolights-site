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
| `_headers` | Security and cache headers for Netlify or Cloudflare Pages. |

## Swapping the logo (SVG or Lottie)

The logo lives inside `<h1 class="logo">` in `index.html`.

- **SVG:** drop the file in `assets/logo/`, replace the `<picture>` with `<img src="assets/logo/logo.svg" alt="Oslo Lights">`, and set `--logo-src` at the top of `assets/css/style.css` to the same file so the glitch layers match. If the SVG has a different shape, update `aspect-ratio` on `.logo`.
- **Lottie:** add the player script to `assets/js/`, put the player element inside `.logo`, and add the class `logo--lottie` to the `<h1>` (this turns off the CSS glitch copies). Keep a visually hidden "Oslo Lights" text in the `<h1>` for screen readers and search.

Remember to also refresh the preload line for the logo in `<head>`.

## Changing the domain

All absolute URLs (canonical, share cards, structured data, sitemap, robots, 404 base) point to `https://miuglitch.github.io/oslolights-site/` for now. When a domain is ready:

```sh
scripts/set-domain.sh https://oslolights.com/
```

## Hosting

- **GitHub Pages:** Settings > Pages > Deploy from branch `main`, folder `/`. Works as is. GitHub Pages can't send custom headers, so the page carries its CSP and referrer policy as `<meta>` tags; HSTS and frame protection need a host that supports headers (or Cloudflare in front).
- **Netlify / Cloudflare Pages:** point at the repo with no build command and output folder `/`. `_headers` is picked up automatically and adds CSP, HSTS, nosniff, frame and referrer policies and long caching for images and fonts.

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
- [ ] Domain bought and `scripts/set-domain.sh` run
- [ ] HTTPS enforced on the host
- [ ] Submit sitemap in Google Search Console after launch
- [ ] Check share preview (e.g. opengraph.xyz) once live
- [ ] Optional: `/.well-known/security.txt` with a contact address
- [ ] Optional: privacy-friendly analytics (would need the CSP widened)
