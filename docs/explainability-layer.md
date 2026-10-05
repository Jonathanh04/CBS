# CBS Talks — Explainability Layer: the Partnership Recommendation Card

**v1.0 (2026-10-05).** Builds on [`scoring-framework.md`](scoring-framework.md)
(dimensions D1–D9, scores A–G, tiers) and the data model in
[`partnership-scoring-design.md`](partnership-scoring-design.md) §2.

The explainability layer turns a company's scores, ratings and evidence into a
**Recommendation Card**. This is a short, readable recommendation in the voice
of an experienced Partnerships Manager, where every statement can be traced
back to its source.

---

## 1. Core rule: three kinds of statement, always labelled

Every sentence on a card belongs to exactly one category, and the card shows
which one:

| Tag | Category | Definition | Required backing | How it may be worded |
|---|---|---|---|---|
| **[V]** | **Verified** | A fact observed in a source | An Evidence item with `status = verified`, a source (URL, document or logged interaction) and a date, still within the dimension's freshness window | Plain statement plus source and date: "20 relevant postings in the last 12 months (Jobindex, Aug 2026)" |
| **[I]** | **Inference** | A conclusion drawn from verified facts by a stated reasoning step | Links to the [V] evidence it rests on **and** names the reasoning: either a rule from the inference library (§4) or a written rationale with an author | Must sound like an inference: "likely", "suggests", "probably", "we expect". Never phrased as fact |
| **[?]** | **Missing** | Something the score or recommendation depends on that we don't know | A dimension rated UNKNOWN, or a required piece of evidence that doesn't exist | Phrased as an open question or a research task: "Unknown: do they sponsor at our standard-ask level?" |

Extra rules:

- **Stale facts are downgraded.** Verified evidence older than the dimension's
  freshness window is shown as [I] with "as of <date>".
- **Board members' own knowledge** ("I spoke to their HR lead at a fair") counts
  as [V] **only** once it is logged as an Interaction. Before that it is [I],
  with the author named.
- **AI-proposed evidence** is [?] until a person verifies it. It can never
  appear as [V].
- **No outside knowledge.** The card is built *only* from records in the
  system. This applies even when the writer, or an AI model, "knows" something
  about the company. If it isn't in the evidence store, it isn't on the card.
  This is the main safeguard against invented facts.

### Display

- **In a spreadsheet or plain text:** use `[V]`, `[I]` and `[?]`.
- **In a web view:** use ✓ / ~ / ? icons, and show the source and date on hover.
- **Every card shows its mix** in the confidence section, e.g. "9 verified · 4 inferred · 3 missing".

---

## 2. Pipeline

```
Score snapshot (A–G, D1–D9, contributions, adjustments, tier, type)
        +  Evidence (V)  +  Inferences (I)  +  Unknowns (?)
        │
        ▼
1. SELECT     deterministic rules pick reasons, risks, offers, angle (§3)
        │      → a structured "card draft" in which every slot carries claim IDs
        ▼
2. PHRASE     templates (MVP) or an AI writer (v1) turn slots into sentences.
        │      Constraint: may only use the claims in the draft (§6)
        ▼
3. VALIDATE   automatic checks: every sentence has claim IDs; no names, numbers
        │      or dates that aren't in the draft; [V] sentences cite only [V] claims;
        │      inference wording on [I] sentences; the opening angle uses [V] only
        ▼
4. REVIEW     the Partnerships Manager edits and approves. The card stays
        │      `draft` until approved; edits are logged
        ▼
5. PUBLISH    the approved card is saved as a snapshot linked to its score
              version. If the score changes, the card is marked "outdated"
```

The **selection** step is where the judgement lives, and it is fully
rule-based and repeatable. The **phrasing** step only changes how the card
reads, never what it claims.

---

## 3. The nine card fields: source, selection rule and fallback

### Field 1 — Partnership Priority Score

