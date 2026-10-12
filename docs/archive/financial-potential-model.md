# CBS Talks — Financial Potential Model

**v1.0 (2026-10-05).** Builds on [`scoring-framework.md`](scoring-framework.md),
[`recommendation-engine.md`](recommendation-engine.md) and
[`explainability-layer.md`](explainability-layer.md).

The model produces three outputs for each company:

1. **Financial Potential Score (FPS):** 0–100
2. **Estimated sponsorship tier:** <5k · 5–10k · 10–20k · 20–50k · 50k+ DKK
3. **Confidence:** High / Medium / Low / Not estimated

> **Every financial output is an estimate, not a known fact.** Unless the
> company has told us its budget or has paid us before, nobody at CBS Talks
> knows what a company will pay. The model estimates a *realistic first-year
> cash ask*. It does not claim to know the company's budget. §6 sets out how
> this must be displayed.

---

## 0. Design decisions and critique

1. **Revenue and market cap aren't used at all, not even as a minor
   input.** You asked that revenue never be the *only* basis. I recommend going
   further. Revenue says almost nothing about whether a Danish office can
   approve a 20,000 DKK student sponsorship. A global group with a DK sales
   office of 30 people has huge revenue and no local budget. Company size enters
   only through **Danish headcount**, at a low weight. Revenue may be stored for
   reference but is excluded from every formula, and the system refuses
   ratings whose only evidence is revenue (§3.3).
2. **"Can pay" is not "will pay".** Capacity factors (size, marketing intensity)
   can't raise the score on their own. Without any sponsorship or partnership
   behaviour, the score is **capped at 50** (the propensity gate, §3.2). This
   extends the anti-size rule that D6 already had.
3. **"Likely willingness to invest" can't be an input.** Willingness is what the
   model is trying to estimate. Rating it directly would mean entering the
   answer as a question. I replaced it with **Direct willingness signals**:
   observable statements and actions (a stated budget, an open application
   form, an invitation to send a proposal, or an explicit "no").
4. **The score and the DKK tier are separate on purpose.** The score measures
   *potential* and is good for ranking. The tier estimates *amount* and needs
   stronger evidence. A high score with no evidence of amounts still gives only
   a cautious tier (§4.3). Showing them separately keeps a solid ranking from
   lending false precision to a money estimate.
5. **Several of your factors already exist in the framework.** Recruitment
   intensity (D5), strategic relevance of CBS students and employer-branding
   value (D3 need flags) are **reused, not re-rated**. This keeps data entry
   down and stops double counting in the Priority Score (§5).
6. **Sponsorship maturity is a two-edged factor.** A mature sponsor has a real
   budget and a process, but also demands measurable ROI and runs competitive
   selection. The model scores maturity as positive for *potential*, and the
   card flags "expect ROI requirements" when it's high.

---

## 1. Structure

```
                        Financial Potential Score (0–100)
   ┌───────────────────┬──────────────────────┬───────────────────┬──────────────┐
   │ CAPACITY  (20)    │ PROPENSITY  (40)     │ MOTIVATION  (25)  │ SIGNALS (15) │
   │ can they pay?     │ do they pay for      │ would they pay    │ have they    │
   │                   │ things like this?    │ *us*?             │ told us?     │
   │ F1 DK size     6  │ F4 Student spons. 15 │ F7 Recruitment  8 │ F10 Direct   │
   │ F2 Mktg/EB     8  │ F5 University     10 │ F8 CBS relev.   9 │ willingness  │
   │ F3 DK presence 6  │ F6 Maturity       15 │ F9 EB value     8 │ signals  15  │
   └───────────────────┴──────────────────────┴───────────────────┴──────────────┘
          ↓ gate: if Propensity < 25 and F10 < 75 → FPS capped at 50
```

**Why these weights.**
- **Propensity is the largest block (40).** Past behaviour is the best
  predictor of future spending: companies that sponsor student organisations
  keep doing it.
