#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version-tag>" >&2
  echo "Example: $0 v1.0.0" >&2
  exit 1
fi

version_tag="$1"
package_name="ipxo-brand-${version_tag}"
output_dir="dist"
output_zip="${output_dir}/${package_name}.zip"

mkdir -p "$output_dir"
rm -f "$output_zip"
stage_dir="$(mktemp -d "${TMPDIR:-/tmp}/${package_name}.XXXXXX")"
trap 'rm -rf "$stage_dir"' EXIT

mkdir -p "$stage_dir/$package_name"
cp -R Logo Symbol "$stage_dir/$package_name/"
cp README.md BRAND_GUIDELINES.md TRADEMARK.md LICENSE "$stage_dir/$package_name/"
find "$stage_dir/$package_name" -name '.DS_Store' -delete

(
  cd "$stage_dir"
  zip -rq "$OLDPWD/$output_zip" "$package_name"
)

echo "Created $output_zip"
