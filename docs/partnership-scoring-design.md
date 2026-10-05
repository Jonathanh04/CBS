# CBS Talks — Partnership Prospect Scoring & Prioritization System

**Design proposal, v0.1 (2026-10-05). No application code yet.**

> **Update:** the dimensions, weights and calculation in §3–§5 are replaced by
> [`scoring-framework.md`](scoring-framework.md) (the CBS Talks Partnership
> Priority Score). The critique, architecture, data model, information plan,
> bias analysis and MVP below still apply.

This document proposes the architecture, data model, scoring dimensions,
methodology, data collection plan, known weaknesses and an MVP for a
partnership intelligence tool for CBS Talks.

---

## 0. Critique of the original concept (read this first)

The brief is good on principles: transparency, two-sided value, long-term
focus, manual overrides. But several parts would produce a misleading tool
if built as described.

| # | Problem in the brief | Why it matters | Proposed fix |
|---|---|---|---|
| 1 | **One ranked list of companies.** | "Best sponsor", "best speaker source" and "best recruitment partner" are different questions. A founder-led scale-up can be a perfect speaker source and a terrible cash sponsor. A single composite score averages these into mush. | Score each company **per partnership track** (Sponsor, Speaker, Recruitment, Strategic, In-kind). The answer to "who first?" is a per-track ranking plus a portfolio view, not one global list. |
| 2 | **"Fit" and "likelihood of saying yes" are mixed.** | A company can be ideal but impossible to reach this semester, or easy to reach but low value. One number hides which is which. | Separate **Attractiveness** (how good would this partnership be?) from **Winnability** (how likely and how soon can we get it?). Priority combines the two, but both stay visible. |
| 3 | **Two-sided value scored additively.** | With a weighted sum, a huge "value to us" can compensate for zero "value to them". But if they get nothing, they say no. | Combine the two sides with a **geometric mean**, so a partnership has to be good for both sides to score well. |
| 4 | **"Speaker potential" treated as a company property.** | Speakers are people. Novo Nordisk as a company is not a speaker; a specific EVP who speaks well is. | Model **people** (speaker candidates, contacts, champions) as first-class records. Company speaker score = best available person, with evidence. |
| 5 | **"Brand value" and "strategic value" are vague.** | Vague criteria become gut feel with a number attached, which is exactly the black box you want to avoid. | Replace with narrow, anchored criteria: *Brand draw for CBS students*, *Topic relevance to CBS Talks themes*, *Long-term / multi-track potential*. Each has a written 0–4 rubric. |
| 6 | **"Strategic fit over size" is stated but not enforced.** | Size comes back through correlated proxies: big firms have more budget, more famous executives, stronger brands and more press (= more evidence). Without a counterweight they will win most tracks anyway. | Add a criterion that *favours* companies that **need** CBS Talks: the **employer-brand gap** (high hiring need for CBS profiles, low awareness among students). Then run the size bias check in §7. |
| 7 | **Scoring every company deeply.** | 200 prospects × ~15 criteria × evidence = 3,000+ evidence-backed ratings. A volunteer team will not keep that up, and the data will rot. | **Two-stage funnel.** A 10-minute *quick screen* on 5 criteria for everyone, then a *deep assessment* only for the top ~30. |
| 8 | **Scoring is not the hard problem.** | Student organisations lose most of their partnership knowledge at each annual board handover. Who was contacted, who said "ask us again in spring", who the champion was: that information is worth more than a refined weight. | Make the **relationship log and pipeline** part of the core system, not an add-on. The score is only the entry point. |
| 9 | **"What type of partnership" as a static label.** | Long-term partnerships usually grow in steps: a speaker, then an event sponsor, then an annual partner. Recommending only the end state skips the realistic entry point. | Recommend a **partnership pathway**: entry offer, then target relationship. |
| 10 | **No feedback loop.** | Without recording outcomes you cannot tell whether the scores predict anything. | Record outcomes (response, meeting, deal, value, renewal, reason lost) and review weights each semester against them. |

---

## 1. System architecture

### 1.1 Logical architecture