- **Capacity is deliberately small (20)** and can't act alone, because of the gate.
- **Motivation (25)** asks whether CBS students in particular are worth paying for.
- **Direct signals (15)** are the strongest evidence when they exist. They aren't weighted
  higher because most companies have no signal yet, and an UNKNOWN shouldn't
  dominate the score.

---

## 2. The ten factors

Same rules as the main framework:
- **Scale:** 0 / 25 / 50 / 75 / 100, or UNKNOWN (counted as 35 in the calculation).
- **Evidence:** ratings of 75 or more need [V] evidence.
- **Not found vs. not searched:** "Searched, none found" is a **0 with
  evidence** (record what was searched, and when). "Not searched" is
  UNKNOWN. This distinction matters most for F4 and F5.

### Capacity

#### F1 — Company size in Denmark (weight 6)

| Score | Definition |
|---|---|
| 0 | < 10 employees in Denmark |
| 25 | 10–49 |
| **50** | **50–249** |
| 75 | 250–999 |
| **100** | **1,000+ employees in Denmark** |

**Evidence:** employee counts in the Danish company register (CVR) or annual
reports. **Danish headcount only.** Global headcount and revenue are not
used.
**Mode:** **Auto** (from the company register), with a person confirming the DK entity is the right one.

#### F2 — Marketing / employer-branding intensity (weight 8)

| Score | Definition |
|---|---|
| **0** | No marketing or employer-branding function in Denmark; no campaigns; a basic or missing careers page |
| **50** | A marketing or HR function in Denmark that does some employer branding (a maintained careers site, occasional campaigns or career-fair stands), but no dedicated employer-branding role |
| **100** | A **dedicated employer-branding or talent-attraction role or team in Denmark**, recurring campaigns aimed at students or graduates, and active campus presence |

**Evidence:** job titles on LinkedIn (employer branding, talent attraction,
campus recruitment), careers site, campaigns, career-fair exhibitor lists.
**Mode:** **Assisted.** The system can list job titles found; a person rates.

#### F3 — Presence and budget authority in Denmark (weight 6)

| Score | Definition |
|---|---|
| **0** | No Danish entity, or a sales presence only, managed from abroad |
| **50** | A Danish entity with local management, but marketing and HR budgets are **likely decided abroad** (regional HQ elsewhere) |
| **100** | Danish HQ, or a Danish entity with **local budget authority** for marketing / HR / employer branding |

**Evidence:** CVR structure, the group's organisation, where the
employer-branding or HR lead sits (LinkedIn location), and conversations.
**Mode:** **Manual.** This factor exists because *who can say yes* matters
more than how big the group is.

### Propensity

#### F4 — Existing student sponsorship activity (weight 15)

| Score | Definition |
|---|---|
| **0** | **Searched, none found:** no sponsorship of student organisations or student events in the past 2 years |
| **50** | Sponsors **one** student organisation or event, or several at a small/basic level, in the past 2 years |
| **100** | Sponsors **two or more** student organisations or events, **or** is a **main/headline partner** of at least one, in the past 2 years (CBS or other Copenhagen/Danish universities) |

**Evidence:** partner pages of CBS and Copenhagen student organisations, event
pages, LinkedIn posts by the organisations. Record the partnership *level* if
it is visible (main partner / partner / supporter). This feeds the tier (§4).
**Mode:** **Manual,** with a shared, maintained list of student organisations'
partner pages to check (one hour of setup that saves time on every company).

#### F5 — Existing university partnerships (weight 10)

| Score | Definition |
|---|---|
| **0** | Searched, none found |
| **50** | Light engagement: career-fair participation, guest lectures, case collaborations, thesis cooperation |
| **100** | A **formal, paid** university partnership: a corporate partner programme, a sponsored chair or programme, a research partnership with funding, or a premium career-centre package |

**Evidence:** university corporate-partner lists, career-fair exhibitor lists,
press releases, annual reports.
**Mode:** **Manual.**