| | |
|---|---|
| **Shows** | `A/100` · range (from UNKNOWN dimensions; omitted when all are rated) · tier · confidence, **plus** the sub-score line B–G (A is never shown alone) |
| **Source** | Score snapshot |
| **Format** | `Priority 65/100 (all rated, no range) · Tier B — Build a path · Confidence: Medium` then `Financial 66 · Student 70 · Speaker 58 · Recruitment 81 · Long-term 75 · Outreach 44` |
| **Rules** | Any adjustment (mutual-value cap, risk penalty) is printed on the next line with its reason. A sub-score with more than 50% of its weight UNKNOWN is shown as "—" (not enough data), not as a number |
| **Bottom line** | One sentence under the score summarising the recommendation, built from the tier plus the recommended type plus the main reason. Example: "Strong long-term recruitment partner that needs us more than we need them, but we have no way in yet, so get an introduction before pitching." |

### Field 2 — Top 3 reasons to approach

| | |
|---|---|
| **Source** | Dimension contributions relative to neutral: `weight × (score − 50) / 100`; the highest positive values |
| **Selection rule** | 1. Rank dimensions by positive contribution. 2. Keep only dimensions rated with **Medium or High confidence**. 3. Each reason must cite at least one [V] or [I] claim. **Reasons backed by [V] come first.** 4. If the mutual-value cap or fast-track rule applies, it overrides the ranking: a fast-tracked type's main dimension is always reason #1 |
| **Content rule** | A reason is **evidence, not a restated score**. ❌ "Strong relevance to CBS students" ✅ "Hires ~20 business graduates a year (Jobindex, Aug 2026) [V]" |
| **Fallback** | If fewer than three qualifying reasons exist, show fewer and say so: "Only 1 evidence-backed reason; D4–D7 not yet researched." Never pad with weak reasons |

### Field 3 — Top 2 risks or weaknesses

| | |
|---|---|
| **Source, in priority order** | 1. Active risk flags (penalty level). 2. Adjustments applied (mutual-value cap). 3. **The largest UNKNOWN or Low-confidence dimension by weight** (the biggest blind spot). 4. The lowest negative contributions |
| **Selection rule** | Take the top two from the list above, but **always include at least one category-1, 2 or 3 item if any exist**. Weaknesses that change the decision matter more than low scores the tier already reflects |
| **Content rule** | Say what the risk *means for the decision*: "No contact yet, so a cold pitch will likely go nowhere [I]; nearest path: alumnus in their talent team [V]." |

### Field 4 — Recommended partnership type

| | |
|---|---|
| **Source** | Partnership Recommendation Engine ([`recommendation-engine.md`](recommendation-engine.md)): verdict, primary, secondary, target, why / why not |
| **Shows** | **Target type + entry offer + the rule that produced it**: "Strategic partner (target): Long-term 75 ≥ 70, Financial 66 and Recruitment 81 ≥ 60. Entry: case workshop, because Outreach is 44 (< 50)." |
| **Fallback** | If the company is provisional (coverage < 70%): "No recommendation yet. Research D4–D7 first." The system doesn't guess a type from incomplete data |

### Field 5 — Recommended event / topic

| | |
|---|---|
| **Source** | D2's **event concept** (required for D2 ≥ 75) + the CBS Talks theme list + D4 speaker record |
| **Shows** | Format · working title · which theme it serves · proposed speaker (if any) · **status**: `concept by <board member>` / `discussed with company` / `agreed` |
| **Label** | An event idea we came up with is always [I], since it's our proposal and not a fact about them. The facts it rests on are cited inline |
| **Fallback** | If D2 < 75 or there is no concept: "No concept yet. Closest theme match: <theme> [I]." An AI-drafted concept is marked "AI draft, not reviewed" until a board member adopts it |

### Field 6 — What CBS Talks can offer the company

| | |
|---|---|
| **Source** | The reasons behind the D3 (Partner Need) rating, matched to the **Offering catalog** |
| **Selection rule** | For each of the top two needs, list 1–2 offerings that address it, filtered by remaining capacity this semester |
| **Format** | `Need [tag + source] → Offering(s)`, e.g. "Low visibility among CBS students despite hiring volume [I: rule IR1] → case workshop + 'day in the life' content series" |
| **Rule** | Facts about CBS Talks (audience size, reach) come from the CBS Talks profile and are [V] only if that profile is documented. Until then they are [?]. **We don't overstate our own audience either** |

### Field 7 — What the company could contribute

