#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT HUP INT TERM
fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }

check_agent() {
  agent=$1
  expected=$2
  home="$TMP/$agent-home"
  mkdir -p "$home"
  HOME="$home" "$ROOT/scripts/install.sh" --agent "$agent" --scope user --copy >/dev/null
  for skill in review-rewrite-content wtf-hook no-ai-slop tutur-jabodetabek-urban; do
    [ -f "$home/$expected/$skill/SKILL.md" ] || fail "$agent did not install $skill"
  done
  HOME="$home" "$ROOT/scripts/verify-install.sh" --agent "$agent" --scope user >/dev/null
  printf 'unrelated\n' > "$home/$expected/unrelated.txt"
  HOME="$home" "$ROOT/scripts/uninstall.sh" --agent "$agent" --scope user >/dev/null
  [ ! -e "$home/$expected/review-rewrite-content" ] || fail "$agent uninstall left files"
  [ -f "$home/$expected/unrelated.txt" ] || fail "$agent uninstall removed unrelated files"
}

check_agent claude .claude/skills
check_agent codex .codex/skills
check_agent cursor .cursor/skills
check_agent opencode .config/opencode/skills
check_agent copilot .copilot/skills
check_agent gemini .gemini/skills

home="$TMP/safety-home"
mkdir -p "$home/.claude/skills/wtf-hook"
printf 'user data\n' > "$home/.claude/skills/wtf-hook/keep.txt"
if HOME="$home" "$ROOT/scripts/install.sh" --agent claude --scope user --copy >/dev/null 2>&1; then
  fail "installer overwrote an unmanaged skill"
fi
[ -f "$home/.claude/skills/wtf-hook/keep.txt" ] || fail "unmanaged file was changed"

dry="$TMP/dry-home"
mkdir -p "$dry"
HOME="$dry" "$ROOT/scripts/install.sh" --agent codex --scope user --dry-run >/dev/null
[ ! -e "$dry/.codex" ] || fail "dry-run changed filesystem"

project="$TMP/project"
mkdir -p "$project"
HOME="$TMP/project-home" "$ROOT/scripts/install.sh" --agent gemini --scope project --prefix "$project" --copy >/dev/null
[ -f "$project/.gemini/skills/review-rewrite-content/SKILL.md" ] || fail "project scope ignored prefix"

modified="$TMP/modified-home"
mkdir -p "$modified"
HOME="$modified" "$ROOT/scripts/install.sh" --agent claude --scope user --copy >/dev/null
printf '\nlocal edit\n' >> "$modified/.claude/skills/no-ai-slop/SKILL.md"
if HOME="$modified" "$ROOT/scripts/uninstall.sh" --agent claude --scope user >"$TMP/modified.out" 2>&1; then
  fail "uninstall deleted a modified copied skill"
fi
grep -Eqi 'modified|backup|recover' "$TMP/modified.out" || fail "modified-install error lacks recovery guidance"
[ -f "$modified/.claude/skills/no-ai-slop/SKILL.md" ] || fail "modified skill was deleted"
[ -f "$modified/.claude/skills/wtf-hook/SKILL.md" ] || fail "uninstall partially deleted before detecting modification"

tampered="$TMP/tampered-home"
mkdir -p "$tampered"
HOME="$tampered" "$ROOT/scripts/install.sh" --agent codex --scope user --copy >/dev/null
sed -i '$d' "$tampered/.codex/skills/.jekardah-writer-install.tsv"
if HOME="$tampered" "$ROOT/scripts/uninstall.sh" --agent codex --scope user >/dev/null 2>&1; then
  fail "uninstall accepted a truncated manifest"
fi
[ -f "$tampered/.codex/skills/review-rewrite-content/SKILL.md" ] || fail "tampered manifest caused partial deletion"

forged="$TMP/forged-home"
mkdir -p "$forged"
HOME="$forged" "$ROOT/scripts/install.sh" --agent codex --scope user --copy >/dev/null
sed -i '2s#review-rewrite-content#../outside#' "$forged/.codex/skills/.jekardah-writer-install.tsv"
if HOME="$forged" "$ROOT/scripts/uninstall.sh" --agent codex --scope user >/dev/null 2>&1; then
  fail "uninstall accepted a forged manifest path"
fi
[ -f "$forged/.codex/skills/review-rewrite-content/SKILL.md" ] || fail "forged manifest caused deletion"

unsafe="$TMP/unsafe-home"
mkdir -p "$unsafe"
if HOME="$unsafe" "$ROOT/scripts/install.sh" --agent gemini --scope project --prefix "$unsafe/../escape" --copy >/dev/null 2>&1; then
  fail "installer accepted path traversal prefix"
fi
bad_prefix=$(printf '%s\nbreak' "$unsafe")
if HOME="$unsafe" "$ROOT/scripts/install.sh" --agent gemini --scope project --prefix "$bad_prefix" --copy >/dev/null 2>&1; then
  fail "installer accepted newline prefix"
fi

partial="$TMP/partial-home"
mkdir -p "$partial/.cursor/skills/wtf-hook"
printf 'existing\n' > "$partial/.cursor/skills/wtf-hook/user.txt"
if HOME="$partial" "$ROOT/scripts/install.sh" --agent cursor --scope user --copy >/dev/null 2>&1; then
  fail "installer accepted a partial pre-existing install"
fi
[ ! -e "$partial/.cursor/skills/no-ai-slop" ] || fail "failed preflight left a partial installation"
[ ! -e "$partial/.cursor/skills/.jekardah-writer-install.tsv" ] || fail "failed preflight left a manifest"

printf 'PASS: installer fixtures\n'