#### F6 — Sponsorship maturity (weight 15)

| Score | Definition |
|---|---|
| **0** | No sponsorship practice: no visible sponsorships of any kind; requests would be decided ad hoc by an individual |
| **50** | Sponsors things (sports, culture, community or industry events) but has **no formal process** and no student focus |
| **100** | A **formal sponsorship or partnership programme**: a named budget owner, a published policy or application route, multi-year deals, and evidence that they evaluate results |

**Evidence:** sponsorship policy pages, application forms, the community or
sponsorship section of the annual report, conversations.
**Mode:** **Manual.** When 75 or more, the card adds: *"Mature sponsor: expect ROI
requirements and competitive selection. Prepare audience data."*

### Motivation (reused, not re-rated)

#### F7 — Recruitment intensity (weight 8)
= **D5** (Recruitment & Employer-Branding Potential) from the scoring framework.
Same anchors and evidence. **Mode:** reused automatically.

#### F8 — Strategic relevance of CBS students (weight 9)
= max(`talent`, `audience`) need flag, converted 0 / 1 / 2 → 0 / 50 / 100.
*Do they need CBS students as hires or as an audience?* **Mode:** reused automatically.

#### F9 — Potential value of employer branding (weight 8)
= `brand_gap` need flag → 0 / 50 / 100.
*How much would visibility among CBS students be worth to them?* A
company that is already a top student brand gains little from more of it.
**Mode:** reused automatically.

### Signals

#### F10 — Direct willingness signals (weight 15)

| Score | Definition |
|---|---|
| **0** | **Negative signal:** they told us (or a logged interaction shows) "no sponsorship budget", or declined us in the past 12 months |
| 25 | Weak negative: a public policy restricting sponsorships, or a recent hiring freeze or cost-cutting announced in Denmark |
| **50** | **Indirect positive signal:** a public student-engagement commitment, an open sponsorship application route, or "we support student initiatives" on their site |
| 75 | Positive conversation: interest expressed in partnering, without a budget mentioned |
| **100** | **Direct signal:** a stated budget or price range, an invitation to send a proposal, or **a past payment to CBS Talks** |

**No signal at all = UNKNOWN,** not 50. **Mode:** **Assisted.** It is set from
the interaction log and pipeline automatically (declined, past payment) and from
manual entries (public policies, conversations).

---

## 3. Calculating the Financial Potential Score

### 3.1 Base score

```
FPS_raw = Σ (weight_i × factor_i) / 100            (UNKNOWN factors counted as 35)

Capacity   = (6·F1 + 8·F2 + 6·F3) / 20
Propensity = (15·F4 + 10·F5 + 15·F6) / 40
```

### 3.2 Propensity gate

```
If Propensity < 25 AND F10 < 75:   FPS = min(FPS_raw, 50)
```

Shown on the card as: *"Capped at 50: no evidence they sponsor student or
university activities, and no direct signal. Capacity alone doesn't show
willingness to pay."*

### 3.3 Revenue exclusion (enforced, not just a guideline)

- Revenue and market cap are **not fields used by any formula.**
- A rating rationale for F1–F10 that cites only revenue, market cap or
  global size is **rejected by validation**. The rater must cite Danish,
  behavioural evidence.
- The card **never shows revenue next to the financial estimate**, so
  readers aren't anchored by it.

### 3.4 Unknowns, coverage

- **Coverage** = the share of FPS weight from rated factors.
- If coverage is below 60%, the score is shown as **"provisional"** and the tier is **not
  estimated** (§4.4).

---

## 4. Estimating the sponsorship tier

The tier is the estimated **realistic first-year cash ask**. It is *not* their
total budget, it doesn't include in-kind value, and it's *not* multi-year
value (that is sub-score F).

### 4.1 Evidence ladder: the strongest available evidence decides

