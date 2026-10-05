# CBS Talks — Partnership Recommendation Engine

**v1.0 (2026-10-05).** Replaces the simple "recommended type" rule in
[`scoring-framework.md`](scoring-framework.md) §6.4. Feeds field 4 of the card
in [`explainability-layer.md`](explainability-layer.md).

The engine decides **which kinds of partnership to pursue with each company**,
in what order, at what commitment level, and why. It is a set of explicit
rules: no black box, no learned model.

---

## 0. Critique of the type list, and how the engine handles it

Your ten types are the right vocabulary, but they mix **three different
things**. Treating them as one flat list would produce contradictory
recommendations (e.g. "Speaker partner" vs "Annual strategic partner" as if
they excluded each other).

| What it describes | Types in your list | How the engine treats it |
|---|---|---|
| **What is exchanged** (the contribution) | Speaker, Recruitment, Knowledge, Content, Networking, In-kind, and the cash element of the sponsor types | **Contribution types.** A company can qualify for several |
| **How committed and how long** | One-off event sponsor, Recurring event sponsor, Annual strategic partner | **Commitment level.** One-off and recurring sponsors are cash contributions at different commitment levels. *Annual strategic partner is a container*: several contribution types bundled into one yearly agreement |
| **A verdict** | Potentially not worth pursuing | **Verdict**, decided after all types are evaluated, with reasons and conditions for revisiting |

So the output is: **a verdict + a primary type + secondary types + add-ons +
a long-term target + types we deliberately don't recommend**. Each
recommended type carries its commitment level and a "why".

Three more design decisions:

1. **"Highest value" is not the selection rule.** The primary type must be
   (a) eligible, (b) *ready now* given our relationship, (c) good for the
   company too, and (d) aligned with what CBS Talks needs **this
   semester**. Value only decides between types that pass all four.
2. **No cash as the opening ask without a relationship.** Asking a cold
   contact for money first rarely works and burns the contact. Financial
   types are marked "later" until Outreach (G) is at least 50. They then
   appear as the next step after a first, smaller collaboration.
3. **Knowledge and Content partners get stricter independence rules.** These
   are the types where a partner shapes what CBS Talks says on stage. Any
   editorial-independence risk flag blocks them.

---

## 1. Partnership type definitions

| Type | CBS Talks gets | The company gets | Typical profile | Example deliverable |
|---|---|---|---|---|
| **One-off event sponsor** | Cash for one event | Visibility with a targeted audience at one event | Has budget; topic fits a specific event; no relationship history yet | Sponsorship of one themed evening |
| **Recurring event sponsor** | Cash for a series / every semester | Repeated visibility; association with a series | Has budget, a recurring need and **prior positive engagement** with us | Sponsor of the semester's career-themed talks |
| **Annual strategic partner** | A bundle: cash + 2 or more other contributions, co-planning, one-year agreement | Priority positioning, co-created programme, continuous student access | Strong on several types, long-term logic, an existing relationship, verified budget | Year agreement: series sponsorship + recruitment events + speakers |
| **Speaker partner** | Speakers people want to hear | Visibility for their leaders and topics; employer brand | A strong named person; topic fit. **No budget needed** | Keynote, panel, fireside chat |
| **Recruitment partner** | Career value for students | Direct access to CBS talent | Hires business profiles; has a talent need | Case workshop, recruitment mixer, office visit |
| **Knowledge partner** | Expertise, data and research that improve our content | Being seen as an expert on a topic | Has proprietary research/data or recognised expert functions | Data for a debate, co-curated topic, expert jury |
| **Content partner** | Co-produced media and distribution reach | Content and an audience for their topic or employer brand | Has their own media channels or production capacity | Podcast series, video interviews, article series |
| **Networking partner** | Access to networks: speakers, other partners, the ecosystem | Access to students and to the CBS community | Plays an ecosystem role: VC, incubator, association, chamber, embassy | Introductions to founders, co-hosted mixer |
| **In-kind partner** | Venue, catering, AV, production, prizes | Low-cost visibility; community engagement | Has the specific resources CBS Talks needs | Venue for a semester's events |
| **Potentially not worth pursuing** | — | — | No type passes, or the effort outweighs the value | Revisit if a stated condition changes |

---

## 2. Inputs

### 2.1 From the scoring framework (existing)
- Dimensions D1–D9
- Sub-scores A–G
- Fit and tier
- Mutual-value cap, risk flags, coverage, confidence

