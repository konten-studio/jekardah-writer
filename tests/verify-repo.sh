#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
fail() { printf 'FAIL: %s\n' "$*" >&2; exit 1; }

for file in \
  .codex-plugin/plugin.json .claude-plugin/plugin.json \
  README.md LICENSE AGENTS.md \
  scripts/install.sh scripts/uninstall.sh scripts/verify-install.sh; do
  [ -f "$ROOT/$file" ] || fail "missing $file"
done

for skill in review-rewrite-content wtf-hook no-ai-slop tutur-jabodetabek-urban; do
  [ -f "$ROOT/skills/$skill/SKILL.md" ] || fail "missing canonical skill $skill"
done

for script in install.sh uninstall.sh verify-install.sh; do
  [ -x "$ROOT/scripts/$script" ] || fail "scripts/$script is not executable"
done

for mode in auto review-only hook-only anti-slop-only voice-only end-to-end; do
  grep -Fq "$mode" "$ROOT/skills/review-rewrite-content/SKILL.md" || fail "missing mode $mode"
done

for heading in "Masalah" "Solusi" "Before" "After" "Cocok Buat Siapa" "Cara Kerja" "Mode" "Kompatibilitas" "Instalasi" "Safety" "Atribusi" "Lisensi"; do
  grep -Fqi "$heading" "$ROOT/README.md" || fail "README missing section: $heading"
done

if rg -n '\[TODO|TODO:|YOUR[-_ ]|CHANGEME|example\.com' "$ROOT" \
  -g '!tests/verify-repo.sh' -g '!*.md~' >/dev/null; then
  fail "placeholder text found"
fi

python3 -m json.tool "$ROOT/.codex-plugin/plugin.json" >/dev/null
python3 -m json.tool "$ROOT/.claude-plugin/plugin.json" >/dev/null
python3 - "$ROOT/.codex-plugin/plugin.json" <<'PY'
import json, sys
data = json.load(open(sys.argv[1]))
prompts = data.get("interface", {}).get("defaultPrompt")
assert isinstance(prompts, list), "Codex interface.defaultPrompt must be an array"
assert 1 <= len(prompts) <= 3, "Codex defaultPrompt must contain 1-3 prompts"
assert all(isinstance(p, str) and 0 < len(p) <= 128 for p in prompts)
PY

[ ! -e "$ROOT/skills/wtf-hook/E-book WTF HOOK.md" ] || fail "source ebook must not be published"
if find "$ROOT/skills/wtf-hook" -type f -size +250k | grep -q .; then
  fail "unexpected large source artifact in wtf-hook"
fi
if rg -n '/home/|/Users/|ai-builders-id-kelas-agent|documents/\[2\] Areas/konten-studio-skills' \
  "$ROOT" -g '!tests/verify-repo.sh' >/dev/null; then
  fail "private or machine-specific content found"
fi

VALIDATOR=${SKILL_VALIDATOR:-$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py}
[ -f "$VALIDATOR" ] || fail "set SKILL_VALIDATOR to quick_validate.py"
for skill in "$ROOT"/skills/*; do
  python3 "$VALIDATOR" "$skill" >/dev/null || fail "skill validation failed: $skill"
done

printf 'PASS: repository contract\n'