| Level | Evidence | How the tier is set | Max confidence |
|---|---|---|---|
| **A. Direct** | They paid CBS Talks before, or stated a budget or range [V] | The band of the paid or stated amount. The model only notes upside or downside | High |
| **B. Comparable** | **Known amounts** for comparable sponsorships (e.g. a published package price they bought, or an amount disclosed by another organisation) [V] | The band of the comparable amount, one band lower if the comparable was a larger event | High |
| **C. Pattern** | Sponsorship or partnership **exists** but amounts are unknown (F4 or F5 ≥ 50 with [V]) | The band from the score (§4.2), within the ceilings in §4.3 | Medium |
| **D. Model only** | No sponsorship or partnership evidence (F4 and F5 both 0 or UNKNOWN) | The band from the score, within the stricter model-only ceiling | Low |

### 4.2 Mapping the score to a band (used for levels C and D)

| FPS | Band |
|---|---|
| 0–29 | **< 5,000 DKK** |
| 30–49 | **5,000–10,000 DKK** |
| 50–64 | **10,000–20,000 DKK** |
| 65–84 | **20,000–50,000 DKK** |
| 85–100 | **50,000+ DKK** |

These cut-offs are starting assumptions. Calibrate them against CBS Talks'
actual deals (§7).

### 4.3 Ceilings (the estimate can only go down, never up)

| Rule | Ceiling | Why |
|---|---|---|
| **Model only** (level D) | **5,000–10,000 DKK** | With no history of paying for student or university activities, the first deal needs a new budget decision. Small asks are realistic |
| **50,000+** | Requires level **A or B** evidence at that level | Never estimated from a model or a pattern |
| **20,000–50,000** | Requires at least level **C** with F4 = 100 (main partner, or two or more organisations) **or** F5 = 100 | A larger ask needs proof of larger spending behaviour |
| F3 ≤ 50 (budget likely decided abroad) | **10,000–20,000 DKK** unless level A/B | Local teams can usually approve smaller amounts only |
| F1 ≤ 25 (< 50 DK employees) | **5,000–10,000 DKK** unless level A/B | Small companies rarely have sponsorship budgets beyond this |
| F10 = 0 (declined / "no budget", past 12 months) | **< 5,000 DKK** for 12 months | Respect the "no". Don't plan revenue on it |

### 4.4 Output

| Field | Content |
|---|---|
| **Estimated tier** | Most likely band, **always labelled "estimate"** |
| **Plausible range** | High confidence: the band itself. Medium or Low: one band below to one band above the estimated band. The range may extend one band past a ceiling, because ceilings are caution rules, not certainties |
| **Basis** | Evidence level (A–D) + the 2–3 facts it rests on, tagged [V]/[I]/[?] |
| **Ceiling applied** | Which rule limited the estimate, if any |
| **Upside note** | When the model band is above the evidence band: "Model suggests room to grow; don't ask for more until after a successful first event" |
| **Not estimated** | If coverage < 60%: "Not estimated. Research F4, F6 and F10 first." No band is shown |

---

## 5. Confidence

| Level | Rule |
|---|---|
| **High** | Level A or B evidence **and** that evidence is ≤ 24 months old **and** FPS coverage ≥ 80% |
| **Medium** | Level C **and** coverage ≥ 70%; **or** level A/B with older evidence or lower coverage |
| **Low** | Level D; **or** the model band and evidence band differ by more than one band; **or** coverage 60–69% |
| **Not estimated** | Coverage < 60%. No tier is shown |

Expect **most companies to be Medium or Low**. Danish student organisations
rarely publish sponsorship amounts. That is the honest state of the
information, not a flaw to hide. Confidence rises as CBS Talks logs its own
deals (level A).

---

## 6. Display rules: "estimate, not fact"

These are mandatory wherever a financial output appears (card, ranking table,
exports, spreadsheet):

1. **Always label it.** Column header: *"Est. sponsorship tier"*. On the card:
   *"Estimated realistic first-year ask (estimate, not a known budget)"*.
