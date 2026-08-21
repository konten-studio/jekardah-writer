# Storytelling Content Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add and integrate a truth-preserving `storytelling-content` skill across Jekardah Writer's canonical skills, orchestrator, installers, tests, and documentation.

**Architecture:** Keep narrative architecture in a standalone progressive-disclosure skill. Route it through `review-rewrite-content` before hook, anti-slop, and voice work only when narrative scope is active; preserve existing specialist ownership and repository installation conventions.

**Tech Stack:** Markdown skill instructions, YAML agent metadata, POSIX shell installers/tests, JSON plugin manifests, Codex skill validator.

---

## File Structure

- Create `skills/storytelling-content/SKILL.md`: operating workflow, modes, ownership, and output contract.
- Create `skills/storytelling-content/agents/openai.yaml`: UI metadata and default prompt.
- Create `skills/storytelling-content/references/*.md`: detailed story lock, frameworks, examples, and provenance.
- Modify `skills/review-rewrite-content/SKILL.md`: narrative routing, pipeline position, locks, handoffs, and QA.
- Modify `AGENTS.md`: route narrative review/rewrite through the orchestrator.
- Modify `scripts/install.sh`, `scripts/uninstall.sh`, and `scripts/verify-install.sh`: manage the fifth skill.
- Modify `tests/verify-repo.sh` and `tests/install-fixtures.sh`: enforce repository and install behavior.
- Modify `README.md` and plugin manifests: describe the expanded product accurately.

### Task 1: Add Failing Repository Contracts

**Files:**
- Modify: `tests/verify-repo.sh`
- Modify: `tests/install-fixtures.sh`

- [ ] **Step 1: Require the new canonical skill and orchestrator mode**

Add `storytelling-content` to the canonical skill loop, require
`story-structure-only`, reject the private source ebook, and require the new
reference structure.

- [ ] **Step 2: Require five-skill installation behavior**

Change fixture assertions from four installed skills to five and include
`storytelling-content` in every install, verify, manifest, and uninstall check.

- [ ] **Step 3: Run tests and verify the expected failure**

Run:

```bash
./tests/verify-repo.sh
```

Expected: failure reporting missing `skills/storytelling-content/SKILL.md` or
missing canonical skill.

### Task 2: Build The Canonical Storytelling Skill

**Files:**
- Create: `skills/storytelling-content/SKILL.md`
- Create: `skills/storytelling-content/agents/openai.yaml`
- Create: `skills/storytelling-content/references/story-lock.md`
- Create: `skills/storytelling-content/references/five-beat-spine.md`
- Create: `skills/storytelling-content/references/tension-detail-pacing.md`
- Create: `skills/storytelling-content/references/information-release.md`
- Create: `skills/storytelling-content/references/heia.md`
- Create: `skills/storytelling-content/references/delivery.md`
- Create: `skills/storytelling-content/references/repurposing.md`
- Create: `skills/storytelling-content/references/examples.md`
- Create: `skills/storytelling-content/references/provenance.md`

- [ ] **Step 1: Initialize the skill**

Run the system `init_skill.py` with `references` resources and explicit UI
metadata for `Storytelling Content`.

- [ ] **Step 2: Write the core instructions**

Define the five supported modes, story-lock-first workflow, narrative ownership,
composition contract, injection safety, progressive reference routing, and
output shapes. Keep the file below 500 lines.

- [ ] **Step 3: Write focused references**

Distill operational methods into original guidance. Use original examples and
explicit truth safeguards. Do not copy the ebook or rely on disputed science.

- [ ] **Step 4: Validate the skill**

Run:

```bash
python3 /home/ubuntu/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/storytelling-content
```

Expected: `Skill is valid!`

### Task 3: Integrate Narrative Routing Into The Orchestrator

**Files:**
- Modify: `skills/review-rewrite-content/SKILL.md`
- Modify: `AGENTS.md`

- [ ] **Step 1: Add routing and mode behavior**

Add `story-structure-only`, narrative detection under `auto`, review-only
story diagnosis, and conditional story execution under `end-to-end`.

- [ ] **Step 2: Extend locks, ownership, handoffs, and QA**

Add narrative facts, sequence, dialogue status, transformation, spine, tension,
and story-integrity fields. Put storytelling before hook work and forbid later
specialists from changing the locked narrative.

- [ ] **Step 3: Update repository-level agent routing**

Tell agents to load the orchestrator first for narrative review or rewrite and
retain canonical ownership in `skills/`.

- [ ] **Step 4: Run the repository contract**

Run `./tests/verify-repo.sh` and confirm the remaining failures concern
installer or documentation integration, not the canonical skill.

### Task 4: Integrate The Fifth Skill Into Installation Lifecycle

**Files:**
- Modify: `scripts/install.sh`
- Modify: `scripts/uninstall.sh`
- Modify: `scripts/verify-install.sh`

- [ ] **Step 1: Add the skill to every lifecycle loop**

Use the same ordered skill list in collision checks, cleanup, installation,
verification, and uninstall behavior.

- [ ] **Step 2: Update user-facing skill counts**

Replace hard-coded four-skill dry-run or status messages with accurate
five-skill wording.

- [ ] **Step 3: Run install fixtures**

Run:

```bash
./tests/install-fixtures.sh
```

Expected: all agent/scope/copy/symlink fixtures pass and cleanup leaves no
managed skill behind.

### Task 5: Synchronize Public Documentation And Plugin Metadata

**Files:**
- Modify: `README.md`
- Modify: `.codex-plugin/plugin.json`
- Modify: `.claude-plugin/plugin.json`
- Modify: `THIRD_PARTY_NOTICES.md` only if the existing notice structure needs a private-source provenance clarification.

- [ ] **Step 1: Document the fifth specialist**

Add it to the product table, audience/use cases, pipeline diagram, modes,
safety language, and source/provenance explanation.

- [ ] **Step 2: Update plugin descriptions and default prompts**

Mention story structure without overstating capability and keep manifest fields
within existing validation limits.

- [ ] **Step 3: Check formatting and placeholders**

Run:

```bash
git diff --check
rg -n '\[TODO|TODO:|YOUR[-_ ]|CHANGEME|example\.com' . -g '!tests/verify-repo.sh'
```

Expected: no whitespace errors and no placeholder matches.

### Task 6: Full Verification And Review

**Files:**
- Review all changed files.

- [ ] **Step 1: Run canonical validation**

Run:

```bash
./tests/verify-repo.sh
```

Expected: `PASS: repository contract`.

- [ ] **Step 2: Run installation validation**

Run:

```bash
./tests/install-fixtures.sh
```

Expected: fixture suite exits zero with all supported agents exercised.

- [ ] **Step 3: Inspect dry-run output**

Run:

```bash
./scripts/install.sh --agent codex --scope user --prefix /tmp/jekardah-writer-plan-check --dry-run
```

Expected: output explicitly says five skills.

- [ ] **Step 4: Review the final diff**

Run `git status --short`, `git diff --stat`, and `git diff --check`; confirm no
private ebook, machine-specific path, generated placeholder, or unrelated file
is included.
