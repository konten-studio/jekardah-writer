#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$SCRIPT_DIR/path-lib.sh"
parse_location "$@"

validate_manifest
{
  IFS= read -r _header
  while IFS="$(printf '\t')" read -r skill target method expected; do
    [ -f "$target/SKILL.md" ] || { echo "Missing installed skill: $skill" >&2; exit 1; }
    actual=$(tree_digest "$target")
    [ "$actual" = "$expected" ] || { echo "Installed skill was modified: $skill" >&2; exit 1; }
    if [ "$method" = symlink ]; then [ -L "$target" ] || { echo "Expected symlink: $skill" >&2; exit 1; }; else [ ! -L "$target" ] || exit 1; fi
  done
} < "$MANIFEST"
printf 'Verified Jekardah Writer at %s\n' "$DEST"
