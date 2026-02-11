#!/usr/bin/env bash
set -u

# Files to include in the zip. Edit this list as needed.
FILES=(
  "Assembled.qlab5"
  "Assembled.esf3d"
  "Lines"
  "SFX"
)

ARCHIVE_DIR="Archive"

if [[ ! -d "$ARCHIVE_DIR" ]]; then
  mkdir -p "$ARCHIVE_DIR"
fi

existing_files=()
missing_files=()
for file in "${FILES[@]}"; do
  if [[ -e "$file" ]]; then
    existing_files+=("$file")
  else
    missing_files+=("$file")
  fi
done

if [[ ${#missing_files[@]} -gt 0 ]]; then
  echo "Warning: missing files (skipping):" >&2
  for file in "${missing_files[@]}"; do
    echo "  - $file" >&2
  done
fi

if [[ ${#existing_files[@]} -eq 0 ]]; then
  echo "No files to zip. Exiting." >&2
  exit 1
fi

zip_name="archive_$(date +"%Y%m%d_%H%M%S").zip"
zip_path="$ARCHIVE_DIR/$zip_name"

zip -r "$zip_path" "${existing_files[@]}" -x "**/.DS_Store"

echo "Created $zip_path"
