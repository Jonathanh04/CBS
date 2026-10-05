# CBS Talks Partnership Priority Score — Scoring Framework

**v1.0 (2026-10-05).** This document replaces §3–§5 of
[`partnership-scoring-design.md`](partnership-scoring-design.md) (dimensions,
weights, calculation). The architecture, data model, information plan, bias
analysis and MVP in that document still apply. Where they refer to "criteria",
read "dimensions" from this document. How scores are explained to users is
specified in [`explainability-layer.md`](explainability-layer.md).

---

## 1. Overview

Each company gets **nine dimension scores**. Each one is rated against written
definitions of what 0, 50 and 100 mean, and is backed by evidence.

The dimensions combine into **seven visible scores**:

| Code | Score | Question it answers |
|---|---|---|
| **A** | **Partnership Priority** (the "CBS Talks Partnership Priority Score") | Who should we work on first, overall? |
| B | Financial Potential | How much money could this realistically bring? |
| C | Student Value | How much would CBS students gain? |
| D | Speaker Potential | Can they give us a speaker people want to hear? |
| E | Recruitment Potential | Is this a strong career/recruitment partnership? |
| F | Long-Term Partnership Potential | Could this become a multi-year relationship? |
| G | Outreach Likelihood | How likely is a successful approach, and how soon? |

Rules that keep the overall score transparent:

1. **A is never shown alone.** Every list and company card shows A together
   with B–G, the action tier and the recommended partnership type.
2. **Every score breaks down into dimension contributions.** "A = 65 because
   +13.0 from Partner Need, +11.3 from Student Relevance…"
3. **Adjustments are separate, visible lines.** If a cap or risk penalty
   changes a score, the card says so and why. They are never folded silently
   into the number.
