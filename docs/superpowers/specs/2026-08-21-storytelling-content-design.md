# Storytelling Content Design

## Goal

Add a canonical `storytelling-content` skill to Jekardah Writer that turns
facts, experiences, notes, or drafts into an honest narrative structure without
inventing events, dialogue, motives, evidence, or causal certainty.

## Scope

The skill owns narrative architecture: story spine, transformation, causal
chain, scene detail, tension, information release, pacing, payoff, delivery
notes, and format or angle repurposing. It does not own final hook selection,
generic-prose cleanup, or Jabodetabek register adaptation.

`hook-gokil` continues to own the opening angle and explicit payoff obligation.
`no-ai-slop` continues to own prose repair. `tutur-jabodetabek-urban` continues
to own local register. `review-rewrite-content` owns routing, handoffs, and final
integrity.

The private source ebook will not be copied into the repository. The skill will
contain an original, compact distillation of operational methods plus a
provenance note.

## Inputs And Modes

Accept one or more of these inputs:

- a factual experience or event;
- rough notes or an interview transcript;
- an existing content draft;
- a topic plus supplied facts;
- one story that must be adapted into other formats or angles.

Support these modes:

- `outline-only`: produce a story spine without drafting prose;
- `story-structure-only`: restructure narrative order while preserving the
  supplied wording where practical;
- `story-rewrite`: write or rewrite the full narrative within the story lock;
- `delivery-notes`: annotate an existing script for pace, pauses, emphasis, and
  energy without changing its factual content;
- `repurpose`: transform one locked story into requested formats or angles.

When the request is only a review or diagnosis, do not mutate the source.

## Story Lock

Before generating or restructuring, classify the supplied material as:

- verified event, sequence, person, time, place, number, or result;
- attributed statement or remembered dialogue;
- paraphrase;
- author interpretation or lesson;
- known motive or internal state;
- uncertain, missing, or disputed detail;
- forbidden upgrade.

The skill must never turn reconstructed dialogue into a verbatim quote, an
assumption into a known motive, chronology into causality, an anecdote into a
general law, or missing sensory detail into asserted memory. It may use an
explicit placeholder, omit the detail, ask a focused question when essential,
or phrase uncertainty honestly.

## Narrative Workflow

1. Identify the audience, platform, desired action, narrative mode, and source
   constraints.
2. Build the story lock and define the maximum supported certainty.
3. Identify the defensible transformation: what changed between the beginning
   and end, and why that change matters to the audience.
4. Build a five-beat spine: prior state, repeated normal, disruption, causal
   consequences, and resulting state. Treat it as an internal scaffold rather
   than mandatory published wording.
5. Expand only where useful:
   - turn a consequence into a clear causal chain;
   - zoom into a supported decisive moment using concrete detail;
   - slow high-stakes or emotional moments and compress connective material.
6. Plan tension and information release. Open questions may be delayed, but the
   final text must deliver the promised answer without hiding a qualification.
7. Use HEIA as a content-level check: earn attention, establish audience
   recognition, deliver substance, and end with an action appropriate to the
   source and user request.
8. Return the requested artifact and an integrity check.

## Progressive Disclosure

Keep `SKILL.md` concise and route detailed guidance to these references:

- `references/story-lock.md`: classification and truth safeguards;
- `references/five-beat-spine.md`: basic structure and expansion;
- `references/tension-detail-pacing.md`: causal chain, scene zoom, and tempo;
- `references/information-release.md`: curiosity, withholding, and payoff;
- `references/heia.md`: content-level attention, empathy, substance, action;
- `references/delivery.md`: pace, pause, emphasis, energy, and physical detail;
- `references/repurposing.md`: format and angle transformations;
- `references/examples.md`: original safe and unsafe Indonesian examples;
- `references/provenance.md`: design influence without distributing the ebook.

No scripts or assets are needed for the first version because this work is
judgment-heavy rather than deterministic.

## Orchestrator Integration

Add `storytelling-content` before `hook-gokil` in an explicit end-to-end
narrative rewrite:

```text
story lock -> story structure -> hook -> anti-slop -> voice -> final QA
```

Add `story-structure-only` as a routed mode in `review-rewrite-content`. In
`auto`, invoke storytelling only when the user explicitly requests story,
narrative restructuring, pacing, tension, story repurposing, or when an
end-to-end request clearly supplies an experience or event as narrative
material. Do not run it for ordinary copy cleanup, hook-only work, or voice-only
adaptation.

The handoff to `hook-gokil` contains the story lock, transformation, story
spine, available tension, ending/payoff, and any facts that must not be moved or
compressed misleadingly. Later specialists cannot alter narrative facts or the
selected transformation.

## Output Contract

For outline work, return the story lock, five-beat spine, expansion choices,
and missing information. For drafting, return the narrative first, followed by
a concise integrity check. For review-only work, return findings without a
revised draft.

When orchestrated, expose these handoff fields as useful:

- `story_mode`;
- `story_lock`;
- `transformation`;
- `story_spine`;
- `tension_plan`;
- `payoff_available`;
- `story_integrity_check`.

## Repository Integration

- Create `skills/storytelling-content/` and `agents/openai.yaml`.
- Update both plugin-facing documentation and the README skill/pipeline tables.
- Update `AGENTS.md` so narrative requests route through the orchestrator.
- Add the skill to install, uninstall, verification, and fixture-test loops.
- Extend repository tests to require the new skill, mode, source-exclusion
  contract, and successful skill validation.
- Preserve support for all currently documented agents and installation scopes.

## Testing

Use test-first repository contract changes. The initial failing checks must
prove that the fifth skill and `story-structure-only` mode are absent. After
implementation, run:

```bash
./tests/verify-repo.sh
./tests/install-fixtures.sh
```

Also run the system skill validator directly on `skills/storytelling-content`
and inspect installer dry-run output so the displayed skill count matches the
actual installation set.

## Non-Goals

- Publishing, copying, or lightly paraphrasing the complete ebook.
- Treating contested neuroscience or marketing statistics as operational laws.
- Guaranteeing virality, retention, trust, or conversion.
- Inventing personal experience or cinematic detail to make weak source
  material feel complete.
- Replacing screenplay, fiction-writing, or long-form novel development skills.