```
┌──────────────────────────────────────────────────────────────────────┐
│                       PRESENTATION / VIEWS                           │
│  Priority board  │  Company card  │  Research queue  │  Pipeline     │
│  (per track)     │  (why + offer) │  (what to learn) │  & renewals   │
│  Portfolio/capacity view  │  Admin: rubrics & weights  │  Audit log  │
└───────────────▲──────────────────────────────▲───────────────────────┘
                │                              │
┌───────────────┴───────────┐   ┌──────────────┴───────────────────────┐
│  EXPLANATION LAYER        │   │  RECOMMENDATION LAYER                │
│  Turns score contributions│   │  • best track + secondary track      │
│  into "why" text, each    │   │  • offer package (needs → offerings) │
│  line linked to evidence  │   │  • pathway: entry offer → target     │
│  (no new judgements)      │   │  • next best research question       │
└───────────────▲───────────┘   └──────────────▲───────────────────────┘
                │                              │
┌───────────────┴──────────────────────────────┴───────────────────────┐
│  SCORING ENGINE (deterministic, pure function)                       │
│  inputs: ratings + overrides + weight profile version                │
│  1. gates (hard exclusions)  2. criterion scores  3. side scores     │
│  4. mutual fit per track  5. winnability factor  6. risk multiplier  │
│  7. priority index + tier  8. coverage & score range                 │
│  output: scores + per-criterion contribution breakdown + snapshot    │
└───────────────▲──────────────────────────────────────────────────────┘
                │
┌───────────────┴──────────────────────────────────────────────────────┐
│  ASSESSMENT LAYER (human judgement, recorded)                        │
│  Ratings (0–4 on anchored rubric, or UNKNOWN) ← Evidence             │
│  Overrides (who, why, expiry)                                        │
└───────────────▲──────────────────────────────────────────────────────┘
                │
┌───────────────┴──────────────────────────────────────────────────────┐
│  DATA LAYER                                                          │
│  Companies · People · Evidence · Interactions · Opportunities        │
│  Offerings catalog · Config (rubrics, weights: versioned)            │
└───────────────▲──────────────────────────────────────────────────────┘
                │
┌───────────────┴──────────────────────────────────────────────────────┐
│  INPUT / ENRICHMENT                                                  │
│  Manual research · CVR register · LinkedIn · Jobindex · reports      │
│  Optional AI research assistant → proposes evidence WITH SOURCE URL  │
│  → human verifies → becomes Evidence. AI never writes a rating.      │
└──────────────────────────────────────────────────────────────────────┘
```

### 1.2 Design rules

1. **Scores are derived, never typed in.** A person enters *ratings with
   evidence*; the engine computes everything else. The only way to change a
   score by hand is an *override*, which is logged.
2. **The engine is a pure function.** The same inputs and weight version
   always give the same output. You can always answer "why did this
   change?" (new evidence, new rating, new weights, or an override).
3. **Configuration is data.** Rubrics, weights, tier thresholds and the
   offering catalog live in versioned config, not in code. Changing a weight
   creates a new profile version; old snapshots keep pointing to the old one.
4. **Unknown is not zero.** Missing information is stored as `UNKNOWN` and
   handled explicitly (§5.6). Treating it as zero would punish companies we
   haven't researched yet.
5. **LLMs may summarise and propose, never decide.** If AI-assisted research
   is added, it drafts evidence items with source links. A human accepts or
   rejects each one. Explanations are generated from computed contributions,
   so the prose can't claim something the numbers don't support.
6. **The system has to survive board turnover.** Every record has an owner
   and a timestamp, and the handover is a report the system generates.

### 1.3 Technology path (recommendation)

