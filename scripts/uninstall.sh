#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$SCRIPT_DIR/path-lib.sh"
parse_location "$@"

validate_manifest

# Validate every entry before deleting any, so a damaged install cannot be half-removed.
{
  IFS= read -r _header
  while IFS="$(printf '\t')" read -r skill target _method expected; do
    actual=$(tree_digest "$target") || {
      echo "Installed skill is missing: $skill. Nothing was removed; restore from backup or move remaining files manually." >&2
      exit 1
    }
    [ "$actual" = "$expected" ] || {
      echo "Installed skill was modified: $skill. Nothing was removed. Back up your changes, then remove or reinstall manually." >&2
      exit 1
    }
  done
} < "$MANIFEST"

{
  IFS= read -r _header
  while IFS="$(printf '\t')" read -r _skill target _method _expected; do
  if [ -L "$target" ]; then
    unlink "$target"
  elif [ -d "$target" ]; then
    find "$target" -depth -delete
  fi
  done
} < "$MANIFEST"
unlink "$MANIFEST"
printf 'Uninstalled Jekardah Writer from %s\n' "$DEST"