### 2.2 New: Need flags (they structure the existing D3 rating)

D3 (Partner Need) is now recorded as four flags, each 0 / 1 / 2. These say
**what's in it for them**, so each type can check that it serves a real need.

| Flag | 0 | 1 | 2 |
|---|---|---|---|
| `talent` | No hiring of CBS profiles | Some hiring; pipelines are fine | Volume or recurring hiring that they struggle to fill |
| `brand_gap` | Already well known among students, or no hiring need | Moderately known relative to hiring need | High hiring need and low student awareness (rule IR1) |
| `positioning` | No public agenda on our topics | Some activity on one of our topics | Active campaign or leadership agenda on our topics |
| `audience` | Our audience isn't their target | Partial overlap | Our audience is exactly their target (study lines, profiles) |

**Consistency check:** the D3 rating should match the flags. D3 = 0 if all
flags are 0. D3 ≥ 75 needs two flags at 2. If they disagree, the card shows a
warning.

### 2.3 New: Capability flags (what they *could* contribute beyond cash)

Each is 0 / 1 / 2 (used as 0 / 50 / 100 in formulas) and needs evidence, just
like ratings.

| Flag | 0 | 1 | 2 |
|---|---|---|---|
| `expertise` | Nothing beyond general business knowledge | Recognised expert function or occasional public reports | Proprietary research, data or a recognised expert team on our topics |
| `media` | No own channels | Active channels with some reach, or occasional production | Strong own channels relevant to students, or in-house production capacity |
| `network` | No ecosystem role | Hosts or joins communities; useful contacts | Central ecosystem role: VC, incubator, association, chamber, alumni body |
| `inkind` | Nothing relevant | Some of: venue, catering, AV, production, prizes | Several of these, at our event scale |

`inkind_offer` lists *what* they could provide (venue, catering, AV,
production, software, prizes…). It is matched against what CBS Talks
currently needs (§2.4).

### 2.4 New: CBS Talks Objectives Profile (set by the board each semester)

This is what makes recommendations **depend on CBS Talks' objectives**.

| Setting | Example (fictional) |
|---|---|
| Need level per type: **High** (+10) · **Normal** (0) · **Low** (−10) · **Closed** (deferred) | Financial: High (budget gap) · Speaker: Normal · Recruitment: Normal · Knowledge: Low · Content: Normal · Networking: Low · In-kind: High |
| In-kind needs | venue, catering, AV |
| Annual strategic partner slots | Max 3, currently 2 used, so 1 available |
| Category exclusivity held | e.g. "Banking: held by current partner until June 2027" |
| Themes this year | e.g. "Fragile Systems", "Work after AI" |
| Speaker slots to fill | e.g. 6 this semester |