| | |
|---|---|
| **Source** | D4 (named speaker), D5 (roles for students), D6 (financial level relative to the standard ask), D2 (content, data, cases), in-kind capacity |
| **Shows** | One line per contribution type, each tagged |
| **Rules** | **Money:** shown as the Financial Potential block ([`financial-potential-model.md`](financial-potential-model.md) §6): estimated tier, plausible range, confidence, basis, always labelled as an estimate. Previously:  say *"at standard-ask level"* only with [V] sponsorship history at that level. Otherwise write "budget level unknown [?]". Never estimate an amount. **Speakers:** name a person only if a Person record exists; say whether speaking ability is verified (recordings) or not |

### Field 8 — Suggested opening angle for outreach

| | |
|---|---|
| **Source** | Strongest **[V]** need (D3) + **[V]** timing trigger (D9) + entry offer (field 4) + contact path (D9 / Person records) |
| **Structure** | **Hook** (a verified fact about them) → **Value** (what we offer for that need) → **Ask** (the entry offer, small and concrete) → **Path** (who reaches out, through whom; taken from the Contact Plan in [`contact-discovery-layer.md`](contact-discovery-layer.md)) |
| **Hard rule** | The opening angle may **only state [V] facts about the company.** Inferences can shape the angle but must never be stated *to the company*. Telling a company "you struggle to attract students" based on our inference is both risky and presumptuous |
| **Fallback** | No verified hook → "No opening angle yet: we have no verified fact to open with. Research: <top missing item>." Don't fall back to generic flattery |
| **Style** | Two to three sentences, written as a first message, not a slogan. No buzzwords (§5) |

### Field 9 — Confidence level

| | |
|---|---|
| **Computed** | **High:** coverage ≥ 90% **and** ≤ 15% of A's weight Low confidence **and** no stale evidence behind the top-3 reasons. **Medium:** coverage ≥ 70% **and** ≤ 40% Low confidence. **Low:** anything else (= provisional; can't be Tier A) |
| **Shows** | Level · coverage · statement mix ("9 V · 4 I · 3 ?") · **what would change the score most** (the UNKNOWN/Low dimension with the largest swing: weight × possible change) · the number of active overrides |
| **Example** | "Medium. All dimensions rated, but Speaker and Long-term rest on assumptions. Confirming whether the COO can speak would move Priority by up to ±6.5." |

---

## 4. Inference library

Inferences are allowed, but only as **named, reusable rules** or as **written
reasoning with an author**. This keeps "reasonable inference" from turning into
"made-up fact".

| ID | Rule (if… then…) | Wording on the card | Used in |
|---|---|---|---|
| IR1 | ≥ 6 relevant postings in 12 months **and** not in the top 100 of the student employer ranking | "Likely employer-brand gap among CBS students" | D3, fields 2, 6 |
| IR2 | Sponsored ≥ 1 CBS / Copenhagen student organisation in the past 2 years | "Probably open to student-organisation partnerships" | D6, D9 |
| IR3 | Partner of ≥ 3 CBS organisations already | "May see limited extra value from another CBS partnership" (risk) | D3, field 3 |
| IR4 | New employer-branding / talent-attraction hire in the past 6 months | "Plans and budgets may be under review: a good time to approach" | D9 timing |
| IR5 | ≥ 2 recorded public talks in the past 2 years | "Experienced public speaker" | D4 |
| IR6 | Danish layoffs or restructuring reported in the past 12 months | "Risk to multi-year commitment" | D7, field 3 |
| IR7 | Graduate programme **and** CBS alumni in their talent team | "Likely to value a direct CBS recruitment channel" | D3, D5 |
| IR8 | Mutual-value cap applied (D3 ≤ 25) | "They have little to gain from us; expect a low response rate" | field 3 |

- **Free-form inferences** (not from the library) need `reasoning`,
  `based_on_evidence_ids` and `author`. They show the author's initials on the card.
- **Inferences proposed by AI** need a person to accept them.
- **New rules** are added to the library when the same free-form inference
  comes up repeatedly. Review the library once per semester.

---

## 5. Voice and style guide

The card should read like a short note from an experienced Partnerships
Manager to the board.