4. **Sub-scores B–F work as partnership-type scores.** This keeps the critique
   point that sponsor, speaker and recruitment value are different things. A
   ranks overall; B–F rank for a specific need ("we need three speakers for
   March" → sort by D).

---

## 2. How the earlier critique is built in

| Critique point | Where it lives in this framework |
|---|---|
| One list hides different partnership types | Sub-scores B–F work as type scores; recommended type rule (§6.4); fast-track rule (§6.3) |
| Fit vs. likelihood are mixed | Outreach is its own dimension (D9) and score (G). Tiers are set by **Fit vs. Outreach** (§6.3) |
| Two-sided value must be enforced | **Partner Need** dimension (D3: value to them, scored alongside value to us) + **mutual-value cap** (§6.2) |
| Strategic fit over size | Size isn't a dimension; Financial Potential needs *sponsorship history* to go above 50; Brand weight is lowest; Partner Need rewards companies that *need* us |
| Speakers are people | D4 is rated on the **best named person**, recorded as a Person record |
| Vague "brand"/"strategic" value | Narrow dimensions with exact 0/50/100 anchors |
| Deep scoring doesn't scale | Quick screen uses 4 dimensions (§7); full scoring only for the shortlist |
| Unknown ≠ zero | Unknowns counted at 35, coverage shown, provisional flag (§6.5) |
| Static partnership label | Recommended type + entry offer (§6.4) |
| Feedback loop | Outcomes logged; weights recalibrated every semester (§9) |

---

## 3. The nine dimensions and their weights

Your list had ten candidate dimensions. I **merged two pairs** and **added
one** to avoid double counting and to enforce mutual value:

- "Strategic alignment" + "event/topic collaboration" → **D2**. A company
  can't have high collaboration potential on a topic that doesn't fit our
  strategy, so scoring both would count the same thing twice.
- "Likelihood of successful outreach" + "existing relationship / proximity to
  CBS" → **D9**. An existing relationship and CBS proximity are the main
  *reasons* outreach succeeds. Rating both would reward warm contacts twice,
  which strengthens the network bias.
- **Added D3, Partner Need.** Your list measured only what *we* get. Without
  this dimension the model can't answer "what could CBS Talks offer them?" and
  would favour famous companies that don't need us.

| # | Dimension | Weight | Side |
|---|---|---:|---|
| D1 | Student Relevance | **15** | Value to CBS Talks |
| D2 | Strategic & Topic Alignment | **13** | Value to CBS Talks |
| D3 | Partner Need (what we can offer them) | **13** | Value to the company |
| D4 | Speaker Potential | **13** | Value to CBS Talks |
| D5 | Recruitment & Employer-Branding Potential | **9** | Value to students + company |
| D6 | Financial Sponsorship Potential | **10** | Value to CBS Talks |
| D7 | Long-Term Partnership Potential | **10** | Both |
| D8 | Brand Credibility | **5** | Value to CBS Talks |
| D9 | Outreach Likelihood & CBS Proximity | **12** | Winnability |
| | **Total** | **100** | |

### 3.1 Why these weights

- **Student Relevance is highest (15).** The student audience is what CBS
  Talks has to offer partners, and serving students is the reason it exists.
  If students don't care, every other benefit falls apart: speakers face empty
  rooms and sponsors get no return.
- **Alignment, Partner Need and Speaker Potential share second place (13
  each).**
  - Alignment protects the editorial identity. Without it CBS Talks becomes an
    advertising channel.
  - Partner Need is the best predictor of a "yes" and of renewal.
  - Speakers are CBS Talks' core product.
- **Financial is deliberately not dominant (10).** Money matters, but it is
  the dimension most correlated with company size. It also partly follows from
  Partner Need: companies that need us pay us. Weighting it heavily would
  re-create the "biggest company wins" ranking you want to avoid.
- **Recruitment is 9, but recruitment *motivation* is also counted in D3.**
  D5 measures the career value *for students*. The company's hiring need sits
  in D3. Together, hiring-related evidence drives about 15–20 points, which
  is about right for a business school.
- **Long-term (10)** is weighted equally with Financial because a renewing
  partner is worth several one-off sponsors and costs far less effort.
- **Brand Credibility is lowest (5).** It is strongly size-correlated, overlaps
  with Student Relevance, and its main value (credibility with other partners)
  is a second-order effect.
- **Outreach is 12.** That is enough to break ties toward reachable
  companies, but a perfect-fit company with no contact loses at most 12
  points. Being *reachable* should never outweigh being *valuable*. The "who
  first" decision is handled by the tiers (§6.3), not by inflating this weight.

These weights are a **hypothesis**, not a fact. They must be back-tested
(§9) before you trust them.

---

## 4. Rating scale and evidence rules (all dimensions)

- **Scale:** 0, 25, 50, 75, 100 only. 0, 50 and 100 are defined exactly below.
  Use 25 or 75 when the evidence clearly falls between two anchors. Finer steps
  imply a precision that human judgement doesn't have.
- **UNKNOWN** is a valid rating, and the honest one when no evidence exists (§6.5).
- **Evidence:** a rating of **75 or 100 requires at least one evidence item
  with a source** (URL, document or logged interaction). A rating of 50 or
  below may be an assumption, but must be marked as one.
- **Confidence:** each rating is High / Medium / Low.
  - High = direct, recent, verified evidence.
  - Medium = credible but indirect evidence.
  - Low = assumption or old evidence.
- **Generation modes** used below:
  - **Auto:** calculated from structured data; no judgement needed.
  - **Assisted:** the system proposes a value from data or indicators; a person
    confirms or changes it, with a reason.
  - **Manual:** a person rates against the anchors.
- **Data access rule:** LinkedIn data is looked up and entered by hand. Don't
  scrape it; that breaks LinkedIn's terms of service.

---

## 5. Dimension definitions

### D1 — Student Relevance (weight 15)

*How much do CBS students care about this company, its industry, its problems
or its careers? This measures interest and attendance pull among our audience,
not general fame.*

| Score | Exact definition |
|---|---|
| **0** | No link to any CBS study programme: students wouldn't study, work in or follow this company's field. No sign of student interest (no rankings presence, no past CBS events, not a case company). We would expect weak sign-ups even with heavy promotion. |
| **50** | Clearly relevant to **one or two** CBS programmes or one student segment (e.g. supply chain, or finance students only). Moderate interest: we expect a normal-size audience with our usual promotion. |
| **100** | Relevant across **three or more** CBS programmes **and** shows demonstrated high interest: one or more of a top position in student employer rankings, a past CBS event with them full or waitlisted, use as a recurring case in CBS courses, or top-quartile result in our own audience pulse survey. |

**Evidence:**
- Mapping to CBS programmes (which study lines they hire from or teach cases about)
- Past sign-up and attendance data for this company or sector at CBS Talks
- Student employer-ranking positions for business students
- **CBS Talks audience pulse survey**: a short twice-yearly poll asking "would
  you attend a talk with…?" over the long list. This is the cheapest way to
  replace board members' taste with real student data.

**Generation: Assisted.**
- Auto inputs: our own attendance data, survey results, ranking positions entered once a year.
- Manual: programme mapping.
- If survey data exists, it overrules board judgement unless an override with a reason is recorded.

---

### D2 — Strategic & Topic Alignment (weight 13)

*Does the company fit CBS Talks' mission and this year's themes, and is
there a concrete event or content collaboration we could build with them?*

| Score | Exact definition |
|---|---|
| **0** | No overlap with any current CBS Talks theme. The only possible collaboration is generic visibility (logo, booth). Working with them would make us look like an advertising channel. |
| **50** | Fits **one** current theme in a general way. We can describe one plausible event with them, but it would be a standard format and not unique to them. |
| **100** | A **central case** for a current theme, **and** we can name a **specific co-created format** that only they could deliver (e.g. a series, a live case, a debate, unique data or access). |

**Evidence:**
- Company strategy and annual report themes, CEO/leadership public statements, recent news
- Match against CBS Talks' written theme list for the year
- A one-sentence draft event concept (required for 75 or 100)

**Generation: Manual.** The system can suggest a theme match, e.g. by keyword
matching or an AI suggestion with a source link. A person confirms it and
writes the event concept.

---

### D3 — Partner Need: what CBS Talks can offer them (weight 13)

*How strongly does the company need what we offer: access to CBS talent,
employer-brand visibility among students, a platform for their positioning,
or access to our audience?*

| Score | Exact definition |
|---|---|
| **0** | Nothing in our offering catalog solves a problem they have. Either they don't hire business profiles and have no positioning agenda on our topics, **or** they are already a top-ranked student employer with full applicant pipelines and no topic agenda. |
| **50** | **One** clear need we can partly meet. For example, they hire some CBS profiles but already have reasonable student awareness, **or** they have a positioning agenda on one of our topics but no hiring need. |
| **100** | **Two or more** strong needs we are well placed to meet. Typical case: high recurring hiring of CBS-type profiles **plus** low student awareness (the *employer-brand gap*), and/or an active campaign on a topic we cover. |

**Evidence:**
- Hiring volume for business profiles compared with their student-ranking position (the gap)
- Whether they have an employer-branding or talent-attraction function, and recent hires into it
- Public campaigns or positioning initiatives
- Statements made in conversations (logged interactions count as evidence)

**Generation: Assisted.** The system proposes a gap indicator from D5's hiring
data and the ranking position: high hiring with no ranking position suggests a
high need. A person confirms it and adds positioning needs.

**Also used for:** choosing the offer package (§6.4).

---

### D4 — Speaker Potential (weight 13)

*Rated on the **best available named person** at the company, not the company in general.*

| Score | Exact definition |
|---|---|
| **0** | No identifiable person who would draw a CBS audience, **or** the only candidates can't be reached at all (no contact path, known to decline). |
| **50** | A **named** senior leader or expert with a relevant topic, **but** either their speaking ability is unproven (no recordings or past talks found) **or** their public profile is limited, and a contact path exists but isn't confirmed. |
| **100** | A **named** person with **all of** these: a recognised public profile, proven speaking ability (recordings or past conference talks), a topic that fits a current theme, able to present in English, **and** a realistic path to reach them (a contact, a past CBS appearance, or a confirmed intermediary). |

**Evidence:**
- Talk recordings, conference programmes, podcasts, op-eds, media appearances
- LinkedIn following (entered by hand)
- Past CBS appearances
- **A Person record must exist for any rating of 50 or more.**

**Generation: Manual.** The system or an AI assistant may *suggest* candidate
names with sources. Rating speaking ability always needs a person to watch or
listen to evidence.

---

### D5 — Recruitment & Employer-Branding Potential (weight 9)

*How valuable are their jobs to CBS students, and how active are they in
campus recruitment?*

| Score | Exact definition |
|---|---|
| **0** | No roles relevant to CBS students posted in the past 12 months, no graduate programme, no internships or student jobs. |
| **50** | Regular hiring of relevant roles (about 5–20 relevant postings in 12 months, or recurring student jobs), **but** no structured graduate programme and no visible campus recruitment. |
| **100** | A structured **graduate programme or internship programme** aimed at business students, **more than 20** relevant postings in 12 months, **and** visible campus recruitment (CBS or other universities: career fairs, case competitions). |

**Scoring aid** (indicator points; the system calculates a suggested value and
rounds it to the nearest 25):

| Indicator | Points |
|---|---:|
| Graduate programme for business profiles | 40 |
| Internships / student jobs for business profiles | 20 |
| Relevant postings in 12 months: 0 → 0 · 1–5 → 10 · 6–20 → 20 · >20 → 25 | 0–25 |
| Visible campus recruitment activity | 15 |

The posting thresholds are starting points. Adjust them after the first 30
companies to fit the Danish market.

**Evidence:** Jobindex, LinkedIn Jobs, the company careers page, career fair
exhibitor lists, graduate programme pages.

**Generation: Assisted.** The indicators are mostly counts that can be checked
quickly, so this is the most automatable dimension. A person confirms the
count and checks that the roles really are relevant to CBS students.

---

### D6 — Financial Sponsorship Potential (weight 10)

> **Now derived, not rated:** D6 = the Capacity + Propensity index of the
> [Financial Potential Model](financial-potential-model.md) §9, rounded to the
> nearest 25. The anchors below remain as a description of what each level means.

*Can and do they pay for partnerships at the level we ask for?* Defined
relative to **CBS Talks' standard partnership package** (the "standard ask"),
not in absolute DKK, so it stays valid when prices change.

| Score | Exact definition |
|---|---|
| **0** | No sponsorship history with student organisations, universities or events, **and** no identifiable budget owner (no employer-branding, marketing or CSR function in Denmark). |
| **50** | **Either** a plausible budget (a relevant function exists in Denmark) **or** a sponsorship history below the standard ask (in-kind only, or small cash amounts). There is no evidence they pay at our standard-ask level. |
| **100** | **Documented** cash sponsorship of comparable student organisations or events **at or above the standard ask** within the past 2 years, **and** an identified budget owner. |

**Anti-size rule:** company size or revenue alone can **never** justify a score
above 50. Going above 50 requires sponsorship history or a statement from the
company.

**Evidence:**
- Partner and sponsor pages of other CBS and Copenhagen student organisations and events
- Career fair packages they bought
- Annual reports, if they disclose sponsorship or community spend
- Conversations (budget statements are strong evidence)

**Generation: Assisted.** The system can pull in what we already know from our
own pipeline (past amounts paid to CBS Talks). External sponsorship history is
researched and entered by hand.

---

### D7 — Long-Term Partnership Potential (weight 10)

*Is there a reason for this to recur over several years and across several
partnership types?* CBS proximity and existing relationships are **not**
counted here; they belong in D9.

| Score | Exact definition |
|---|---|
| **0** | Only a one-off reason exists (a single launch or anniversary), **or** the company's Danish presence looks unstable (layoffs, leaving the market, financial distress). |
| **50** | One **recurring** need exists (e.g. annual graduate hiring) and the company is stable, but only **one** partnership type is plausible, and the relationship would rest on a single person. |
| **100** | Recurring needs across **two or more** partnership types (e.g. hiring + topic leadership), a stable Danish presence, a **track record of multi-year partnerships** with universities or organisations, **and** an organisational owner (a team, not one enthusiast). |

**Evidence:**
- Multi-year partnership history elsewhere
- Financial stability (Danish company register filings, news)
- How their employer-branding or community function is organised
- Whether their sub-scores B, D and E show two or more strong partnership types

**Generation: Assisted.** The stability check can be automated from register
data. The rest is a manual judgement, prompted by the company's B/D/E pattern.

---

### D8 — Brand Credibility (weight 5)

*Would being associated with them raise CBS Talks' credibility with
students, speakers, other partners and CBS?* Severe reputational problems are
handled by risk gates (§6.2), not here.

| Score | Exact definition |
|---|---|
| **0** | Being associated would add nothing or mildly hurt: unknown outside their niche **and** some negative press or a contested reputation (below the gate threshold). |
| **50** | Respectable and known in its industry; neutral-to-positive reputation. The name alone wouldn't attract other partners or speakers. |
| **100** | A widely respected name with a strong reputation (including ESG). Having them as a partner would visibly help us attract other partners and speakers. |

**Evidence:** reputation and ESG ratings where available, media sentiment over
the past 12 months, industry awards.

**Generation: Manual.** It has the lowest weight because it is the most
subjective and the most size-correlated dimension.

---

### D9 — Outreach Likelihood & CBS Proximity (weight 12)

*How likely is a successful approach, and how soon?*

| Score | Exact definition |
|---|---|
| **0** | No contact path, no CBS ties, never engages with universities or student organisations, no current trigger. **Or** they explicitly declined us in the past 12 months (hard cap: 20). |
| **50** | A **mix of moderate signals** reaching about 50 points on the scoring aid below. Example: a warm contact (25) plus CBS alumni in relevant roles (10) plus engagement with other student organisations (15). |
| **100** | An **active champion** inside the company, **plus** strong CBS ties (e.g. a past CBS Talks partnership that ended well), **plus** a history of student engagement, **plus** a current trigger (budget window, new employer-branding hire, expansion, launch). |

**Scoring aid** (the points add up to the suggested score, capped at 100; rounded to the nearest 25):

| Indicator | Points |
|---|---:|
| **Relationship:** active champion 40 · warm contact 25 · cold intro possible via a known person 10 · none 0 | 0–40 |
| **CBS proximity** (max 30): past CBS Talks partner that ended well 20 · partner of another CBS organisation or CBS research/teaching ties 10 · CBS alumni in employer-branding, talent or comms roles 10 | 0–30 |
| **Precedent:** engages with student organisations or universities | 0 / 15 |
| **Timing trigger** present (logged with date; expires after 6 months) | 0 / 15 |
| **Declined in the past 12 months** | cap at 20 |
| **Past CBS Talks partnership ended badly** | cap at 25 + risk flag review |

**Evidence:**
- The interaction log and Person records (relationship warmth)
- Pipeline history
- LinkedIn alumni lookups (entered by hand)
- Partner pages of other organisations
- News, for triggers

**Generation: Assisted, and the most automatic dimension.** Relationship
warmth, past partnership and the declined cap come straight from our own
records. Triggers and alumni counts are entered by hand.

---

## 6. Calculating the scores

### 6.1 Step 1: Base Priority (A before adjustments)

```
A_base = Σ (weight_i × score_i) / 100          for D1…D9
```

Each dimension's **contribution** is `weight_i × score_i / 100` points. These
contributions make up the bar chart on the company card. They always add up to
A_base exactly, so nothing is hidden.

### 6.2 Step 2: Adjustments (shown as separate lines)

Applied in this order:

| # | Adjustment | Rule | Why |
|---|---|---|---|
| 1 | **Gate** | Any gate risk flag → company is **excluded**; no scores are shown in rankings; it appears in the Excluded list with the reason | Gate types: ethics policy breach, CBS institutional rule, a contractual exclusivity conflict with an existing partner, or severe editorial-independence risk |
| 2 | **Mutual-value cap** | If **D3 ≤ 25** → A and Fit are capped at **55** | If they have little reason to say yes, high value to us is wishful thinking. This replaces the earlier geometric mean, because a cap is easier to explain to users |
| 3 | **Risk penalty** | Each penalty-level risk flag × 0.85, with a floor of × 0.70 | Reputational or independence concerns below the gate threshold. A risk can't be offset by other strengths |

```
A = min(A_base, cap) × risk_multiplier        → rounded to a whole number
```

### 6.3 Step 3: Fit, Outreach and Action Tier

**Fit** is the priority score *without* outreach. It answers "how good would
this partnership be?"

```
Fit = (A_base − 0.12 × D9) / 0.88        (same cap and risk adjustments as A)
```

**Action tier** (answers "which companies first?"):

| Tier | Rule | Action |
|---|---|---|
| **A — Approach now** | Fit ≥ 65 **and** G ≥ 50 | Assign an owner, approach within 4 weeks |
| **B — Build a path** | Fit ≥ 65 **and** G < 50 | Great fit, no way in yet. Look for an introduction (alumni, CBS staff, other partners) |
| **C — Opportunistic** | 50 ≤ Fit < 65 | Approach when capacity or a trigger appears |
| **D — Park** | Fit < 50 | Don't spend time; re-screen yearly |

**Fast-track rule (by partnership type):** if any of B, D, E or F is **≥ 80**
and G is **≥ 60**, the company is Tier A *for that type*, shown as e.g.
"A (Speaker)", even if its overall tier is lower. This stops an excellent
single-purpose partner (e.g. a great speaker with a warm contact) from being
buried under all-round companies.

**Calibration:** adjust the 65 and 50 thresholds so the number of Tier A
companies roughly matches the team's capacity (e.g. 8–12 active approaches per
semester).

