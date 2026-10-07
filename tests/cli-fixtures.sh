#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
CLI="$ROOT/bin/cli.js"
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT HUP INT TERM
fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }

version=$(node -p "require('$ROOT/package.json').version")
[ "$(node "$CLI" --version)" = "$version" ] || fail "--version does not match package.json"
node "$CLI" list | grep -Fq 'no-ai-slop' || fail "list omitted no-ai-slop"

# install -> verify -> update -> uninstall round trip
home="$TMP/home"
mkdir -p "$home"
HOME="$home" node "$CLI" install --agent claude --scope user >/dev/null
HOME="$home" node "$CLI" verify --agent claude --scope user >/dev/null
HOME="$home" node "$CLI" update --agent claude --scope user | grep -Fq "v$version" || fail "update did not report version"
HOME="$home" node "$CLI" verify --agent claude --scope user >/dev/null
printf 'unrelated\n' > "$home/.claude/skills/unrelated.txt"
HOME="$home" node "$CLI" uninstall --agent claude --scope user >/dev/null
[ ! -e "$home/.claude/skills/no-ai-slop" ] || fail "uninstall left managed skills"
[ -f "$home/.claude/skills/unrelated.txt" ] || fail "uninstall removed unrelated files"

# update refuses to clobber local edits
edited="$TMP/edited"
mkdir -p "$edited"
HOME="$edited" node "$CLI" install --agent codex --scope user >/dev/null
printf '\nlocal edit\n' >> "$edited/.codex/skills/hook-gokil/SKILL.md"
if HOME="$edited" node "$CLI" update --agent codex --scope user >/dev/null 2>&1; then
  fail "update overwrote a modified skill"
fi
grep -Fq 'local edit' "$edited/.codex/skills/hook-gokil/SKILL.md" || fail "modified skill was lost"

# forged manifest target must never be deleted
forged="$TMP/forged"
mkdir -p "$forged/outside"
printf 'keep\n' > "$forged/outside/keep.txt"
HOME="$forged" node "$CLI" install --agent cursor --scope user >/dev/null
node -e '
const fs = require("fs");
const p = process.argv[1];
const m = JSON.parse(fs.readFileSync(p, "utf8"));
m.skills["no-ai-slop"].target = process.argv[2];
fs.writeFileSync(p, JSON.stringify(m));
' "$forged/.cursor/skills/.jekardah-writer-install.json" "$forged/outside"
if HOME="$forged" node "$CLI" uninstall --agent cursor --scope user >/dev/null 2>&1; then
  fail "uninstall accepted a forged manifest target"
fi
[ -f "$forged/outside/keep.txt" ] || fail "forged manifest caused deletion outside the skills dir"

# missing option value is an error, not a crash
if node "$CLI" install --agent >/dev/null 2>&1; then fail "accepted --agent without value"; fi

# Slop Radar
cat > "$TMP/slop.md" <<'MD'
Di era digital yang semakin berkembang pesat, personal branding merupakan salah satu hal penting.

```
di era digital
```

Bagaimana menurut kalian?
MD
out=$(node "$CLI" check "$TMP/slop.md")
printf '%s' "$out" | grep -Fq 'Canned opening' || fail "check missed canned opening"
printf '%s' "$out" | grep -Fq 'Generic CTA' || fail "check missed generic CTA"
[ "$(node "$CLI" check "$TMP/slop.md" --json | node -e 'let s="";process.stdin.on("data",d=>s+=d).on("end",()=>console.log(JSON.parse(s).findings.filter(f=>/era digital/i.test(f.match)).length))')" = 1 ] \
  || fail "check flagged text inside a code fence"
if node "$CLI" check - --min-score 90 < "$TMP/slop.md" >/dev/null; then fail "--min-score did not fail a sloppy draft"; fi

printf 'CV lo bilang strategic thinker. Feed LinkedIn lo isinya ucapan selamat pagi.\n' > "$TMP/clean.md"
node "$CLI" check "$TMP/clean.md" --min-score 90 >/dev/null || fail "clean draft failed --min-score"

printf 'PASS: cli fixtures\n'
