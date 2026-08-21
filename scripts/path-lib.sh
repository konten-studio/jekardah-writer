#!/bin/sh

validate_base() {
  case "$1" in
    /*) ;;
    *) echo "Prefix must be an absolute path" >&2; exit 2 ;;
  esac
  case "$1" in
    *'/../'*|*/..|*'/./'*|*/.) echo "Unsafe prefix: path traversal segments are not allowed" >&2; exit 2 ;;
  esac
  if [ "$(printf '%s' "$1" | wc -l | tr -d ' ')" -ne 0 ] || printf '%s' "$1" | grep "$(printf '\t')" >/dev/null; then
    echo "Unsafe prefix: control characters are not allowed" >&2
    exit 2
  fi
}

tree_digest() {
  directory=$1
  [ -d "$directory" ] || return 1
  (
    cd "$directory"
    find . -type f -print | LC_ALL=C sort | while IFS= read -r file; do
      printf '%s\t' "$file"
      sha256sum "$file" | awk '{print $1}'
    done
  ) | sha256sum | awk '{print $1}'
}

validate_manifest() {
  [ -f "$MANIFEST" ] || { echo "Installation manifest not found: $MANIFEST" >&2; return 1; }
  awk -F '\t' -v dest="$DEST" -v agent="$AGENT" -v scope="$SCOPE" '
    NR == 1 {
      if (NF != 4 || $1 != "jekardah-writer-v1" || $2 != agent || $3 != scope || ($4 != "copy" && $4 != "symlink")) exit 10
      method=$4; next
    }
    NF != 4 { exit 11 }
    $1 !~ /^(review-rewrite-content|storytelling-content|hook-gokil|wtf-hook|no-ai-slop|tutur-jabodetabek-urban)$/ { exit 12 }
    seen[$1]++ != 0 { exit 13 }
    $2 != dest "/" $1 { exit 14 }
    $3 != method { exit 15 }
    $4 !~ /^[0-9a-f]{64}$/ { exit 16 }
    END {
      if (NR != 6) exit 17
      if (!seen["review-rewrite-content"] || !seen["storytelling-content"] || !seen["no-ai-slop"] || !seen["tutur-jabodetabek-urban"]) exit 18
      if ((seen["hook-gokil"] ? 1 : 0) + (seen["wtf-hook"] ? 1 : 0) != 1) exit 19
    }
  ' "$MANIFEST" || {
    echo "Installation manifest is malformed or tampered; nothing was removed. Restore it from a trusted backup or reinstall to a clean prefix." >&2
    return 1
  }
}

parse_location() {
  AGENT=
  SCOPE=user
  PREFIX=
  while [ "$#" -gt 0 ]; do
    case "$1" in
      --agent) AGENT=$2; shift 2 ;;
      --scope) SCOPE=$2; shift 2 ;;
      --prefix) PREFIX=$2; shift 2 ;;
      *) echo "Unknown option: $1" >&2; exit 2 ;;
    esac
  done
  [ -n "$AGENT" ] || { echo "--agent is required" >&2; exit 2; }
  if [ "$SCOPE" = user ]; then
    base=${PREFIX:-$HOME}
    case "$AGENT" in
      claude) rel=.claude/skills ;; codex) rel=.codex/skills ;; cursor) rel=.cursor/skills ;;
      opencode) rel=.config/opencode/skills ;; copilot) rel=.copilot/skills ;; gemini) rel=.gemini/skills ;;
      *) echo "Unsupported agent: $AGENT" >&2; exit 2 ;;
    esac
  elif [ "$SCOPE" = project ]; then
    base=${PREFIX:-$(pwd)}
    case "$AGENT" in
      claude) rel=.claude/skills ;; codex) rel=.agents/skills ;; cursor) rel=.cursor/skills ;;
      opencode) rel=.opencode/skills ;; copilot) rel=.github/skills ;; gemini) rel=.gemini/skills ;;
      *) echo "Unsupported agent: $AGENT" >&2; exit 2 ;;
    esac
  else
    echo "Unsupported scope: $SCOPE" >&2; exit 2
  fi
  validate_base "$base"
  DEST=$base/$rel
  MANIFEST=$DEST/.jekardah-writer-install.tsv
}
