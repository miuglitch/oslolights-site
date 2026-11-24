#!/usr/bin/env bash
# Point every absolute URL (canonical, share cards, sitemap, robots, 404 base) at the live address.
# Usage: scripts/set-domain.sh https://oslolights.com/
set -euo pipefail
new="${1:?Give the site URL, ending in a slash, e.g. https://oslolights.com/}"
[[ "$new" == */ ]] || new="$new/"
cd "$(dirname "$0")/.."
old=$(grep -o '<link rel="canonical" href="[^"]*"' index.html | sed 's/.*href="//;s/"$//')
for f in index.html 404.html robots.txt sitemap.xml; do
  sed -i.bak "s#${old}#${new}#g" "$f" && rm "$f.bak"
done
echo "Site URL: $old -> $new"
