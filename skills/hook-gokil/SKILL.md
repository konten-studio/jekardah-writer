---
name: hook-gokil
description: Use when a draft, script, post, carousel, thread, headline, or content idea needs a stronger Indonesian or multilingual opening, multiple stop-scroll hook options, a WTF or killer hook, hook diagnosis, candidate selection, or a truth-preserving rewrite.
---

# Hook Gokil

Create cognitive dissonance without breaking the content's factual contract. A strong hook makes the audience ask "kok bisa?"; the body must answer honestly.

## Load only what you need

- Read [references/framework.md](references/framework.md) for the full analysis, generation, scoring, and rewrite method.
- Read [references/types.md](references/types.md) when choosing among the 15 WTF/killer hook types or three emotional pillars.
- Read [references/examples.md](references/examples.md) for calibrated Indonesian examples, unsafe-to-safe repairs, and output shapes.
- Read [references/provenance.md](references/provenance.md) only when auditing the skill's design influences. Do not load `evals/` during normal use; it contains maintainer evaluation artifacts, not operating instructions.
- Use the distilled files in `references/` for the framework, hook types, examples, and provenance. The private source material is intentionally not bundled with this public skill.

## Non-negotiable truth contract

Treat the source draft/context as the claim ceiling.

1. Lock facts before ideation: names, numbers, dates, scope, evidence level, causal direction, quotes, and stated outcomes.
2. Never invent proof, precision, authority, consensus, urgency, scarcity, or personal experience.
3. Never upgrade anecdote to science, correlation to causation, possibility to certainty, or one case to a universal rule.
4. Use only a contradiction the body can resolve. If payoff is missing, weaken the hook or ask for evidence; do not manufacture a payoff.
5. Preserve the author's factual meaning even when rewriting the whole draft.

If the user requests an unsupported claim, decline that claim briefly and offer the strongest accurate alternative. "Killer" describes attention strength, not permission to deceive.

## Core workflow

1. **Parse the request.** Identify deliverable, platform if supplied, language/register, audience, topic, desired outcome, and whether the user wants analysis, candidates, selection, a hook rewrite, or a whole-draft rewrite. Ask only when a missing fact would materially change the result.
2. **Build a fact lock.** Separate supported facts, opinions/interpretations, unknowns, and forbidden upgrades. Preserve exact numbers unless rounding is explicitly allowed.
3. **Extract depth.** Move from feature/topic to benefit or pain, then ask "so what?" until reaching a defensible human meaning. Do not turn a plausible scenario into an asserted event.
4. **Choose angles.** Select 3-5 suitable types from [references/types.md](references/types.md). Prefer variety over cosmetic paraphrases. Skip any type that requires unavailable proof.
5. **Generate.** Unless the user specifies a count, produce 6 candidates across at least 3 types and at least 2 emotional pillars. Put the strongest concrete or disruptive words early. Write natural Indonesian; use English/code-mixing only when it matches the source or requested voice.
6. **Stress-test.** Apply the body-payoff, fact-lock, specificity, first-words, clarity, and curiosity checks in [references/framework.md](references/framework.md). Repair or discard failures.
7. **Select.** Score viable candidates, choose one strongest hook, name its type, and explain in 1-3 sentences why it wins and how the body pays it off. Accuracy is a gate, not a weighted tradeoff.
8. **Rewrite only the requested scope.** If asked for one hook, do not rewrite the body. If asked for the whole draft, place the selected hook first and reshape the body so it closes the exact curiosity gap without adding claims.

## Default output

For candidate requests, return:

1. A short factual boundary only if needed.
2. Numbered candidates with type labels.
3. `Pilihan terkuat:` followed by one hook.
4. A concise reason and payoff note.

For analysis-only requests, diagnose the current hook, identify the missed meaning/angle, and propose focused repairs. Do not rewrite unless asked.

## Composition contract

When an orchestrating skill combines `hook-gokil` with tone, platform, translation, or anti-slop skills, use this contract:

- **Input owned by orchestrator:** source draft/context, fact lock, audience/platform constraints, requested output scope, and style instructions.
- **This skill owns:** hook angle, type, emotional pillar, candidate set, ranking, selected hook, and the explicit body-payoff obligation.
- **This skill returns:** `fact_lock`, `candidates`, `selected_hook`, `selection_reason`, `payoff_required`, and `rewrite_scope` in prose or the orchestrator's requested schema.
- **Later style passes may change:** diction, rhythm, sentence length, code-mixing, punctuation, and non-factual transitions.
- **Later style passes must not change:** facts, numbers, evidence level, certainty, causality, attribution, quoted meaning, selected angle, or payoff obligation.
- **Conflict order:** factual intent and safety > user scope > hook logic/payoff > platform constraints > tone > anti-slop polish.
- **Final gate:** compare the composed output against `fact_lock`; if style weakens clarity or changes a claim, restore the locked meaning and re-polish locally.

Do not silently overwrite another skill's factual interpretation. Surface conflicts to the orchestrator and provide a safe variant.

## Quality floor

Reject or revise hooks that are generic, interchangeable, front-loaded with filler, dependent on an unsupported superlative, aimed at the wrong audience, or impossible for the body to repay. Prefer a strong killer hook over a fake WTF hook.