- **Lead with the decision.** The bottom line comes first; the evidence follows.
- **Be concrete.** Use numbers, names, dates and sources. "20 postings" beats "high hiring".
- **Match certainty to evidence.** Plain statements for [V]; "likely",
  "suggests" or "probably" for [I]; open questions for [?]. Never use
  "likely" on a [V] fact or a plain statement on an [I].
- **Be short.** Bullets of 25 words or fewer; the whole card fits on one screen.
- **Be honest about weaknesses.** A card with no risks is a broken card.
- **Banned words:** synergy, leverage, world-class, cutting-edge, unique
  opportunity, thought leader (unless quoting them), win-win, "perfect fit",
  exciting. They signal advertising, not analysis.
- **Pitch language is for the company; analysis language is for the board.**
  Field 8 is the only part written to the company. Everything else is internal.

---

## 6. Generation modes and the AI writer contract

### MVP (spreadsheet, no AI)

- Fields 1, 4 and 9 come fully from formulas.
- Fields 2 and 3: formulas pick the dimensions (sort contributions,
  filter by confidence). The text is the evidence `claim` column and its tag,
  joined together, so no free writing is needed.
- Fields 5–8: written by a board member in fixed cells, following the
  structure above. The Partnerships Manager approves.

### v1 (AI-assisted phrasing)

The AI model receives **only** a structured JSON card draft:

```json
{
  "company": "Nordlys Logistics",
  "scores": {"A": 65, "range": [65, 65], "tier": "B", "B": 66, "C": 70, "D": 58,
             "E": 81, "F": 75, "G": 44, "confidence": "Medium"},
  "slots": {
    "reasons": [{"dimension": "D3", "contribution": 6.5,
                 "claims": [{"id": "ev-112", "tag": "V",
                             "text": "20 relevant postings in last 12 months",
                             "source": "Jobindex", "date": "2026-08"}]}],
    "risks": [ ... ], "type": { ... }, "event": { ... },
    "offer": [ ... ], "contribution": [ ... ], "angle": { ... }
  }
}
```

It must return JSON where **every sentence lists the claim IDs it uses**.
The validator rejects the output if:

- any sentence has no claim IDs;
- it contains a proper noun, number or date that isn't in the input;
- a sentence without a hedge cites an [I] claim;
- the opening angle cites any [I] or [?] claim;
- a banned word appears.

If the output is rejected twice, the system falls back to the template text.

The prompt tells the AI to ignore anything it knows about the company. **The
validator can't catch every paraphrased invention**, for example a vague
claim with no number or name. That is why human approval (pipeline step 4)
is required, not optional.

### Data model additions

| Entity | Fields |
|---|---|
| **Inference** | `inference_id`, `company_id`, `statement`, `rule_id?` (IR-n), `reasoning?`, `based_on_evidence_ids[]`, `author` (person / system / AI), `status` (proposed / accepted / rejected), `created_at` |
| **RecommendationCard** | `card_id`, `company_id`, `score_snapshot_id`, `fields{}` (each sentence with `tag` + `claim_ids[]`), `generation_mode` (template / AI), `status` (draft / approved / outdated), `approved_by`, `approved_at`, `edit_log[]` |
| **CBSTalksProfile** | Audience size per format, reach, programmes represented, theme list, standard ask. These are the facts about *us* that fields 6 and 8 rely on; each value has a source and date |

---

## 7. Card template

```
──────────────────────────────────────────────────────────────
<COMPANY>                                    Card status: <draft/approved>
Priority <A>/100 (range <lo>–<hi>) · Tier <X> — <tier name> · Confidence: <H/M/L>
Financial <B> · Student <C> · Speaker <D> · Recruitment <E> · Long-term <F> · Outreach <G>
Adjustments: <none | cap/risk line>

BOTTOM LINE
<one sentence>

WHY APPROACH
1. <reason> [tag, source, date]
2. ...
3. ...

RISKS / WEAKNESSES
1. <risk + what it means for the decision> [tag]
2. ...

RECOMMENDED PARTNERSHIP
<target type> — entry: <entry offer>. (<rule trace>)

RECOMMENDED EVENT / TOPIC
<format>: "<working title>" — theme: <theme>. Speaker: <person | none yet>. Status: <...>

WHAT CBS TALKS CAN OFFER THEM
- <need [tag]> → <offering(s)>

WHAT THEY COULD CONTRIBUTE
- <contribution [tag]>

OPENING ANGLE  (external, verified facts only)
"<2–3 sentences>"
Path: <who reaches out, via whom>

CONFIDENCE
<level> — coverage <x>% · <n> V · <n> I · <n> ? · overrides: <n>
Biggest swing: <dimension> (±<pts>). Next research step: <task>
──────────────────────────────────────────────────────────────
```

