#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
AGENT=
SCOPE=user
PREFIX=
METHOD=symlink
DRY_RUN=0

usage() {
  echo "Usage: install.sh --agent AGENT [--scope user|project] [--prefix DIR] [--copy|--symlink] [--dry-run]"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --agent) [ "$#" -ge 2 ] || { usage >&2; exit 2; }; AGENT=$2; shift 2 ;;
    --scope) [ "$#" -ge 2 ] || { usage >&2; exit 2; }; SCOPE=$2; shift 2 ;;
    --prefix) [ "$#" -ge 2 ] || { usage >&2; exit 2; }; PREFIX=$2; shift 2 ;;
    --copy) METHOD=copy; shift ;;
    --symlink) METHOD=symlink; shift ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
done

[ -n "$AGENT" ] || { echo "--agent is required" >&2; exit 2; }
case "$SCOPE" in user|project) ;; *) echo "Unsupported scope: $SCOPE" >&2; exit 2 ;; esac

if [ "$SCOPE" = user ]; then
  base=${PREFIX:-$HOME}
  case "$AGENT" in
    claude) rel=.claude/skills ;;
    codex) rel=.codex/skills ;;
    cursor) rel=.cursor/skills ;;
    opencode) rel=.config/opencode/skills ;;
    copilot) rel=.copilot/skills ;;
    gemini) rel=.gemini/skills ;;
    *) echo "Unsupported agent: $AGENT" >&2; exit 2 ;;
  esac
else
  base=${PREFIX:-$(pwd)}
  case "$AGENT" in
    claude) rel=.claude/skills ;;
    codex) rel=.agents/skills ;;
    cursor) rel=.cursor/skills ;;
    opencode) rel=.opencode/skills ;;
    copilot) rel=.github/skills ;;
    gemini) rel=.gemini/skills ;;
    *) echo "Unsupported agent: $AGENT" >&2; exit 2 ;;
  esac
fi

case "$base" in /*) ;; *) echo "Prefix must be an absolute path" >&2; exit 2 ;; esac
case "$base" in *'/../'*|*/..|*'/./'*|*/.) echo "Unsafe prefix: path traversal segments are not allowed" >&2; exit 2 ;; esac
if [ "$(printf '%s' "$base" | wc -l | tr -d ' ')" -ne 0 ] || printf '%s' "$base" | grep "$(printf '\t')" >/dev/null; then
  echo "Unsafe prefix: control characters are not allowed" >&2
  exit 2
fi

dest=$base/$rel
manifest=$dest/.jekardah-writer-install.tsv
for skill in review-rewrite-content wtf-hook no-ai-slop tutur-jabodetabek-urban; do
  target=$dest/$skill
  [ ! -e "$target" ] && [ ! -L "$target" ] || {
    echo "Refusing to overwrite existing path: $target" >&2
    exit 1
  }
done

if [ "$DRY_RUN" -eq 1 ]; then
  printf 'Would install four skills to %s using %s\n' "$dest" "$METHOD"
  exit 0
fi

mkdir -p "$dest"
manifest_tmp=$dest/.jekardah-writer-install.$$.tmp
: > "$manifest_tmp"
printf 'jekardah-writer-v1\t%s\t%s\t%s\n' "$AGENT" "$SCOPE" "$METHOD" >> "$manifest_tmp"
complete=0
cleanup_partial() {
  [ "$complete" -eq 1 ] && return
  for owned_skill in review-rewrite-content wtf-hook no-ai-slop tutur-jabodetabek-urban; do
    owned_target=$dest/$owned_skill
    if [ -L "$owned_target" ]; then unlink "$owned_target"; elif [ -d "$owned_target" ]; then find "$owned_target" -depth -delete; fi
  done
  [ ! -f "$manifest_tmp" ] || unlink "$manifest_tmp"
}
trap cleanup_partial EXIT HUP INT TERM
for skill in review-rewrite-content wtf-hook no-ai-slop tutur-jabodetabek-urban; do
  source=$ROOT/skills/$skill
  target=$dest/$skill
  if [ "$METHOD" = copy ]; then
    cp -R "$source" "$target"
  else
    ln -s "$source" "$target"
  fi
  digest=$(
    cd "$target"
    find . -type f -print | LC_ALL=C sort | while IFS= read -r file; do
      printf '%s\t' "$file"
      sha256sum "$file" | awk '{print $1}'
    done | sha256sum | awk '{print $1}'
  )
  printf '%s\t%s\t%s\t%s\n' "$skill" "$target" "$METHOD" "$digest" >> "$manifest_tmp"
done
mv "$manifest_tmp" "$manifest"
complete=1
trap - EXIT HUP INT TERM
printf 'Installed Jekardah Writer for %s (%s) at %s\n' "$AGENT" "$SCOPE" "$dest"