### 6.4 Step 4: Recommended partnership type and offer

> **Replaced** by the Partnership Recommendation Engine
> ([`recommendation-engine.md`](recommendation-engine.md)). The rule below is
> kept only as a simplified fallback for the MVP spreadsheet.

| Rule (checked in order) | Recommendation |
|---|---|
| F ≥ 70 **and** at least two of B, D, E ≥ 60 | **Strategic / multi-year partner** (target) |
| Otherwise the highest of B, D, E | **Financial sponsor** (B) / **Speaker partner** (D) / **Recruitment partner** (E) |
| Ties within 5 points | Show both types |

**Entry offer:** if G < 50 **or** the target is Strategic, recommend starting
with the lowest-commitment offer for the highest of D or E (a speaker slot or
case workshop). Long-term partnerships usually grow from a successful first
event.

**Offer package:** the reasons behind the company's D3 rating (talent need,
brand gap, positioning, audience access) are matched to the offering catalog.
For example, a brand gap leads to a company-hosted talk plus a social content
series. The Partnerships Manager edits the suggestion.

### 6.5 Step 5: Unknowns, coverage, confidence

- An **UNKNOWN** dimension counts as **35** in all calculations (below the
  midpoint: not proven, not ruled out). It shows as "35?" in the breakdown.