The need adjustment is **additive and shown on the card** ("+10: CBS Talks
needs cash this semester"), so its effect is never hidden.

---

## 3. Engine steps

```
0. Gates & data check      → Excluded / Insufficient data           (stop)
1. Eligibility per type    → eligible / possible if confirmed / not eligible (+ failed conditions)
2. Mutuality per type      → does the type serve one of their needs?
3. Suitability per type    → 0–100 from existing scores, + objective adjustment
4. Readiness               → ready now / later (after first collaboration)
5. Composition             → primary, secondary, add-on, target, also possible, not recommended
6. Commitment level        → one-off pilot / recurring / annual, per recommended type
7. Verdict                 → Pursue now / Build a path / Opportunistic / Narrow opportunity /
                              Not worth pursuing now
8. Explanation             → why / why not, each line tagged [V]/[I]/[?]
```

### Step 0 — Gates and data check

| Condition | Result |
|---|---|
| Any gate risk flag | **Excluded** (with reason). No types evaluated |
| Provisional (coverage < 70% or Low confidence) | **Insufficient data**. Types are listed as "possible" only, with the research needed. The engine **never** says "not worth pursuing" because of missing data |

### Step 1 & 2 — Eligibility and mutuality rules

A type is **eligible** only if all its conditions pass **and** it serves at
least one company need (mutuality).

| Type | Eligibility conditions (all required) | Mutuality: serves need | Blocked by |
|---|---|---|---|
| **One-off sponsor** | D6 ≥ 50 · D2 ≥ 50 · D1 ≥ 50 | `brand_gap`, `audience` or `positioning` ≥ 1 | Category exclusivity held by another partner; Financial = Closed |
| **Recurring sponsor** | D6 ≥ 50 · D7 ≥ 50 · D3 ≥ 50 · **prior positive engagement with CBS Talks** [V] | as above | as above |
| **Annual strategic** | Sub-score F ≥ 70 · D2 ≥ 75 · **at least 2 "strong" types** (eligible, suitability ≥ 60 *before* the objective adjustment, counting financial as one) · ≥ 2 needs ≥ 1 with at least one = 2 | (built into conditions) | No slot available; any independence (R2) flag; exclusivity |
| **Speaker partner** | D4 ≥ 50 with a Person record · D2 ≥ 50 | `positioning` or `brand_gap` ≥ 1, **or** the speaker is personally motivated [V] | — |
| **Recruitment partner** | D5 ≥ 50 · D1 ≥ 50 | `talent` ≥ 1 | — |
| **Knowledge partner** | `expertise` ≥ 1 · D2 ≥ 75 | `positioning` ≥ 1 | Any R2 flag |
| **Content partner** | `media` ≥ 1 · D2 ≥ 50 · D1 ≥ 50 | `positioning` or `brand_gap` ≥ 1 | Any R2 flag |
| **Networking partner** | `network` ≥ 1 · D1 ≥ 50 | `audience` or `talent` ≥ 1 | — |
| **In-kind partner** | `inkind` ≥ 1 · `inkind_offer` matches at least 1 current in-kind need | any need ≥ 1 | — |

**Unknown inputs:** if a condition can't be evaluated because its input is
UNKNOWN or has only an unverified [?] claim, the type becomes **"Possible if
confirmed: <condition>"**. It can't be primary or secondary until confirmed.

**Near miss:** a type that fails exactly **one** condition is recorded as a
near miss. These feed "Not recommended — would change if…" and "revisit when…".

### Step 3 — Suitability per type (0–100)

> "B" in the formulas below is the Financial Potential Score
> ([`financial-potential-model.md`](financial-potential-model.md)). Annual-strategic
> readiness now requires an **estimated tier ≥ 20–50k with evidence level A or B**
> in place of "D6 ≥ 75 with verified history".

Built only from existing scores, so it is traceable:

| Type | Formula |
|---|---|
| One-off sponsor | 0.6 × B + 0.4 × D2 |
| Recurring sponsor | 0.5 × B + 0.3 × F + 0.2 × C |
| Speaker partner | D (Speaker sub-score) |
| Recruitment partner | E (Recruitment sub-score) |
| Knowledge partner | 0.5 × D2 + 0.3 × expertise + 0.2 × D8 |
| Content partner | 0.4 × D2 + 0.3 × media + 0.3 × D1 |
| Networking partner | 0.5 × network + 0.3 × D1 + 0.2 × D2 |
| In-kind partner | 0.5 × inkind + 0.3 × need match (1 need = 50, 2+ = 100) + 0.2 × D1 |
| Annual strategic | No formula. It is a rule-based container (Step 5) |

**Adjusted suitability** = suitability + objective adjustment (+10 / 0 / −10), capped at 100.
"Closed" types are moved to **Deferred: no capacity this semester**.

### Step 4 — Readiness

| Type | Ready now when | Otherwise |
|---|---|---|
| One-off / recurring sponsor | G ≥ 50 (a relationship exists) | **Later**: shown as "after first collaboration" |
| Annual strategic | Eligible **and** D6 ≥ 75 with verified sponsorship history at standard-ask level **and** (G ≥ 60 **or** a past CBS Talks partnership that ended well) **and** a slot available | **Target**: shown as the long-term goal with a pathway |
| All other types | Always ready (they are low-commitment and good first steps) | — |

### Step 5 — Composition

Applied in this order:

1. **Annual container.** If Annual strategic is *ready*, it becomes
   **primary**. Its **components** are the top two eligible non-financial types by
   adjusted suitability; the cash element is included. The one-off and
   recurring sponsor types are absorbed into it.
   *Why:* when a company qualifies, one integrated agreement is worth more
   and costs less to run than several separate deals.
2. **Otherwise the primary** is the eligible, *ready* type with the highest adjusted
   suitability, with these constraints:
   - **In-kind is a complement.** It can be primary only if no financial type is
     eligible. Otherwise it is listed as an **add-on**.
   - **One-off vs recurring:** if both are eligible, show only recurring.
3. **Tie-break** (within 2 points): choose the type that is cheaper for both
   sides to deliver, in this order: speaker → networking → in-kind →
   recruitment → content → knowledge → one-off → recurring. This is
   the **easiest first step** principle.
4. **Secondary** (max 2): eligible types (ready *or later*) with adjusted
   suitability ≥ 60 **and** ≥ primary − 20. A "later" financial type is shown as
   "Secondary, after first collaboration".
5. **Target:** Annual strategic, if eligible but not ready.
6. **Also possible:** other eligible types with adjusted suitability ≥ 50.
7. **Not recommended:** always includes the **financial verdict** if no financial
   type was recommended (everyone asks "will they pay?"); Annual strategic
   if the company has 1000+ employees and Annual wasn't recommended (readers
   will expect it); plus any near-miss type whose suitability would be ≥ 60. Each
   one says what blocks it and what would change it.