2. **Never show a single DKK number.** Always a band, plus the plausible range.
3. **Always show the basis and the confidence** next to the band.
4. **Wording:**
   - "We estimate a realistic ask of…", never "their budget is…".
   - "No evidence of student sponsorship found", never "they don't sponsor".
5. **Internal only.** The estimate never appears in external communication or
   in the outreach opening angle. Pricing toward the company comes from
   CBS Talks' **package list**, not from the estimate.
6. **No revenue next to the estimate** (§3.3).
7. **Exports carry a footer:** *"Financial tiers are model estimates based on
   public behaviour and logged interactions. They are not confirmed budgets."*

Example card block:

```
FINANCIAL POTENTIAL                                   (estimate, not a known budget)
Score 50/100 (capped: no student/university sponsorship found)
Estimated realistic first-year ask: 5,000–10,000 DKK
Plausible range: < 5,000 – 10,000–20,000 DKK · Confidence: Low (model only)
Basis: dedicated EB need [I — IR1]; searched 14 student-org partner pages, none found
       [V, 2026-09-20]; no conversation yet [?]
Ceiling applied: model-only → max 5,000–10,000 DKK
```

---

## 7. Calibration

- **Reference class:** after each closed deal, record the actual amount and the
  estimate made beforehand. After about 10 deals, check:
  - **Hit rate:** was the actual amount within the plausible range? Target ≥ 80%.
  - **Bias:** are estimates systematically high or low? If so, shift the
    band cut-offs in §4.2.
- **Align packages to bands.** Ideally CBS Talks' sponsorship packages match
  the bands (e.g. Supporter < 10k, Partner 10–20k, Main partner 20–50k, Strategic
  50k+). Then the estimate maps directly to a package to propose.
- **Self-fulfilling estimates.** If a company is estimated at 5–10k and we
  only ever ask for 5k, we'll never learn they would have paid 20k. Once per
  semester, deliberately propose one package above the estimate (to a Medium
  or High confidence company) and log the result.

---

## 8. Worked examples (fictional companies)

I checked these numbers with a script that applies the rules above. The derived D6
values match the D6 ratings used in the earlier documents.

| Factor (weight) | Nordlys Logistics | MegaBrand A/S | Fjord Ventures | ProServ (hypothetical) | Kobber Hotels | **Titan Industrial** |
|---|---:|---:|---:|---:|---:|---:|
| F1 DK size (6) | 75 | 100 | 25 | 100 | 75 | 100 |
| F2 Mktg/EB (8) | 50 | 100 | 25 | 100 | 50 | 50 |
| F3 DK presence (6) | 100 | 100 | 100 | 100 | 100 | 50 |
| F4 Student spons. (15) | 0 (searched) | 100 | 0 | 100 | 0 | 0 |
| F5 University (10) | 50 | 100 | 0 | 100 | 0 | 0 |
| F6 Maturity (15) | 25 | 100 | 0 | 100 | 50 | 0 |
| F7 Recruitment (8) | 75 | 100 | 25 | 100 | 50 | 50 |
| F8 CBS relevance (9) | 100 | 50 | 50 | 100 | 50 | 50 |
| F9 EB value (8) | 100 | 0 | 50 | 0 | 50 | 50 |
| F10 Signals (15) | ? | 50 | ? | 100 (paid us 40k) | 50 | ? |
| **FPS raw** | 51.5 | 80.0 | 25.2 | 92.0 | 42.0 | 30.8 |
| Propensity gate | **capped → 50** | – | (cap not binding) | – | (cap not binding) | (cap not binding) |
| **FPS** | **50** | **80** | **25** | **92** | **42** | **31** |
| Evidence level | D (model only) | C (main-partner logos, no amounts) | D | **A (paid us 40k)** | D | D |
| Score band | 10–20k | 20–50k | < 5k | 50k+ | 5–10k | 5–10k |
| Ceiling | model-only → 5–10k | – | F1 ≤ 25 (not binding) | evidence decides | model-only (not binding) | model-only; F3 ≤ 50 |
| **Est. tier** | **5–10k** | **20–50k** | **< 5k** | **20–50k** | **5–10k** | **5–10k** |
| Confidence | Low | Medium | Low | High | Low | Low |