- **Coverage** = the share of A's weight from rated (not unknown) dimensions.
- **Score range:** A recalculated with all unknowns at 0 and at 100, shown as
  "A = 61 (range 52–73)".
- **Provisional** flag if coverage < 70% **or** more than 40% of A's weight
  is Low confidence. A provisional company **can't be Tier A**. It goes to the
  research queue, ordered by how much its unknowns could change its tier.

### 6.6 Step 6: Sub-scores B–G

> **B (Financial Potential) is now the Financial Potential Score** from
> [`financial-potential-model.md`](financial-potential-model.md). The B column below
> is kept for reference only.

Each sub-score is a weighted combination of the same dimension scores, using
its own weights. They use the same unknown handling. The gate applies to all
of them; the risk multiplier and mutual-value cap apply only to A and Fit,
but risk flags are **displayed** on every view.

| Dimension | **A** Priority | **B** Financial | **C** Student | **D** Speaker | **E** Recruitment | **F** Long-term | **G** Outreach |
|---|---:|---:|---:|---:|---:|---:|---:|
| D1 Student Relevance | 15 | – | **45** | 10 | 20 | – | – |
| D2 Strategic & Topic Alignment | 13 | – | 10 | 20 | – | 15 | – |
| D3 Partner Need | 13 | 25 | – | – | 25 | 20 | 25 |
| D4 Speaker Potential | 13 | – | 20 | **70** | – | – | – |
| D5 Recruitment & EB | 9 | – | 25 | – | **55** | – | – |
| D6 Financial | 10 | **60** | – | – | – | – | – |
| D7 Long-Term | 10 | 15 | – | – | – | **55** | – |
| D8 Brand Credibility | 5 | – | – | – | – | – | – |
| D9 Outreach & Proximity | 12 | – | – | – | – | 10 | **75** |
| **Total** | 100 | 100 | 100 | 100 | 100 | 100 | 100 |

