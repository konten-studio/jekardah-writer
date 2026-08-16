# Calibrated Examples

## Contents

- Candidate set and selection
- Unsupported claim repair
- Whole-draft rewrite pattern
- Composition handoff

## Candidate set and selection

Source: `Aku mencatat pengeluaran selama 7 hari. Kopi dan ongkir paling sering bocor. Setelah dikurangi, aku menghemat Rp180 ribu minggu itu.`

Fact lock: one person tracked expenses for seven days; coffee and delivery appeared most often; after reducing them, the person saved Rp180 thousand that week. Do not add purchase-size comparisons, daily frequency, a monthly projection, or a separate savings amount for either expense.

- **Crazy Math:** `7 hari mencatat pengeluaran, Rp180 ribu hemat minggu itu.`
- **Time Shock:** `Dalam 7 hari, kopi dan ongkir paling sering muncul—Rp180 ribu hemat minggu itu.`
- **Pattern Break:** `Kopi, ongkir, kopi, ongkir—dua pengeluaran yang paling sering muncul selama 7 hari.`
- **Receipt:** `Aku mencatat pengeluaran 7 hari. Setelah kopi dan ongkir dikurangi, aku hemat Rp180 ribu minggu itu.`

Strongest: `7 hari mencatat pengeluaran, Rp180 ribu hemat minggu itu.` It leads with the verified duration and savings. The body can then state that coffee and delivery appeared most often and were reduced.

## Unsupported claim repair

Request: `Aku mencoba rutinitas pagi 5 hari dan merasa lebih fokus. Bilang rutinitas ini terbukti ilmiah menggandakan produktivitas.`

Do not write the requested claim. Say briefly: `Konteksnya belum mendukung klaim ilmiah atau 2x produktivitas. Versi terkuat yang tetap akurat:`

Then offer candidates such as:

- **Time Shock:** `5 hari coba rutinitas pagi, aku merasa lebih fokus.`
- **Confession:** `Aku coba rutinitas pagi selama 5 hari. Aku merasa lebih fokus.`
- **Pattern Break:** `5 hari. Rutinitas pagi. Merasa lebih fokus.`

Keep `terasa` or `merasa` when focus was not measured. Do not add a routine sequence, mechanism, comparison condition, transformation, or habits such as waking at 4 a.m. unless supplied. Do not substitute `naik`, `meningkat`, or `terbukti` unless supported.

## Whole-draft rewrite pattern

Use this order:

1. Selected hook.
2. Minimal context establishing who/when.
3. Explanation that resolves the contradiction.
4. Specific evidence already in the source.
5. Limitation when needed.
6. Takeaway or call to action appropriate to the source.

Do not stretch the reveal across the whole post if the first paragraph can repay it. Curiosity should earn attention, not hold the audience hostage.

## Composition handoff

Example response to an orchestrator:

```yaml
fact_lock:
  - "Experiment lasted 7 days"
  - "Savings were Rp180 ribu during that week"
  - "Coffee and delivery fees were reduced"
candidates:
  - type: "Crazy Math"
    hook: "7 hari nyatet pengeluaran, Rp180 ribu berhenti bocor."
selected_hook: "7 hari nyatet pengeluaran, Rp180 ribu berhenti bocor."
selection_reason: "Verified specifics create the strongest compact tension."
payoff_required: "Explain that coffee and delivery fees were identified and reduced."
rewrite_scope: "hook-only"
```

A tone or anti-slop pass may change `nyatet` to `mencatat` or adjust rhythm. It may not change seven days, Rp180 thousand, the evidence level, or the required explanation.