| Phase | Stack | Why |
|---|---|---|
| MVP (weeks 1–3) | Google Sheets (in a CBS Talks shared drive, not anyone's personal drive) | Free, everyone already knows it, survives handovers, formulas are transparent. |
| v1 (if the MVP proves useful) | Airtable **or** a small web app (Postgres + simple frontend), weights/rubrics as YAML in this repo | Linked records (evidence ↔ rating ↔ company), forms, audit history. |
| v2 | Add enrichment assistant, email/calendar interaction logging, renewal reminders | Only once the manual process is stable. |

Don't skip the spreadsheet phase. The rubrics will change a lot after the
first 30 companies, and changing a spreadsheet is cheap.

### 1.4 Compliance note (GDPR)

The system stores personal data about contacts and speaker candidates.
CBS Talks operates in the EU, so:

- Use a documented **legitimate interest** basis for B2B contact data, and
  store only work-related information.
- Set a **retention rule**, e.g. delete a contact with no interaction for 24 months.
- Keep personal opinions out of free-text fields about people. Notes can be
  exposed through access requests.
- Any "CV access" or attendee data offered to sponsors needs explicit attendee
  consent. Check CBS rules before putting it in a package.

---

## 2. Data model

Entity overview:

```
Company 1─* Person 1─* Interaction
   │  1─* Evidence *─* Criterion
   │  1─* Rating ──* Evidence      (rating cites evidence)
   │  1─* Override
   │  1─* Opportunity *─* Offering
   │  1─* ScoreSnapshot ──1 WeightProfile(version)
   └  *─* RiskFlag
```

### 2.1 Entities and key fields

**Company**
| Field | Notes |
|---|---|
| `company_id`, `name`, `cvr_number` | CVR = Danish company register ID (for Danish entities) |
| `parent_company` | Avoids scoring Danish subsidiary and global parent twice |
| `industry`, `sub_sector` | Fixed taxonomy (e.g. 15 sectors), not free text |
| `dk_presence` | HQ / regional office / sales office / none |
| `size_band` | Employees in DK: <50, 50–250, 250–1000, 1000+ (descriptive, not a scored criterion) |
| `ownership` | Listed, PE-owned, foundation-owned, family, startup (VC) |
| `stage` | Funnel stage: `long_list → screened → deep_assessed → approached → in_dialogue → partner → lapsed / excluded` |
| `owner` | Board member responsible |
| `last_reviewed_at` | Drives staleness warnings |

**Person** (contacts, champions, speaker candidates)
| Field | Notes |
|---|---|
| `person_id`, `company_id`, `name`, `title`, `function` | Function: Talent Acquisition, Employer Branding, Comms, CSR, C-suite, Founder… |
| `roles` | Multi-select: decision maker / champion / speaker candidate / gatekeeper |
| `cbs_alumnus` | Yes/No/Unknown |
| `relationship_warmth` | 0 none · 1 cold intro possible · 2 met once · 3 warm · 4 champion |
| `relationship_owner` | Which board member knows them |
| `speaker_profile` | Topics, languages, past talks (links), audience pull |
| `consent_basis`, `retention_until` | GDPR |

**Criterion** (config)
| Field | Notes |
|---|---|
| `criterion_id`, `side` | Side: `VALUE_TO_US`, `VALUE_TO_THEM`, `WINNABILITY`, `RISK` |
| `name`, `question` | e.g. "How much does this company need CBS-profile talent?" |
| `rubric` | Text anchors for 0, 1, 2, 3, 4 |
| `evidence_guidance` | What counts as evidence, and preferred sources |
| `screening` | Bool: part of the quick screen? |
| `half_life_days` | How quickly evidence goes stale (e.g. hiring 180, ownership 730) |

**Evidence**
| Field | Notes |
|---|---|
| `evidence_id`, `company_id`, `person_id?` | |
| `criterion_ids` | One piece of evidence can support several criteria |
| `claim` | One factual sentence: "Posted 14 graduate roles for business profiles on Jobindex in Aug 2026" |
| `source_type` | Public web, report, LinkedIn, conversation, internal history, AI-proposed |
| `source_ref` | URL or interaction ID; **required** |
| `observed_at`, `collected_by` | |
| `reliability` | A direct/verified · B credible secondary · C indirect/inferred |
| `status` | proposed / verified / rejected / superseded |

**Rating** (one current rating per company × criterion; history kept)
| Field | Notes |
|---|---|
| `company_id`, `criterion_id` | |
| `value` | 0–4 or `UNKNOWN` |
| `rationale` | 1–2 sentences linking the evidence to the rubric level |
| `evidence_ids` | **Required for value ≥ 3**, and for any value with confidence ≠ Low |
| `confidence` | High / Medium / Low (derived default from evidence reliability; editable) |
| `is_assumption` | True if no evidence; then confidence must be Low |
| `rated_by`, `rated_at` | |

**Override**
| Field | Notes |
|---|---|
| `override_id`, `scope` | `RATING` (preferred), `TRACK_TIER`, `EXCLUDE`, `PIN` |
| `target` | Rating ID or company + track |
| `original_value`, `new_value` | Both kept, both shown |
| `reason_category` | Insider knowledge / strategic priority / relationship / correction / ethics |
| `reason_text` | Required |
| `made_by`, `made_at`, `expires_at` | Default expiry: end of semester |

**WeightProfile** (config, versioned)
`profile_id`, `version`, `track`, `criterion_weights{}`, `winnability_weights{}`,
`tier_thresholds{}`, `effective_from`, `approved_by`, `change_note`.

**Offering** (CBS Talks' catalog: what we can give)
`offering_id`, `name`, `track`, `addresses_needs[]` (criterion IDs on the
VALUE_TO_THEM side), `capacity_per_semester`, `indicative_price_dkk`,
`delivery_cost`, `exclusive?`.
Examples: keynote slot, curated panel, branded talk series, company case
workshop, recruitment mixer, social media content series, newsletter feature,
logo package, category exclusivity, venue/in-kind recognition.

**Opportunity** (pipeline)
`opportunity_id`, `company_id`, `track`, `proposed_offerings[]`, `ask_dkk`,
`stage` (identified → contacted → meeting → proposal → negotiating → won /
lost / postponed), `next_step`, `next_step_due`, `owner`, `outcome_value_dkk`,
`lost_reason` (fixed list), `renewal_date`.

**Interaction**
`date`, `company_id`, `person_id`, `type` (email, call, meeting, event),
`summary`, `outcome`, `follow_up_due`.

**RiskFlag**
`company_id`, `type` (reputational, independence, partner conflict, CBS
policy), `severity` (info / penalty / gate), `evidence_ids`, `reviewed_by`.

**ScoreSnapshot**
`company_id`, `track`, `weight_profile_version`, `value_to_us`,
`value_to_them`, `mutual_fit`, `winnability`, `risk_multiplier`,
`priority_index`, `tier`, `coverage`, `score_low`, `score_high`,
`contributions{}`, `overrides_applied[]`, `computed_at`.

---

## 3. Scoring dimensions

There are 17 criteria in four groups. Each is rated **0–4 against a written
rubric**, or `UNKNOWN`. A 0–4 scale is deliberate: 0–100 inputs suggest a
precision that human judgement doesn't have.

Criteria marked ★ form the **quick screen** (§5.1).

### A. Value to CBS Talks (what they can give us)

| ID | Criterion | Question | 0 anchor | 4 anchor |
|---|---|---|---|---|
| V1 ★ | **Financial capacity & propensity** | Can and do they spend on student/university partnerships? | No budget signals, no history of sponsoring | Documented sponsorship of comparable student orgs/events in the past 2 years, or an employer-branding budget |
| V2 | **Speaker access & quality** | Do they have people who would draw a CBS audience, and can we reach them? | No identifiable speaker | Named person with a public speaking record, a relevant topic and a reachable path |
| V3 ★ | **Topic relevance** | Does their story/expertise fit CBS Talks' editorial themes this year? | Unrelated | Central example of a theme we are programming |
| V4 | **Brand draw for CBS students** | Would their name increase attendance or credibility? | Unknown or negative among students | Top employer rankings among business students / clear pull |
| V5 | **Career relevance for our audience** | Do they offer real jobs, internships or graduate programmes for CBS profiles? | No relevant roles | Structured graduate programme + regular CBS hires |
| V6 | **Long-term / multi-track potential** | Could this become a multi-year relationship spanning several tracks? | One-off at best | Clear multi-year logic (recurring hiring need, ongoing theme, existing CBS ties) |

### B. Value to the company (what CBS Talks can offer them = their motivation)

| ID | Criterion | Question | 0 anchor | 4 anchor |
|---|---|---|---|---|
| N1 ★ | **CBS talent demand** | How much do they need business-school talent? | No hiring of these profiles | High, recurring hiring of CBS-type profiles; many CBS alumni |
| N2 | **Employer-brand gap** | Is their hiring need bigger than their awareness among students? | Already a top student brand, *or* no hiring need | Strong hiring need + low student awareness (typical: B2B, industrial, scale-ups) |
| N3 | **Positioning / thought-leadership agenda** | Do they actively want to be visible on topics we cover? | No public agenda | Active campaign/leader positioning on a topic matching ours |
| N4 | **Audience match** | Is the CBS Talks audience the audience they want? | Mismatch | Exact match (e.g. they recruit finance + strategy students and that's our audience) |

N2 is the main counterweight to size bias. Companies that already dominate
student rankings need CBS Talks least.

### C. Winnability (how likely and how soon)

| ID | Criterion | 0 anchor | 4 anchor |
|---|---|---|---|
| W1 ★ | **Relationship warmth** (max over Persons) | No contact path | An active champion inside the company |
| W2 | **Precedent** | Never engages with universities or student orgs | Past partner of CBS Talks or similar CBS orgs, ended on good terms |
| W3 | **Timing triggers** | Nothing current | Current trigger: new DK office, hiring push, new employer-branding hire, launch, anniversary, budget window opening |

### D. Risk (gates and penalties, not part of attractiveness)

| ID | Criterion | Handling |
|---|---|---|
| R1 | **Reputational risk** (controversies, sector concerns, ESG violations) | Severity: none / penalty / gate |
| R2 | **Independence risk** (likelihood they demand editorial control over speakers or topics) | Severity: none / penalty / gate |
| R3 | **Partner conflict** (clashes with an existing partner's category exclusivity) | Gate if exclusivity is contractual; else penalty |
| R4 | **CBS institutional constraint** (CBS central partnership rules, overlap with CBS Career Centre agreements, sector restrictions) | Gate. **To verify with CBS:** I do not know the current rules for student organisations. |

### E. Effort (shown, used as a tiebreaker)

| ID | Criterion | Scale |
|---|---|---|
| E1 | **Effort to close and service** | Low / Medium / High (procurement, legal, approvals, delivery demands) |

Effort is deliberately not in the priority index. It's hard to estimate before
first contact, and including it would systematically penalise large
corporates, which overcorrects the size bias.

---

## 4. Methodology and weighting

### 4.1 Partnership tracks

| Track | Primary goal | Typical deal |
|---|---|---|
| **S — Financial sponsor** | Cash for operations/events | Event or season sponsorship |
| **K — Speaker partner** | Access to strong speakers | Keynote, panel, fireside chat |
| **R — Recruitment partner** | Career value for students, employer branding for them | Recruitment event, case workshop, mixer |
| **T — Strategic / content partner** | Long-term co-created content | Branded series, multi-year partnership |
| **I — In-kind partner** *(added)* | Venue, catering, production, tech | Services for recognition |

The brief didn't mention in-kind partners. They are often the easiest wins
for student organisations, so I added the track. The In-kind track uses V1
reinterpreted as "in-kind capacity"; its weights are left to the team.

### 4.2 Weight profiles (starting point, to be calibrated)

**Value to CBS Talks** (weights per track sum to 100)

| Criterion | S Sponsor | K Speaker | R Recruitment | T Strategic |
|---|---:|---:|---:|---:|
| V1 Financial capacity & propensity | **50** | 0 | 15 | 20 |
| V2 Speaker access & quality | 5 | **45** | 5 | 15 |
| V3 Topic relevance | 10 | **30** | 5 | **25** |
| V4 Brand draw | 20 | 15 | 15 | 10 |
| V5 Career relevance | 5 | 0 | **50** | 5 |
| V6 Long-term potential | 10 | 10 | 10 | **25** |

**Value to the company** (weights per track sum to 100)

| Criterion | S Sponsor | K Speaker | R Recruitment | T Strategic |
|---|---:|---:|---:|---:|
| N1 CBS talent demand | 30 | 10 | **45** | 20 |
| N2 Employer-brand gap | 30 | 15 | **35** | 15 |
| N3 Positioning agenda | 25 | **60** | 5 | **40** |
| N4 Audience match | 15 | 15 | 15 | 25 |

**Winnability** (same for all tracks): W1 50 · W2 25 · W3 25.

**Risk multiplier:** no flags 1.00 · one penalty flag 0.85 · two or more 0.70 ·
any gate means excluded from ranking (visible in an "Excluded" list with the reason).

**How weights are set:** the board agrees them at the start of each
semester in a short session. Use a simple method: distribute 100 points per
track, then sanity-check by asking "would this rank last year's best partner
near the top?" (see the back-test in §8.3). Every change creates a new profile version with a
`change_note`.

### 4.3 Why these structural choices

- **Separate profiles per track** keep "what kind of value" explicit,
  instead of folding everything into one score.
- **Geometric mean for mutual fit.** A deal needs both sides to win. A
  geometric mean of 90 and 10 is 30, while an average is 50. The geometric
  mean matches reality: a company that gets nothing won't sign.
- **Winnability as a damped multiplier (0.5–1.0) instead of an equal
  factor.** If warmth counted fully, the ranking would just mirror the board's
  personal networks (§7). The damping means a perfect-fit cold prospect still
  keeps at least half its score.
- **Risk as a multiplier/gate, not a negative weight.** Risk shouldn't be
  compensable: being a great sponsor doesn't offset a reputational
  problem.

---

## 5. How scores are calculated

### 5.1 Stage 1: quick screen (every company, ~10 minutes)

Rate the five ★ criteria: V1, V3, N1, W1 plus a risk check (R1–R4 gate check).

```
screen_score = mean(V1, V3, N1) / 4 × 100     # attractiveness proxy
advance if: no gate AND screen_score ≥ 50
        OR  W1 ≥ 3 (warm path: cheap to explore)
        OR  manual PIN override
```

The screen only decides who gets researched properly. It is not a ranking.

### 5.2 Stage 2: criterion scores

For each rated criterion: `c = rating / 4 × 100` (0, 25, 50, 75, 100).

### 5.3 Side scores per track

```
ValueToUs[t]   = Σ w_us[t][i] · c_i   / Σ w_us[t][i]      (over V1–V6)
ValueToThem[t] = Σ w_them[t][j] · c_j / Σ w_them[t][j]    (over N1–N4)
```

### 5.4 Mutual fit (attractiveness) per track

```
MutualFit[t] = sqrt( ValueToUs[t] × ValueToThem[t] )      # 0–100
```

### 5.5 Winnability and priority

```
Winnability       = (50·c_W1 + 25·c_W2 + 25·c_W3) / 100   # 0–100
WinFactor         = 0.5 + 0.5 × Winnability / 100          # 0.5–1.0
RiskMultiplier    = 1.00 / 0.85 / 0.70  (gate → excluded)
PriorityIndex[t]  = MutualFit[t] × WinFactor × RiskMultiplier
```

**Recommended track** = the track with the highest PriorityIndex. A
**secondary track** is shown if it is within 10 points.

**Tiers** (shown instead of decimals, which suggest false precision):

| Tier | Rule | Meaning |
|---|---|---|
| A — Approach now | MutualFit ≥ 65 **and** Winnability ≥ 50 | Assign an owner, approach this month |
| B — Build a path | MutualFit ≥ 65 **and** Winnability < 50 | Great fit, no way in yet. Work on warm introductions first |
| C — Opportunistic | 45 ≤ MutualFit < 65 | Approach if capacity allows or a trigger appears |
| D — Park | MutualFit < 45 | Don't spend time; re-screen yearly |

The A/B split answers "which companies should we approach first?" more
usefully than a rank number: B-tier companies need a different action
(find an introduction), not just a later spot in the queue.

### 5.6 Unknown ratings, coverage and score ranges

- **Ranking value:** an `UNKNOWN` rating counts as **1.5** (slightly below the
  midpoint). This is conservative without being punitive.
- **Score range:** compute the score again with all unknowns at 0 and at 4, and
  show `score_low – score_high`.
- **Coverage** = share of the track's weight backed by actual ratings.
  Below 60% the company is marked "under-researched" and can't get Tier A.
- **Research queue:** companies whose score range crosses a tier threshold.
  These are the ones where the next hour of research would change a decision.
  Sort the queue by the weight of the unknown criteria. This answers "what
  should we find out next?"

### 5.7 Confidence and staleness

- Each rating carries High/Medium/Low confidence. A track score reports the
  weighted share of Low-confidence inputs. If it's above 40%, the score is shown as
  "assumption-heavy".
- Evidence older than the criterion's `half_life_days` marks the rating
  **stale**. Stale ratings still count but are listed for refresh. No silent
  decay: hidden decay makes scores change for no visible reason.

### 5.8 Overrides

Order of application: rating overrides → recompute → tier/pin/exclude overrides.

- **Prefer rating-level overrides.** "I know their employer-branding budget
  doubled → V1 from 2 to 4" stays explainable. "Make Maersk Tier A" doesn't.
- Every override shows the computed value next to the final value, the reason,
  the author and the expiry date.
- Overrides expire at semester end unless renewed.
- The board reviews all active overrides once per semester: did overridden
  companies perform better or worse than the model predicted?

### 5.9 Explanations (auto-generated)

Each criterion's contribution to a track's score is computed relative to
neutral (rating 2):

```
contribution_i = w_i / Σw × (c_i − 50)        # points above/below neutral
```

The company card then reads, for example:

> **Nordlys Logistics (fictional), Recruitment track: Tier B (Priority 59, coverage 100%)**
> **Why it fits** (points above neutral on each side score)
> + Career relevance 4/4 (+25 value-to-us): graduate programme with 20 business roles in 2026 *[Jobindex, Aug 2026]*
> + CBS talent demand 4/4 (+22.5 value-to-them): ~180 CBS alumni on LinkedIn *[LinkedIn, Sep 2026]*
> + Employer-brand gap 4/4 (+17.5 value-to-them): not in student employer rankings despite hiring volume *[ranking report 2026]*
> **What holds it back**
> − Relationship warmth 1/4: no contact yet; nearest path is an alumnus known to a board member
> − Brand draw 1/4 (−3.75 value-to-us): little student pull on its own
> **Low confidence**: N3 positioning agenda (assumption, no evidence)
> **Overrides**: none
> **Next action (Tier B)**: get an introduction via the alumnus
> **Suggested offer**: recruitment mixer + case workshop + social content series
> **Pathway**: case workshop (spring) → recruitment partner (autumn) → annual partner

### 5.10 Offer recommendation (question 3)

Each Offering lists the needs (N1–N4) it addresses. For a company, take its
two highest-rated N criteria and suggest the offerings for its recommended
track that address them, filtered by remaining capacity. The Partnerships
Manager edits the result; the system only gives a starting point.

| Strongest need | Suggested offerings |
|---|---|
| N1 talent demand | Recruitment mixer, case workshop, career-themed talk |
| N2 employer-brand gap | Company-hosted talk, social content series, "day in the life" feature |
| N3 positioning agenda | Keynote/panel on their topic, branded talk series |
| N4 audience match | Targeted event for the relevant study line, newsletter feature |

### 5.11 Pathway recommendation (question 4)

Simple rules on top of the track scores:

- Winnability < 50 → entry offer = the lowest-commitment offering in the best track
  (often a speaker or workshop slot).
- Track T within 10 points of the best track and V6 ≥ 3 → target = strategic
  partner; show the steps from the entry offer to it.
- Existing partner → pathway = renewal plus expansion into the secondary track.

### 5.12 Worked example (fictional companies, Recruitment track)

| | "Nordlys Logistics" (mid-size B2B, unknown to students) | "MegaBrand A/S" (top student employer) |
|---|---|---|
| V1–V6 | 2, 1, 2, 1, 4, 3 → **ValueToUs 72.5** | 4, 3, 2, 4, 3, 2 → **78.8** |
| N1–N4 | 4, 4, 1, 3 → **ValueToThem 92.5** | 2, 0, 2, 2 → **32.5** |
| MutualFit | √(72.5×92.5) = **81.9** | √(78.8×32.5) = **50.6** |
| W1–W3 | 1, 3, 2 → Winnability 43.8 → WinFactor 0.72 | 3, 3, 1 → 62.5 → 0.81 |
| Risk | none → 1.0 | none → 1.0 |
| **Priority** | **58.9 → Tier B** (great fit, needs an introduction) | **41.1 → Tier C** |

MegaBrand would give us more on its own terms, but it has little reason to
pay for access it already has. Nordlys needs us. Under a simple weighted sum,
MegaBrand would probably rank first. This example is how the design puts
"strategic fit over size" into practice.

*(The example numbers are illustrative. The fictional names don't refer to real companies.)*

---

## 6. Information to collect per company

Ordered by when it's needed. **Bold** = required to complete that stage.

### 6.1 Long list (2 min)
- **Name, website, industry, DK presence**, parent company, CVR number
- **Source of the lead** (who suggested it, why), which also helps the bias audit

### 6.2 Quick screen (10 min)
| Info | Feeds | Typical source |
|---|---|---|
| **Sponsorship/partnership signals** (student orgs, events, universities) | V1 | Student org websites, LinkedIn posts, event pages |
| **Main business themes / stories** | V3 | Website, annual report, news |
| **Hiring of business profiles; CBS alumni count** | N1 | Jobindex, LinkedIn jobs, LinkedIn alumni search |
| **Any known contact path** | W1 | Board members, alumni, past interactions |
| **Red flags** (controversies, sector, conflicts with existing partners) | R1–R4 | News search, partner contracts |

### 6.3 Deep assessment (45–90 min)
| Info | Feeds |
|---|---|
| Executives/experts who speak publicly; talk recordings, podcasts, topics, languages | V2, Person records |
| Student employer-ranking positions (business students); social following among students | V4, N2 |
| Graduate programmes, internships, student jobs; number of roles in last 12 months | V5, N1 |
| Signals of multi-year interest: recurring hiring, long-term strategy themes, existing CBS research/teaching ties | V6 |
| Employer-branding / talent-acquisition team size and recent hires | N2, W3 |
| Public positioning agenda: campaigns, CEO themes, ESG commitments, reports | N3 |
| Which study lines/profiles they recruit | N4 |
| Decision makers by function (Employer Branding, TA, Comms, CSR) | W1, Persons |
| History with CBS Talks and other CBS orgs, including how it ended | W2 |
| Current triggers: expansion, launches, funding rounds, anniversaries, budget-cycle timing | W3 |
| Editorial-control expectations from past partnerships (if known) | R2 |
| Procurement/approval complexity | E1 |

### 6.4 Ongoing (relationship stage)
Every interaction, commitments made, satisfaction after events, what they
valued, what they complained about, renewal date, lost reason.

### 6.5 About CBS Talks itself (needed once, and missing from the brief)
The "value to them" side can't be assessed without knowing what CBS Talks
actually offers. Before scoring, document:
- Audience size and composition per event (study lines, level, international share)
- Social reach and engagement, newsletter size
- Event formats and capacity per semester
- Past partners, what they paid, and renewal rates
- This year's editorial themes (feeds V3)
- CBS rules for student-organisation partnerships (feeds R4)

---

## 7. Problems, biases and weaknesses

### 7.1 Biases

| Bias | How it enters | Mitigation |
|---|---|---|
| **Size bias via proxies** | V1, V2, V4 all correlate with company size. Big firms also produce more public evidence. | N2 counterweight; geometric mean; **semester check**: correlation of priority with size band. If Tier A is >60% 1000+-employee firms, review the weights. |
| **Evidence availability bias** | Famous companies are easier to research, so they get more ratings, higher confidence and fewer unknowns. | Unknowns at 1.5 (not 0); coverage shown; research queue targets range-crossing companies. |
| **Network bias** | W1 rewards whoever the board already knows. Over time the portfolio reflects the board's social circle, often concentrated in a few sectors. | Winnability damped to ×0.5–1.0; Tier B gets explicit "build a path" actions; track lead source and sector diversity. |
| **Halo effect** | One strong impression (exciting brand) bleeds into all ratings. | Anchored rubrics; evidence required for ratings ≥ 3; where feasible, have different people rate the value and need sides. |
| **Advocacy / Goodhart** | Board members inflate ratings for companies they want to work with or already contacted. | Ratings ≥ 3 need evidence; override reason categories; overrides reviewed against outcomes; ratings show the rater's name. |
| **Anchoring on the computed score** | People see 58.9 and stop thinking. | Show tiers and ranges, not decimals; the card leads with reasons and unknowns. |
| **Recency/staleness** | Last year's hiring boom is still rated 4. | Half-life per criterion, stale flags. |
| **Survivorship in calibration** | Calibrating only on past partners teaches the model what *used to* work, not what we never tried. | Deliberately approach a few Tier A/B companies from new sectors each semester as "exploration". |
| **AI enrichment errors** (if added) | Hallucinated facts become "evidence". | Source URL required; human verification step; AI-proposed evidence can't support a rating until verified. |

### 7.2 Structural weaknesses

1. **The weights are judgement, not truth.** With maybe 10–30 deals a year
   there will never be enough data to fit weights statistically. Don't
   pretend otherwise; be transparent about it. Mitigations: back-test
   against past partners, run a sensitivity check (does Tier A change if any
   single weight moves ±10?), and review each semester.
2. **Correlated criteria are double-counted.** V5 and N1 are both driven by
   hiring. In the Recruitment track that's intended, but be aware the
   Recruitment score is effectively "hiring, counted twice".
3. **Criteria interact non-linearly.** A world-class speaker (V2=4) with zero
   topic relevance (V3=0) is not a 50%-good speaker deal. If this shows up
   often, add a rule (e.g. K-track MutualFit capped at 40 if V3 ≤ 1). Don't
   add rules like this before the problem actually appears.
4. **Company-level scoring hides internal politics.** The relevant budget
   may sit with one department head. Scores give the "why", but W1 and the
   Person records carry most of the real winnability signal.
5. **Thresholds are arbitrary.** Tier cut-offs at 65/50/45 are starting points.
   Adjust them so the Tier A count matches team capacity (e.g. 8–12 active
   approaches per semester). A ranking that puts 40 companies in Tier A isn't useful.
6. **Data entry burden kills these systems.** Most CRM-style tools for
   student organisations are abandoned within a semester. Keep the
   quick screen short, make the deep assessment only for the shortlist, and
   design the handover report so maintaining the data visibly pays off.
7. **Overrides can quietly replace the model.** If more than ~20% of Tier A
   comes from overrides, either the rubric is missing something (fix the
   rubric) or the model isn't being trusted (find out why).
8. **Portfolio effects are ignored by per-company scores.** Ten sponsors
   from banking may each score well, but the portfolio is fragile and may
   breach exclusivity. The portfolio view (sector mix, track mix, capacity)
   has to sit next to the ranking.
9. **Ethics gates are policy questions, not scoring questions.** Which
   sectors are acceptable (fossil fuels, gambling, defence, tobacco…) should
   be a written board policy referenced by R1, not decided per company
   by whoever is rating.

---

## 8. MVP: build this first

### 8.1 Goal
In **3 weeks**, test whether a structured, evidence-based shortlist is
better than the current gut-feel approach, using a spreadsheet and no code.

### 8.2 Scope

**In:**
- One Google Sheet in a CBS Talks shared drive with tabs:
  1. `Companies`: long list with stage and owner
  2. `Rubric`: the 17 criteria with 0–4 anchors (read-only reference)
  3. `Ratings`: one row per company × criterion: value, rationale, evidence URL, confidence, rater, date
  4. `Weights`: the four track profiles + version note
  5. `Scores`: formula-only tab: side scores, mutual fit, winnability, priority, tier, coverage, top-3 drivers
  6. `Overrides`: value, reason, author, expiry
  7. `Pipeline`: opportunities + interactions (simple log)
  8. `Offerings`: CBS Talks catalog with need tags
- 4 tracks (S, K, R, T). In-kind is handled manually for now.
- Two-stage funnel: screen 60–100 companies, deep-assess the top 25–30.

**Out (for now):** People-level speaker scoring (use a free-text column),
staleness automation, AI enrichment, score ranges (show coverage only), web app.

### 8.3 Pilot procedure
1. **Week 1:** Document CBS Talks' own offer (§6.5). Agree weights in a
   one-hour board session. Write the ethics policy for R1.
2. **Week 1–2:** **Back-test.** Score 5–10 *past* partners and 5 companies
   that said no. If past successful partners don't score high, fix the
   rubric before going further. This is the cheapest test of whether the
   model works.
3. **Week 2:** Quick-screen the long list (split across 3–4 people). Have two
   people independently rate the same 10 companies and compare. Ratings more
   than one point apart point to an unclear rubric anchor.
4. **Week 3:** Deep-assess the shortlist. Partnerships Manager reviews Tier A/B,
   applies overrides with reasons, assigns owners.
5. **During the semester:** log every approach and outcome.

### 8.4 Success criteria (decide whether to build v1)
- The Partnerships Manager agrees with ≥ 70% of Tier A without overriding.
- Inter-rater agreement: ≥ 80% of double-rated criteria within ±1.
- Time per deep assessment ≤ 90 minutes.
- By semester end: response/meeting rate for Tier A approaches is noticeably
  higher than for non-tiered approaches in previous semesters (if that history exists).
- The sheet is still being updated in week 8. This is the most important test.

### 8.5 What v1 adds (only after the MVP passes)
Person-level speaker scoring, score ranges and research queue, staleness
flags, versioned weights in this repo, a company card view with generated
explanations, a portfolio/capacity view, renewal reminders, the handover
report, and then optionally the AI evidence assistant.

---

## 9. Open questions for the CBS Talks team

1. What are CBS's rules for student-organisation sponsorships (exclusivity,
   sector restrictions, overlap with CBS central corporate partners)?
2. What is the realistic team capacity: how many companies can you actively
   work per semester? That number sets the tier thresholds.
3. What are the revenue target and the split between cash and in-kind?
4. Is there history from past years (partners, amounts, renewals, refusals)
   to back-test against?
5. Who owns the system after the next board handover?