Why each sub-score is built this way:

- **B Financial** = ability to pay (D6), *plus* willingness, which comes from need (D3),
  *plus* chance of renewal (D7). Willingness matters as much as ability.
- **C Student Value** = interest (D1) + jobs (D5) + speakers (D4) + quality
  of content (D2). This is the "would students thank us?" score.
- **D Speaker** = the person (D4) on a relevant topic (D2) for an
  audience that cares (D1).
- **E Recruitment** = jobs for students (D5) + the company's talent need (D3) +
  student interest (D1). It is two-sided by design.
- **F Long-term** = recurring logic (D7) + lasting need (D3) + fit with our
  direction (D2) + an existing relationship as a foundation (D9).
- **G Outreach** = reachability (D9) + motivation to answer (D3). Companies
  that need us reply more often, even to cold emails.

**Important for users:** the sub-scores share dimensions, so they are
**correlated, not independent evidence**. A company with high D3 scores
well on B, E, F and G at once. The card makes this visible through each
sub-score's own breakdown.

---

## 7. Two-stage use

| Stage | Dimensions rated | Time | Result |
|---|---|---|---|
| **Quick screen** (all companies) | D1, D2, D3, D9 + gate check; the rest UNKNOWN | ~10 min | Provisional A. Companies with Fit ≥ 50 or G ≥ 75 move on to the full assessment |
| **Full assessment** (shortlist of ~25–30) | All nine, with evidence | 45–90 min | Final scores, tier, recommended type, offer |