---

## 8. Examples

All companies, people and evidence in these examples are **fictional**. They
show the format; they aren't real assessments.

### 8.1 Fully assessed company

```
──────────────────────────────────────────────────────────────
NORDLYS LOGISTICS (fictional)                 Card status: approved
Priority 65/100 (all rated, no range) · Tier B — Build a path · Confidence: Medium
Financial 66 · Student 70 · Speaker 58 · Recruitment 81 · Long-term 75 · Outreach 44
Adjustments: none

BOTTOM LINE
A strong long-term recruitment partner that needs us more than we need
them. We have no way in yet, so get an introduction before pitching.

WHY APPROACH
1. They hire business graduates at volume: 20 relevant postings in the last
   12 months, plus a graduate programme. [V — Jobindex, careers page, Aug 2026]
2. They are likely under-recognised by students: high hiring, but absent
   from the 2026 student employer ranking top 100. [I — rule IR1]
3. Supply-chain resilience is a stated strategic priority, and it matches our
   2026/27 theme "Fragile Systems". [V — annual report 2025; CBS Talks theme list]

RISKS / WEAKNESSES
1. No contact yet, so a cold pitch will likely stall. Possible path: a CBS
   alumnus in their talent team. [V — interaction log empty;
   LinkedIn lookup 12 Sep 2026] [I — likely stall]
2. Budget unknown: we found no sponsorship history, so Financial 66 rests
   on an assumption. Don't lead with a cash ask. [?]

RECOMMENDED PARTNERSHIP
Strategic partner (target) — entry: case workshop.
(Long-term 75 ≥ 70; Financial 66 and Recruitment 81 ≥ 60; Outreach 44 < 50 → small entry offer)

RECOMMENDED EVENT / TOPIC
Case workshop: "Rerouting a supply chain in 48 hours" — theme: Fragile Systems.
Speaker: COO (Person record), speaking ability unverified [?].
Status: concept by J.H., not yet discussed with the company. [I]

WHAT CBS TALKS CAN OFFER THEM
- Visibility among CBS students who don't know them yet [I — IR1]
  → case workshop + "day in the life" content series
- Direct access to students for graduate hiring [V — graduate programme]
  → recruitment mixer after the workshop

WHAT THEY COULD CONTRIBUTE
- A real operations case and a senior host for the workshop [I — concept]
- Graduate and student roles for our audience [V — careers page]
- Cash sponsorship: level unknown, no history found [?]

OPENING ANGLE  (external, verified facts only)
"You're hiring around twenty business graduates a year. We'd like to put
a real Nordlys supply-chain problem in front of CBS students in a spring
case workshop, and introduce you to the students who solve it best."
Path: ask the CBS alumnus in their talent team (via board member A.K.) for
an introduction to the employer-branding lead.

CONFIDENCE
Medium — coverage 100% · 9 V · 4 I · 3 ? · overrides: 0
Biggest swing: Speaker (±6.5): is the COO a good speaker?
Next research step: find a recorded talk or podcast with the COO.
──────────────────────────────────────────────────────────────
```

### 8.2 Company that has only been quick-screened

