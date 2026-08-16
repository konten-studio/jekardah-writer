# Workflow and Evaluation

## Contents

- Fact lock
- Feature to meaning
- Candidate generation
- Accuracy gate
- Scoring and selection
- Rewrite modes
- Indonesian language guidance

## Fact lock

Create a compact internal ledger before writing:

| Class | Capture | Constraint |
|---|---|---|
| Hard facts | names, numbers, dates, duration, result | Preserve exactly unless user permits transformation |
| Evidence | anecdote, measured experiment, cited study, expert quote | Never promote evidence level |
| Relationship | sequence, correlation, claimed cause | Preserve causal strength |
| Interpretation | opinion, lesson, belief | Attribute it; do not present as universal fact |
| Unknown | missing mechanism, benchmark, source, payoff | Ask, omit, or phrase as an open question |

Forbidden upgrades include `terasa lebih fokus` -> `produktivitas naik 2x`, one creator -> `semua creator`, five days -> `terbukti`, and an uncited estimate -> an exact statistic.

## Feature to meaning

Use the e-book's `FITUR -> BENEFIT/PAIN -> MEANING` ladder.

1. State the visible topic or event.
2. Ask `so what?` from the audience's perspective.
3. Repeat until reaching a concrete consequence tied to a basic human concern: safety/health, appetite, rest, money/status, mortality, relationship, family, or importance/identity.
4. Mark each consequence as explicit, logically necessary, plausible, or speculative.
5. Build assertive hooks only from explicit or logically supported material. Use questions or conditional language for plausible material. Drop speculative material.

The ladder discovers an angle; it does not license fictional escalation.

## Candidate generation

Generate breadth before polish:

- Map the context to 3-5 types in [types.md](types.md).
- Cover at least two of gain, pain, and curiosity.
- Vary the logic, not merely synonyms.
- Prefer concrete nouns, active verbs, real constraints, and available specifics.
- Put the strongest meaningful phrase in the opening words when natural.
- Avoid throat-clearing such as `Di era sekarang`, `Tahukah kamu`, or `Dalam dunia yang serba...`.

Default batch: six options across at least three types. For a large requested batch, maintain type diversity and flag any candidate that needs evidence before publishing.

## Accuracy gate

Every candidate must pass all six checks:

1. **Entailment:** Does the source support the literal claim?
2. **Evidence parity:** Does the wording preserve anecdotal, measured, quoted, or scientific status?
3. **Scope parity:** Does it preserve who, when, how much, and under what conditions?
4. **Causality parity:** Does it avoid adding causal certainty?
5. **Payoff:** Can the existing or rewritten body resolve the surprise directly?
6. **Attribution:** Are opinions, quotes, and third-party claims assigned correctly?

One failure disqualifies the candidate until repaired. Accuracy is not offset by virality.

## Scoring and selection

Score only candidates that pass the accuracy gate, from 1-5:

| Criterion | Question |
|---|---|
| Stop power | Does it interrupt expectation quickly? |
| Curiosity tension | Is there a specific gap the body can close? |
| Relevance | Will the intended audience recognize the stakes? |
| Specificity | Does it use concrete available detail? |
| Clarity | Is it understood on first read? |
| Voice fit | Does it sound native to the creator and language? |
| Payoff fit | Does the draft deliver exactly what is implied? |

Prefer the highest total. Break ties with payoff fit, then clarity, then stop power. Do not show the full table unless useful; give a brief reason by default.

Run a first-words test: isolate roughly the first 3-5 words. Remove filler if those words carry no tension, relevance, or specificity. Do not force awkward syntax merely to pass this test.

## Rewrite modes

### Hook only

Return candidates or the selected replacement. Leave the body untouched. Mention a payoff mismatch if the existing body cannot support the requested angle.

### Hook plus opening

Rewrite the hook and enough setup to establish the promised context. Preserve the remainder unless asked.

### Whole draft

1. Lock facts.
2. Select the hook.
3. Place the hook first.
4. Reorder existing material to explain the contradiction promptly.
5. Close the open loop with proof, mechanism, lesson, or limitation present in the source.
6. Remove repeated setup and generic transitions.
7. Run a sentence-level fact-lock diff in meaning, not just wording.

If a headline is intentionally compressed, ensure the first body lines restore any necessary qualifier before a reasonable reader could be misled.

## Indonesian language guidance

- Default to the source's `aku/saya/gue` and `kamu/Anda/lu`; do not mix pronoun systems accidentally.
- Favor spoken Indonesian rhythm for social content, but keep formal register for professional or institutional contexts.
- Use code-mixing only when it feels native to the requested persona. English is not automatically punchier.
- Preserve Indonesian number and currency conventions from the source (`Rp180 ribu`, not a newly rounded `Rp200 ribu`).
- Avoid translated-English scaffolding, excessive em dashes, paired abstractions, and inflated words such as `revolusioner`, `game-changer`, or `mengubah segalanya` without support.
- A fragment may work as a hook if clear; the body must still repay it.