The screen uses D1, D2, D3 and D9 because they carry the most weight (53 of
100 points) and are the fastest to judge. D4 to D7 need real research.

---

## 8. Worked example (fictional companies)

| Dimension (weight) | **Nordlys Logistics** — mid-size B2B, hires business graduates, unknown to students | **MegaBrand A/S** — top-ranked student employer | **Fjord Ventures** — VC-backed fintech, charismatic founder, warm contact |
|---|---:|---:|---:|
| D1 Student Relevance (15) | 75 | 100 | 75 |
| D2 Strategic & Topic (13) | 75 | 50 | 100 |
| D3 Partner Need (13) | 100 | **25** | 50 |
| D4 Speaker (13) | 50 | 75 | 100 |
| D5 Recruitment (9) | 75 | 100 | 25 |
| D6 Financial (10) | 50 | 100 | 25 |
| D7 Long-Term (10) | 75 | 50 | 50 |
| D8 Brand (5) | 50 | 100 | 50 |
| D9 Outreach (12) | 25 | 50 | 100 |
| **A_base** | **65.3** | **69.5** | **68.0** |
| Mutual-value cap | – | **D3 ≤ 25 → capped at 55** | – |
| **A — Partnership Priority** | **65** | **55** | **68** |
| Fit | 70.7 | 72.2 → capped 55 | 63.6 |
| B Financial | 66 | 74 | 35 |
| C Student Value | 70 | 90 | 70 |
| D Speaker | 58 | 73 | **98** |
| E Recruitment | **81** | 81 | 41 |
| F Long-term | **75** | 45 | 63 |
| G Outreach | 44 | 44 | **88** |
| **Tier** | **B — Build a path** | **C — Opportunistic** | **C overall, but A (Speaker) by fast-track** |
| **Recommended** | **Strategic partner** (F ≥ 70; B and E ≥ 60). Entry: case workshop, after getting an introduction | Recruitment partner, but low priority: they don't need us | **Speaker partner.** Approach now for a keynote |