```
──────────────────────────────────────────────────────────────
HAVBRUG ENERGY (fictional)                    Card status: draft
Priority 44/100 (range 27–74) · PROVISIONAL · Confidence: Low
Financial — · Student 55 · Speaker — · Recruitment — · Long-term — · Outreach 31
Adjustments: none   (— = more than half the score's inputs not yet researched)

BOTTOM LINE
Not enough known to recommend. The range (27–74) spans "park" to "approach
now". A 1-hour assessment is worth it because students already show interest.

WHY APPROACH
1. Strong student interest: top-quartile result in our September audience
   pulse survey. [V — CBS Talks pulse survey, Sep 2026]
Only 1 evidence-backed reason. D4–D8 not yet researched.

RISKS / WEAKNESSES
1. Biggest blind spot: Speaker, Recruitment, Financial and Long-term are all
   unknown (47% of the score). [?]
2. No contact path identified. [V — interaction log, Person records empty]

RECOMMENDED PARTNERSHIP
No recommendation yet. Provisional companies get no type.

RECOMMENDED EVENT / TOPIC
No concept yet. Closest theme match: "Fragile Systems" (energy transition). [I]

WHAT CBS TALKS CAN OFFER THEM
Not determined: Partner Need rated 50 on general signals only. [?]

WHAT THEY COULD CONTRIBUTE
Not determined. [?]

OPENING ANGLE
Not generated: no verified fact about the company to open with.

CONFIDENCE
Low — coverage 53% · 2 V · 1 I · 6 ? · overrides: 0
Biggest swing: Speaker (−4.6 to +8.5). Next research step: identify a named speaker
and check graduate hiring.
──────────────────────────────────────────────────────────────
```

### 8.3 Your Deloitte example, run through these rules

I can't produce a real Deloitte card. The system contains no evidence about
Deloitte, so any card would be built on my general knowledge, which is
exactly what this layer forbids. Here is what the system would show today:
**every line of the example becomes a research task.**

| Line in your example | Status today | Evidence needed to make it [V] | Dimension |
|---|---|---|---|
| "Strong relevance to CBS students" | [?] | Pulse survey result, student ranking position, past CBS event attendance | D1 |
| "High recruitment value" | [?] | Graduate programme page, count of relevant postings | D5 |
| "Strong potential for senior speakers" | [?] | A **named** person with talk recordings and a contact path | D4 |
| "Existing interest in student engagement" | [?] | Partner pages of CBS / Copenhagen student organisations | D9 (IR2) |
| "Highly competitive sponsorship landscape" | [?] | Count of CBS organisations they already partner with | D3 (IR3) |
| "May already have strong relationships with CBS organisations" | [?] | Same as above | D3, D9 |
| "Annual strategic partnership" | Not computable | Requires F ≥ 70 and two of B/D/E ≥ 60 from rated dimensions | Rule §6.4 |
| Pitch: "AI-driven transformation" | Not allowed yet | A [V] source that this topic is *their* agenda (report, campaign, leader statements) | D2, field 8 |
| "87/100" | Not computable | Ratings for D1–D9 | — |

Critique of the example format, which the template above fixes:

1. **The reasons restate scores instead of giving evidence.** "High
   recruitment value" is the conclusion. The card should show the fact
   behind it.
2. **87/100 is shown alone**, with no range, sub-scores or confidence. A
   reader can't tell whether 87 is solid or a guess.
3. **The risks are reasonable concerns but unlabelled.** They are actually
   the most important lines: if a company is saturated with CBS
   partnerships, that's a Partner Need problem (IR3/IR8) that can cap the score.
4. **The pitch picks a topic without evidence it is theirs.** A pitch built
   on a topic *we* find interesting is a guess. The opening angle must start
   from a verified fact about them.
5. **"Annual strategic partnership" as a first ask** skips the entry offer.
   Unless there is an existing relationship (G ≥ 50), start smaller.

---

## 9. Weaknesses of the explainability layer

1. **Labelling depends on discipline.** If board members log impressions as
   verified evidence, the tags become meaningless. Spot-check 5 random [V]
   claims per month: is the source there, and does it say what the claim says?
2. **Selection rules can hide things.** "Top 3 reasons" leaves out reason #4,
   which might matter to a particular reader. The full contribution breakdown
   must stay one click away.
3. **AI phrasing can still invent things the validator misses**, especially
   vague claims with no names or numbers. Human approval is the real safeguard.
4. **Cards go out of date quietly.** A card approved in October can be wrong
   by February. Cards are automatically marked "outdated" when the score
   snapshot changes **or** when cited evidence goes stale.
5. **Polished prose builds trust it may not deserve.** A well-written card
   feels more certain than its evidence allows. That is why the confidence
   line and the V/I/? count are on every card, not hidden in details.