### Step 6 — Commitment level per recommended type

| Level | Rule |
|---|---|
| **Annual** | Only through the annual container |
| **Recurring** | F ≥ 60 **and** G ≥ 50 |
| **One-off pilot** | Everything else. Long-term relationships start with one successful event |

### Step 7 — Verdict

| Verdict | Rule (first match wins) |
|---|---|
| **Excluded** | Gate (Step 0) |
| **Insufficient data** | Provisional (Step 0) |
| **Not worth pursuing now** | NW1: no eligible type · NW2: best adjusted suitability < 50 · NW3: Tier D and best < 70 · NW4: mutual-value cap applied **and** G < 50 **and** best < 70 · NW5: effort High **and** best < 65 |
| **Pursue now** | Tier A, or fast-track |
| **Build a path** | Tier B |
| **Opportunistic** | Tier C |
| **Narrow opportunity** | Tier D but one type ≥ 70 (e.g. a venue we need). Pursue only that type |

"Not worth pursuing now" always comes with **"Revisit when…"**, taken from
the near misses (e.g. "if they start graduate hiring", "if we need software
tools"). It means *not now*, not *never*.

### Step 8 — Explanations

Each recommended type gets a **Why** with four parts. Each part comes from
the rule that fired and is tagged [V] / [I] / [?] according to the
explainability layer.

1. **Fit:** the conditions that made it eligible, with evidence
   ("COO has two recorded keynotes [V]; topic matches 'Fragile Systems' [V]").
2. **What they get:** the need it serves ("serves their talent need: 20 postings/year [V]").
3. **What we need:** the objective adjustment ("+10: In-kind is High this semester; we need a venue").
4. **Commitment:** why this level ("one-off pilot: no relationship yet, G = 44").

Each **Not recommended** type gets a **Why not** (the failed conditions) and a
**Would change if** (the near-miss condition).

---

## 4. Special rules

| Situation | Rule |
|---|---|
| **Existing partner** | Default primary = **renew the current type**, if satisfaction is logged as good. Secondary = the best eligible type they don't have yet (expansion). If renewal is unlikely, the engine evaluates them as a new prospect |
| **Lapsed partner (ended badly)** | Financial and annual types are blocked for 12 months. Other types are allowed only with an override and a reason |
| **Competitor of an exclusive partner** | Sponsor and annual types are blocked. Speaker and Knowledge are allowed unless the exclusivity contract says otherwise. Check the contract wording |
| **Startups / small companies** | No special rule is needed. The anti-size rule on D6 plus the speaker, networking and knowledge types naturally give them non-financial recommendations |
| **Non-company partners** (associations, embassies, NGOs, public bodies) | Same rules. They typically qualify as Networking or Knowledge partners. Financial types are rarely eligible because D6 needs a sponsorship history |
| **Override** | The Partnerships Manager can change primary, secondary or verdict with a reason category and an expiry date. The card shows the engine's original suggestion next to the override |

---

## 5. Worked examples

> G values below use the Outreach Likelihood Score
> ([`outreach-likelihood-and-matrix.md`](outreach-likelihood-and-matrix.md) §6.1).
> Only MegaBrand and Kobber Hotels changed as a result.

All companies are **fictional**, and the ProServ ratings are **hypothetical**.
I checked every number below with a short script that applies these rules
exactly. Objectives profile as in §2.4: Financial High, In-kind High,
Knowledge Low, Networking Low, others Normal; 1 annual slot available.

### 5.1 ProServ, a Deloitte-type professional services firm, **with** an existing relationship
*(Hypothetical ratings for illustration, not an assessment of any real firm.)*
D1–D9: 100, 75, 75, 75, 100, 100 (verified history), 100, 100, 75 · Needs: talent 2, brand_gap 0, positioning 2, audience 1 · past partner, ended well
Scores: A 87 · F 89 · G 75 · Tier A

```
Verdict:    PURSUE NOW
Primary:    Annual strategic partner (annual)
            components: Recruitment partner (adj. 94) + Speaker partner (adj. 78) + cash
Add-on:     In-kind: venue (adj. 70)
Also possible: Knowledge partner (78), Content partner (75), Networking partner (60)
Not recommended: — (all types eligible)
```

**Why annual strategic:** strong on four or more types (Recruitment 94,
Financial 92, Knowledge 88, Speaker 78); long-term logic (F 89); verified
sponsorship at standard-ask level; a past partnership that ended well; one
slot available. Bundling avoids running three separate deals with the same company.
**Why Recruitment as a component:** their talent need is 2 (volume hiring of
CBS profiles) and student value is high (C 93).
**Why Speaker, not Knowledge:** they tie at 78 after Knowledge is lowered by
−10 (Knowledge need is *Low* this semester). The tie-break picks the easier
first step. Next semester, if Knowledge is set to Normal, Knowledge would
replace Speaker.

### 5.2 The same firm **without** a relationship (D9 = 25)
Scores: A 81 · F 84 · G 38 · Tier B

```
Verdict:    BUILD A PATH
Primary:    Recruitment partner — one-off pilot (adj. 94)
Secondary:  One-off event sponsor — after first collaboration (adj. 96)
Secondary:  Speaker partner — one-off (adj. 78)
Add-on:     In-kind: venue (adj. 70)
Target:     Annual strategic partner
Also possible: Knowledge partner (78), Content partner (75), Networking partner (60)
Not recommended: Recurring sponsor (no prior engagement with us; would change after a successful first event)
```

**Why not lead with sponsorship, even though its value is higher (96 vs 94)?**
There's no relationship (G 38). A cold cash ask is the most likely way to
get a "no" that closes the door for a year. Recruitment serves their
strongest need (talent = 2), so it is the easiest way in.
**This is the key difference from your Deloitte example:** "Annual strategic
partner" is the *right goal* but the *wrong first ask* unless the relationship
already exists.

### 5.3 Fjord Ventures, a small fintech startup
D1–D9: 75, 100, 50, 100, 25, 25, 50, 50, 100 · Needs: talent 0, brand_gap 1, positioning 2, audience 1 · Capabilities: expertise 1, media 1, network 2
Scores: A 68 · D 98 · G 88 · Tier C, fast-track A (Speaker)

```
Verdict:    PURSUE NOW (fast-track: Speaker)
Primary:    Speaker partner — recurring (adj. 98)
Secondary:  Networking partner — recurring (adj. 83)
Secondary:  Content partner — recurring (adj. 78)
Also possible: Knowledge partner (65)
Not recommended: Event sponsor — no budget evidence (D6 = 25); would change with
                 a verified sponsorship or a funding round with marketing spend
```

**Why Speaker:** a founder with proven talks on a central theme; serves their
positioning need (2). **Why Networking:** their investor and founder network
can supply more speakers. That is worth more to us than their cash would be.
**Why recurring:** warm relationship (G 88) and reasonable long-term logic (F 63).
This matches your startup example.

### 5.4 Nordlys Logistics, a mid-size B2B company unknown to students
Scores: A 65 · F 75 · G 44 · Tier B

```
Verdict:    BUILD A PATH
Primary:    Recruitment partner — one-off pilot (adj. 81)
Secondary:  One-off event sponsor — after first collaboration (adj. 80)
Target:     Annual strategic partner
Also possible: Speaker partner (58; COO's speaking ability unverified), Knowledge partner (53)
Not recommended: Recurring sponsor — no prior engagement (changes after the pilot)
```

**Why:** their talent need and brand gap are both 2, which Recruitment serves
directly. Annual strategic is already *eligible* (F 75, D2 75, three strong types, two
needs at 2). It isn't *ready*: there is no relationship yet and no verified
budget, so it is the target, not the ask.

### 5.5 MegaBrand A/S, a top student employer that doesn't need us
Scores: A 55 (capped; D3 = 25) · G 62.5 (Outreach Likelihood Score) · Tier C / Q3

```
Verdict:    OPPORTUNISTIC
Primary:    Recruitment partner — one-off (adj. 81)
Secondary:  Content partner — one-off (adj. 80)
Secondary:  One-off event sponsor — ready now (adj. 74; G ≥ 50 under the Outreach Likelihood Score)
Add-on:     In-kind: venue (adj. 70)
Also possible: Speaker partner (73), Networking partner (55)
Not recommended: Annual strategic (F 45; only weak needs, none at 2)
```

**Why opportunistic:** students would love it (C 90), but the company has
little to gain (needs: talent 1, others ≤ 1). Respond if they approach us;
don't spend scarce outreach time on them.

### 5.6 Kobber Hotels, a hotel group with venues
D1–D9: 50, 50, 50, 25, 50, 25, 75, 50, 75 · Capabilities: inkind 2 (venue, catering), network 1
Scores: A 47 · Fit 46 · G 48.5 (Outreach Likelihood Score) · Tier D / Q4

```
Verdict:    NARROW OPPORTUNITY
Primary:    In-kind partner — one-off pilot (adj. 100: venue + catering, In-kind need High;
            recurring once G ≥ 50)
Also possible: Recruitment partner (50)
Not recommended: Event sponsor — no budget evidence (D6 = 25)
```

**Why pursue a Tier D company?** Because of **our** objectives: we need a
venue this semester, and they have one. The overall score would never have
surfaced them. The objectives profile does.

### 5.7 Gamma Software ApS, a software vendor
Scores: A 32 · Tier D · no eligible type

```
Verdict:    NOT WORTH PURSUING NOW (NW1: no eligible type)
Near misses: In-kind (offers software licences; we don't currently need software)
Revisit when: we need tools or software, or they start hiring business graduates
```

---

## 6. Portfolio-level checks (across all companies)

Per-company recommendations can add up to a bad portfolio. The engine runs
these checks on the full set of Primary recommendations at Tier A/B:

- **Capacity:** the number of "Pursue now" companies should be ≤ the team's
  outreach capacity. If there are more, keep the highest-ranked.
- **Annual slots:** never recommend more annual partners than there are free slots.
  If several qualify, rank them by F, then A.
- **Sector concentration:** warn if more than 40% of financial recommendations come from one sector.
- **Coverage of objectives:** warn if a "High" need type (e.g. In-kind) has
  no candidates. That points the research queue there.
- **Speaker pipeline:** speaker recommendations should be at least the number of
  open speaker slots × 2, since many speakers decline.

---

## 7. Changes to other documents

- **Data model:**
  - Add `need_flags{talent, brand_gap, positioning, audience}` (with evidence) to the D3 rating.
  - Add `capabilities{expertise, media, network, inkind}` + `inkind_offer[]` to Company, each with evidence.
  - Add an `ObjectivesProfile` entity (versioned per semester).
  - Add a `Recommendation` snapshot holding the verdict, primary, secondary, add-ons, target, not-recommended, and the fired rules.
- **Explainability card, field 4** now shows the engine output: verdict ·
  primary (commitment) · secondary · target · one "why" line per type ·
  one "why not" line for the financial verdict.
- **Scoring framework §6.4** is replaced by this engine.

---

## 8. Weaknesses

1. **Many thresholds.** About 30 cut-offs (≥ 50, ≥ 75, ≥ 60, −20…) are judgement.
   Each is reasonable, but together they can produce odd edge cases.
   Back-test on past partners. Treat every override as a signal about which
   threshold is wrong, not just a one-off exception.
2. **The objective adjustment can be gamed.** Setting a type to "High" pushes many
   companies toward it. That's the intended effect, but the board should
   set the profile once per semester, not adjust it to promote a favourite company.
3. **The cliff effect.** D6 = 50 makes a company eligible as a sponsor; 25 doesn't.
   On a 5-step scale this is unavoidable. The near-miss list exists so
   borderline companies aren't silently dropped.
4. **Capability flags add research work.** Fill them during the full assessment
   only, not during the quick screen. Leave them UNKNOWN otherwise; the
   engine will mark those types "possible if confirmed".
5. **The "no cash first" rule is a strategic assumption.** It is right for most
   cold outreach, but some companies run open sponsorship application processes. If
   a company has a public application route [V], add an override.
6. **The engine recommends; people decide.** A mechanically correct
   recommendation can still be wrong for reasons the data doesn't capture
   (internal politics, a recent reorganisation). That is what overrides are for,
   and why overrides are reviewed against outcomes each semester.
