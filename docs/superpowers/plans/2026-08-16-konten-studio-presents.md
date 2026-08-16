# Konten Studio Presents Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a small, centered Konten Studio attribution immediately above the Jekardah Writer ASCII wordmark in the README.

**Architecture:** Store the supplied logo as a repository-local PNG under `assets/` so the README does not depend on an external URL. Use GitHub-compatible inline HTML inside the existing centered container, leaving the ASCII wordmark and all other content unchanged.

**Tech Stack:** GitHub-flavored Markdown, inline HTML, PNG

---

### Task 1: Add the attribution asset and markup

**Files:**
- Create: `assets/konten-studio-logo.png`
- Modify: `README.md:1`

- [x] **Step 1: Copy the supplied logo into the repository**

Run:

```bash
mkdir -p assets
cp ../../../../../downloads/konten-studio-logo-5a@512.png assets/konten-studio-logo.png
```

Expected: `assets/konten-studio-logo.png` exists as a 512 x 512 RGBA PNG.

- [x] **Step 2: Add the centered inline attribution above the ASCII wordmark**

Insert immediately after `<div align="center">`:

```html
<p><img src="assets/konten-studio-logo.png" width="18" alt="Konten Studio logo"> <sub>konten.studio presents</sub></p>
```

Expected: the attribution appears on one centered row and the existing ASCII block remains unchanged.

- [x] **Step 3: Verify the repository**

Run:

```bash
./tests/verify-repo.sh
git diff --check
git status --short
```

Expected: the verification script and whitespace check pass; Git reports only the intended README, logo, and plan changes.

- [x] **Step 4: Commit the implementation**

```bash
git add README.md assets/konten-studio-logo.png docs/superpowers/plans/2026-08-16-konten-studio-presents.md
git commit -m "docs: add Konten Studio README attribution"
```

Expected: Git creates one commit containing the local logo, README attribution, and implementation plan.