What the example shows:

- **MegaBrand has the highest base score**, and a plain weighted sum would
  rank it first. The mutual-value cap shows why it shouldn't be first: it
  would give us a lot, but has little reason to say yes.
- **Nordlys** is the best long-term prospect. Its tier tells the team the
  next step is getting an introduction, not sending a cold pitch.
- **Fjord Ventures** isn't an all-round partner (low financial score), but
  its speaker score (98) and warm contact make it the right company to call
  this week, for a speaker slot.

A card for Nordlys would open like this:

> **Nordlys Logistics: Priority 65 · Tier B (Build a path) · Strategic partner**
> Financial 66 · Student 70 · Speaker 58 · Recruitment 81 · Long-term 75 · Outreach 44
> **Biggest contributors to Priority:** Partner Need +13.0 (hires ~20 business graduates/yr, absent from student rankings *[Jobindex Aug 2026; ranking report 2026]*) · Student Relevance +11.3 · Strategic Alignment +9.8
> **Holding it back:** Outreach 25 (no contact; nearest path: alumnus known to a board member) · Speaker 50 (COO identified, no talk recordings found)
> **Adjustments:** none · **Coverage** 100% · **Low-confidence:** D4, D7
> **Next step:** introduction via the alumnus → propose a supply-chain case workshop in spring

