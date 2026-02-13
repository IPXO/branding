# IPXO Brand Guidelines

This document defines public-facing usage and export requirements for assets in
this repository.

## Scope

- Canonical asset directories: `Logo/` and `Symbol/`
- Supported distribution formats in this repo: `SVG`, `PNG`, `Print` (PDF)
- Existing file paths are intentionally preserved for compatibility.

## Approved Variants

Current naming uses these prefixes:
- `GRD` for gradient/full-color variants
- `SLD` for single-color variants

For each mark family (`Logo`, `Symbol`), maintain both `GRD` and `SLD` variants
in `SVG` and `PNG` formats.

## Export Requirements

- Outline all text before export (no editable text objects in deliverable SVG/PDF).
- Do not embed external resources or remote links in SVG files.
- PNG exports for logo assets must be at least `768px` wide.
- Keep transparent backgrounds for logo/symbol PNG exports unless explicitly
  required otherwise.
- Keep master proportions unchanged and export at source aspect ratio.

## Color and Modification Rules

- Use only approved provided files for production usage.
- Do not alter hue, saturation, gradients, or opacity of official marks.
- Do not add effects (shadows, glows, outlines, warping, skewing).

## Placement

- Ensure clear space around the logo/symbol and avoid crowding.
- Ensure sufficient contrast against the background.
- Prefer the variant intended for light or dark backgrounds where provided.

## Website and Social Usage

- Prefer SVG on web where possible.
- Use PNG where platform upload workflows do not accept SVG.
- Keep a high-resolution source; do not upscale low-resolution exports.

## Release Packaging Standard

Published brand-pack releases include:
- `Logo/`
- `Symbol/`
- `README.md`
- `BRAND_GUIDELINES.md`
- `TRADEMARK.md`
- `LICENSE`
