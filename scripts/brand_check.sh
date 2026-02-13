#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

required_files=(
  "Logo/SVG/GRD--1 light background.svg"
  "Logo/SVG/GRD--1 dark background.svg"
  "Logo/SVG/GRD--2 dark background.svg"
  "Logo/SVG/SLD--1 light background.svg"
  "Logo/SVG/SLD--2 dark background.svg"
  "Logo/SVG/SLD--3 light background.svg"
  "Logo/PNG/GRD--1 light background.png"
  "Logo/PNG/GRD--1 dark background.png"
  "Logo/PNG/GRD--2 dark background.png"
  "Logo/PNG/SLD--1 light background.png"
  "Logo/PNG/SLD-1 dark background.png"
  "Logo/PNG/SLD--2 dark background.png"
  "Logo/PNG/SLD--3 light background.png"
  "Symbol/SVG/GRD -- 1.svg"
  "Symbol/SVG/GRD -- 2.svg"
  "Symbol/SVG/SLD -- 1.svg"
  "Symbol/SVG/SLD -- 2.svg"
  "Symbol/SVG/SLD -- 3.svg"
  "Symbol/PNG/GRD--1.png"
  "Symbol/PNG/GRD--2.png"
  "Symbol/PNG/SLD--1.png"
  "Symbol/PNG/SLD--2.png"
  "Symbol/PNG/SLD--3.png"
)

for f in "${required_files[@]}"; do
  [[ -f "$f" ]] || fail "Missing required asset: $f"
done

# Ensure both GRD and SLD variants exist for SVG/PNG in both mark families.
for dir in Logo Symbol; do
  for fmt in SVG PNG; do
    ls "$dir/$fmt"/*GRD* >/dev/null 2>&1 || fail "Missing GRD variant in $dir/$fmt"
    ls "$dir/$fmt"/*SLD* >/dev/null 2>&1 || fail "Missing SLD variant in $dir/$fmt"
  done
done

# Enforce no live external links in SVGs and no text nodes in deliverables.
while IFS= read -r -d '' svg; do
  grep -Eiq '(xlink:href|href)="https?://' "$svg" && fail "External URL found in SVG: $svg"
  grep -Eiq '<text[[:space:]>]' "$svg" && fail "Text node found in SVG (outline text before export): $svg"
done < <(find Logo/SVG Symbol/SVG -type f -name '*.svg' -print0)

# Ensure PNG widths meet minimum export width and keep alpha channel.
while IFS= read -r -d '' png; do
  meta="$(file "$png")"
  dims="$(printf '%s\n' "$meta" | sed -nE 's/.* ([0-9]+) x ([0-9]+).*/\1 \2/p')"
  [[ -n "$dims" ]] || fail "Could not parse dimensions for $png"
  width="${dims%% *}"
  (( width >= 768 )) || fail "PNG width below 768px: $png (${width}px)"
  printf '%s\n' "$meta" | grep -Eq 'RGBA|LA' || fail "PNG is missing alpha channel: $png"
done < <(find Logo/PNG Symbol/PNG -type f -name '*.png' -print0)

echo "Brand checks passed."