---

## 9. Governance and calibration

- **Who rates:** any board member, against the anchors. Ratings of 75 or 100
  need evidence. Value dimensions (D1–D2, D4–D8) and Partner Need (D3) should
  be rated by different people where possible, to limit halo effects.
- **Overrides:** made by the Partnerships Manager at the dimension level, with a
  reason category, free-text reason and expiry date. The card shows the
  computed value next to the override.
- **Re-rating cadence:**
  - D9 at every interaction (automatic from the log)
  - D5 and D6 every 6 months
  - D1 after each pulse survey
  - Everything else yearly or when news arrives
- **Back-test before first use:** score 5–10 past partners and 5 companies
  that declined. Past good partners should land in Tier A or B, and decliners
  should mostly be held back by D3 or D9. If not, fix the anchors or weights first.
- **Semester review:**
  1. Compare tiers with outcomes (response, meeting, deal, renewal).
  2. Check size bias: if more than 60% of Tier A is 1000+ employee companies, review D6/D8 ratings and weights.
  3. Review all overrides.
  4. Sensitivity check: does Tier A change if any single weight moves ±3?
- **Weight changes:** saved as a new version with a change note. Old score
  snapshots keep their version, so you can always see why a score changed.

---

## 10. Remaining weaknesses (be aware of them)

1. **A single headline score always loses information.** The sub-scores and
   tiers limit this, but people will still sort by A and stop reading. The
   design rule "A is never shown alone" has to be enforced in the views.
2. **The 0/50/100 anchors still need judgement for D2, D4 and D8.** Expect
   disagreement between raters at first. Measure it in the MVP (two raters
   on 10 companies) and sharpen any anchor where they differ by more than one step.
3. **The mutual-value cap is a blunt rule.** It's chosen for being easy to
   explain. If it caps companies that later say yes, lower the trigger to
   D3 = 0 or replace it with a softer penalty.
4. **D6 depends on the "standard ask"**, which CBS Talks must define first.
5. **Hiring-related evidence feeds D3, D5 and partly D1 and D7.** That is
   intended for a business school, but in a hiring freeze many scores drop at
   once. Re-rate D3 and D5 when the job market shifts.
6. **The weights reflect my assumptions about CBS Talks**: a student-run talks
   organisation where the audience is the main asset and money is necessary
   but not the mission. If revenue is the binding constraint this year, raise
   D6 and lower D2 explicitly, as a new weight version, rather than through
   overrides.