Notes:
- **Nordlys:** high motivation (it needs us) but no habit of paying. The
  estimate stays small, and the card says to start with a small package or a
  recruitment-event fee. The recommendation engine already leads with Recruitment.
- **MegaBrand:** clearly pays for student engagement (pattern evidence), so
  20–50k. But F9 = 0 shows it gains little from us. Financially capable, but not
  motivated, which matches its "Opportunistic" verdict.
- **ProServ:** the model says 50k+, but **evidence beats the model**. It paid
  40k, so the estimate stays at 20–50k, with an upside note: "50k+ is plausible
  if the scope grows to an annual strategic partnership."
- **Kobber Hotels:** small cash potential. Its value is in-kind (venue), which
  the cash tier deliberately doesn't include.
- **Titan Industrial** (new, fictional): a global group with large revenue, 1,000+
  employees in Denmark, budgets decided abroad, and no student activity. **If revenue were
  used as a proxy, it would look like a 50k+ prospect. This model estimates
  5–10k with Low confidence.** That is the gap between "a big company" and
  "a company that will pay us". The next research step is F10: ask whether the
  Danish HR team has any budget for student activities.

---

## 9. Changes to the other documents

| Document | Change |
|---|---|
| **Scoring framework** | **D6 (Financial Sponsorship Potential) is now derived**, not rated: D6 = the Capacity + Propensity index `(20·Capacity + 40·Propensity) / 60`, with the same gate (max 50), rounded to the nearest 25. Motivation and signals are *excluded* from D6 because they are already in D1, D3, D5 and D9. Including them would double-count in the Priority Score. |
| **Scoring framework** | **Sub-score B (Financial Potential) = FPS.** B's old formula is replaced. |
| **Recommendation engine** | Financial suitability formulas use FPS in place of B. Annual-strategic readiness "D6 ≥ 75 with verified history" becomes **"estimated tier ≥ 20–50k with evidence level A or B"**. |
| **Explainability card** | Field 7 ("What they could contribute"), money line = the §6 financial block (tier, range, confidence, basis, estimate label). |
| **Data model** | Add `FinancialFactor` ratings F1–F6 and F10 (F7–F9 are references); a `SponsorshipObservation` entity (company, organisation sponsored, level, amount if known, date, source) that feeds F4/F5 and the evidence level; `FinancialEstimate` snapshot (FPS, band, range, level, confidence, ceilings applied); `Deal.actual_amount` for calibration. |

---

## 10. Weaknesses

1. **Size still enters indirectly.** Large companies are more likely to have
   formal sponsorship programmes (F6) and university partnerships (F5). That is
   acceptable because these are *behaviours*, not size itself. Still, check the
   size-bias report (framework §9).
2. **"Searched, none found" is only as good as the search.** A missed partner
   page makes a sponsor look like a non-sponsor. The shared list of student
   organisations' partner pages reduces this.
3. **Bands are wide, and that's intentional.** 20–50k spans a factor of 2.5.
   Narrower bands would suggest a precision the evidence doesn't support.
4. **Amounts are rarely public in Denmark.** Until CBS Talks has its own
   deal history, most estimates will be level C or D (Medium/Low). Don't
   build a budget forecast on Low-confidence estimates. Use them only to rank.
5. **Sponsorship of non-student things (F6) transfers only partly.** A football
   club sponsor may never fund a student talk. That is why F6 alone can't
   lift the score past the gate.
6. **Estimates anchor negotiators.** Even labelled "estimate", a band shapes
   what people ask for. The calibration rule (§7, ask above the estimate
   once per semester) is there to counter this.
