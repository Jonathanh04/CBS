# Audit of the CBS Talks Partnership System

**2026-10-05.** A critical review of the eight design documents in `docs/`
and the dashboard prototype. It is written from the point of view of a B2B
partnerships director who has to make this work with a volunteer student board.

---

## Verdict: not ready to code

The **CRM part** is close to ready, after simplification. The **scoring,
financial and recommendation layers are not.** They are too complex for
the team that will use them, they double-count the same few facts, they
still favour large companies, and they give relationships far too little
weight. Their numbers look precise but rest on assumptions nobody has tested,
including mine.

Each layer was reasonable on its own when it was added. Together they make a
system that a volunteer board will stop maintaining within a semester.

**Recommendation:** cut the system down to a lean version (§4), run it in a
spreadsheet for one semester with real CBS Talks data, and only then code
the parts that proved useful.

---

## 1. The ten most serious problems (ranked)

| # | Problem | Why it matters |
|---|---|---|
| 1 | **Far too many inputs per company.** About 29 rated inputs (7 dimensions, 4 need flags, 4 capability flags, 7 financial factors, 7 outreach factors), each with evidence and a confidence rating: roughly 60 data points per company. At 60–90 minutes per full assessment for 30 companies, that's 30–45 volunteer hours a semester before anyone sends an email | The design fails its own MVP test ("is the sheet still being updated in week 8?"). Research turns into procrastination: it *feels* productive and replaces contacting companies |
| 2 | **Relationships are almost invisible in the main score.** Relationship (O1) is 20% of the Outreach score, and Outreach is 12% of the Priority Score: about **2.4%** of the headline number. For a student organisation, a warm contact or a past partner is usually the strongest predictor of a deal | The system ranks a perfect-fit stranger above a good-fit company with a champion inside. In practice, the champion wins. I over-corrected for network bias |
| 3 | **The "they don't need us" logic suppresses companies that actually pay.** The mutual-value cap punishes established student brands (D3 ≤ 25). But companies that already sponsor student organisations are showing, by their behaviour, that they pay for exactly this. In the examples, MegaBrand (main partner of two CBS organisations) is capped at 55, while Nordlys (has never sponsored anyone) ranks higher | For **money**, observed behaviour beats an inferred need. The "employer-brand gap" theory is elegant but unproven, and I built a hard cap on it |
| 4 | **One fact is counted many times.** A job-postings count feeds D5, the talent need flag, F7, F8, O6, O9, D7 and sub-score E. "Sponsors student organisations" feeds F4, D6, O5, the evidence ladder, IR2 and recurring-sponsor eligibility. Employer-branding activity feeds F2, O7, the brand-gap flag and F9 | Companies that are good at one visible thing (hiring, or sponsoring) get rewarded for it 5–8 times. The model effectively has 3–4 real inputs disguised as 40 |
| 5 | **The size bias wasn't removed, just moved.** Dedicated employer-branding teams (F2), formal sponsorship programmes (F6), university partnerships (F5), campus presence (O4, O6), student rankings (D1), brand (D8) and famous executives (D4) are all much more common at large companies. Against that, there is **one** counterweight (D3/brand gap) | Large companies will still fill the top of the list. The worked examples suggested otherwise only because **I chose their ratings to illustrate the rules**. They prove nothing |
| 6 | **The financial estimate is false precision.** A 10-factor score and band cut-offs (30/50/65/85), plus six ceilings, produce a DKK band. But in practice the band is decided by two questions: *have they paid us?* and *do they sponsor other student organisations?* Everything else rarely changes the outcome, because the ceilings override it. The DKK bands and cut-offs were invented by me, with no market data | It looks like analysis and isn't. Worse, an estimate anchors what people ask for |
| 7 | **Too many labels for the same idea.** One company can be "A = 83.5, Fit 89, Tier B, Q2, Build a path, Recommendation: Recruitment partner, Target: Annual, Est. 20–50k, OLS 44, Achievable OLS 75, Confidence Medium" | Nobody can act on twelve signals. Users will look at one number and ignore the rest, which undoes the transparency the system was built for |
| 8 | **About 150–200 numbers set by judgement, none calibrated.** Weights, sub-score mixes, cut-offs, caps, suitability coefficients, probability modifiers, objective adjustments, inference thresholds | With 20–40 deals a year, these can **never** be calibrated statistically. The "back-test" on 10 past partners can't validate 9 weights, let alone 200 parameters |
| 9 | **The system analyses companies in depth and CBS Talks hardly at all.** There's no audience data, media kit, package list, case studies or renewal history yet. Yet the briefings, objection responses and offers all depend on them | Companies decide based on *our* offer. A strong one-page media kit with real audience numbers will do more for results than any scoring refinement |
| 10 | **Generated briefings sound more certain than they are.** "Likely objective" and "likely objection" are guesses dressed up as a briefing. The format makes inferences read like intelligence | Board members will repeat inferences to companies as facts, which is the hallucination risk in human form |

---

## 2. Findings by category

### 2.1 Bad scoring assumptions
- **"Need" predicts payment better than "behaviour".** Wrong for money (see #3). Need matters for *which offer* fits, and behaviour matters for *whether they pay*.
- **Ordinal ratings treated as precise numbers.** Five-step ratings are averaged with decimal weights into "65.25". The decimals mean nothing.
- **Unknown = 35 everywhere.** Under-researched companies all bunch together just below the middle, and their rank depends on *how much* is unknown rather than on what is known.
- **Many override rules interacting.** Gates, the mutual-value cap, risk multipliers, the propensity gate, the OLS caps, tier ceilings, financial ceilings, eligibility conditions and fast-track all interact. Nobody, including me, can predict the result without running the calculation. That is the opposite of "transparent".
- **Stage probabilities come from general B2B sales habits,** not from student-organisation reality.
- **The "no cash first" rule** is sensible as advice, but encoding it as a hard readiness rule ignores companies that have open sponsorship application routes.

### 2.2 Double counting
See #4. On top of that:
- **The Priority Score A already includes outreach (D9),** while the matrix plots Fit against outreach and the tiers use both. The same information is shown three ways.
- **The sub-scores B–G reuse the same dimensions,** so they are correlated by construction. Six bars give the *appearance* of six independent views.

### 2.3 Too subjective
- D2 Strategic alignment, D8 Brand credibility, D7 Long-term potential, D4 Speaker quality (without recordings) and the need and capability flags are judgement calls dressed up in anchors.
- **"Confidence" is itself a subjective rating** stacked on another subjective rating.
- Thirty subjective inputs, each with a ±1-step disagreement between raters, add up to rankings that change depending on **who** did the research.

### 2.4 Data that will be hard to get
| Data | Reality |
|---|---|
| Sponsorship amounts | Almost never public, so the financial evidence ladder sits at "model only" for most companies |
| Budget authority (F3) | Not observable from outside |
| Sponsorship maturity (F6) | Rarely visible |
| Student employer-ranking positions | Partly behind paid reports |
| Need flags, capability flags | Largely guesswork until a conversation happens |
| CBS Talks' own audience data | **Probably doesn't exist in usable form yet.** It's the most important missing input, and I'm assuming its absence until you can check |
| CBS rules for student-organisation sponsorships | Still unverified; could invalidate parts of the approach |
| Danish rules on unsolicited electronic marketing | Still unverified |

Easy to get: company register headcount, job postings, partner pages of student
organisations, LinkedIn titles and alumni, our own interaction history.

### 2.5 Hallucination risks
- **My own design numbers:** DKK bands, cut-offs, inference rule thresholds (e.g. "≥ 6 postings and not top-100") and stage probabilities. They read like findings but are assumptions.
- **Statements in the documents that I haven't verified,** for example that Danish student organisations rarely publish sponsorship amounts. These are plausible, but must be treated as assumptions.
- **AI writer/enrichment:** well constrained on paper. In practice, the bigger risk is people pasting AI output into "evidence".
- **Briefings:** inferred objectives and objections presented as a briefing (#10).

### 2.6 Incentives that point the wrong way
| Incentive | What it causes |
|---|---|
| "Build a path" quadrant + prestige | Q2 fills with famous companies (high Fit, low access). Students *want* to chase big names, and the matrix legitimises spending 30% of capacity on them |
| Weighted pipeline and target coverage | Inflating proposed values and moving deals to later stages early to make the numbers look healthy |
| −10 for asking above the estimate | Systematically low asks, a self-fulfilling low estimate |
| Win rate as a headline figure | Avoiding ambitious asks to protect the rate |
| Briefing threshold at A > 75 | Nudging ratings to push favourite companies over 75 |
| Overrides | Easy way for the most persistent board member to get their pet company prioritised |
| Research rewarded by the system | Time spent completing ratings rather than talking to companies |

### 2.7 Overweighting size and bias toward large corporations
See #5. The single largest structural bias. It isn't solved by adding more
counterweights. It is solved by **using fewer inputs, each of which isn't size-driven**.

### 2.8 Underweighting relationship quality
See #2. Also:
- **Relationship is measured by the *number* of interactions,** not their quality: how senior and committed the champion is, how satisfied a past partner was, whether they delivered what they promised.
- **Past and current partners are treated as one special rule** in the recommendation engine. They should be the **first** pipeline, not an exception. Renewing a satisfied partner is the cheapest money a student organisation can raise.

### 2.9 False precision in the financial estimates
See #6. Also:
- **Dashboard figures like "Target coverage 0.54"** with two decimals, built on uncalibrated probabilities.
- **"Expected value" per deal** multiplies an estimated value by an estimated probability. Two guesses multiplied together don't produce information.

### 2.10 Complexity that won't help the Partnerships Manager
| Feature | Keep? |
|---|---|
| Seven sub-scores A–G + Fit + FPS + OLS + Achievable OLS | ❌ Replace with two scores (§4) |
| Recommendation engine (8 suitability formulas, eligibility conditions, near misses, tie-break order, objective adjustments) | ❌ A partnerships manager decides a company's partnership type in two minutes. Replace with a one-page guide |
| Financial Potential Model (10 factors, gate, 6 ceilings, evidence ladder) | ❌ Replace with "which package to offer" from three questions |
| Inference library with rule IDs; AI writer JSON contract and validator | ❌ Premature without even a spreadsheet |
| Score ranges, half-lives, staleness decay, provisional rules | ❌ "Last checked" date is enough |
| Axis correlation report, portfolio checks, sector-concentration warnings | ❌ Nobody will run them; a once-a-semester discussion covers it |
| Matrix lenses, fast-track, narrow-opportunity rules | ❌ The manager can see a great speaker without a rule |
| Probability modifiers, target coverage | ❌ Stage-only probability until there are 20+ closed deals |
| Contact role catalogue (type × size) | ✅ As a **one-page cheat sheet**, not a 10-rule engine |
| Objection library | ✅ As a **one-page cheat sheet** |
| Two-sided value, source per claim, unknown ≠ zero | ✅ Core principles, kept in simpler form |
| Cash / in-kind / non-cash kept separate | ✅ |
| Follow-up flag, next action required, lost reasons, handover | ✅ The parts that actually generate deals |
| Seniority matching, warm path first, no cold cash ask | ✅ As guidance |
| GDPR rules | ✅ |

---

## 3. What the system is missing

Several things matter more than anything in the current design:

1. **CBS Talks' own offer:** a one-page media kit (audience size, study-line mix,
   reach, past speakers and partners, photos, testimonials) and a **package
   list with prices**. Without this, every briefing and offer is empty.
2. **A renewal pipeline:** every past and current partner, with what they got,
   whether they were satisfied, and a renewal date. Work this first, every semester.
3. **A sponsorship calendar:** when companies plan budgets and recruitment
   seasons. **This is an assumption to check:** many Danish companies
   plan next year's budgets in the autumn, and recruitment peaks in autumn
   and spring. Timing decides more deals than fit.
4. **Delivery quality:** the post-event report sent to every partner, with
   attendance, study lines and feedback. It's the strongest renewal argument and
   the source of the audience data everything else needs.
5. **A weekly 30-minute pipeline meeting:** owner, next action, blockers. A
   routine beats a dashboard.
6. **A check of CBS's own rules** before any outreach.

---

## 4. The lean version I recommend instead

**Goal:** about **8 inputs per company**, 15–20 minutes of research, and every
number explainable in one sentence.

### 4.1 Two scores, each 0–10

**Fit (value), a simple sum of five 0–2 ratings:**

| Criterion | 0 | 1 | 2 | Size-neutral? |
|---|---|---|---|---|
| **Student pull** | Our audience wouldn't come | Some study lines would | Clear demand (survey, past attendance) | Yes, if measured by survey / attendance, not rankings |
| **Content fit** | No story or person for our themes | A relevant topic, no named speaker | A named person with a strong story for a current theme | Yes |
| **Reason to work with us** | Nothing we offer helps them | Some hiring or visibility need | Clear hiring of CBS profiles or a clear agenda on our topics | Mostly |
| **Track record of paying for student engagement** | None found | Career fairs / small sponsorships | Sponsors student organisations or has paid us before | Behaviour, not size |
| **Long-term potential** | One-off | Could repeat | Recurring need across years | Yes |

**Access (likelihood), one 0–10 ladder:**

| Level | Points |
|---|---:|
| No known person, no path | 0 |
| Right role identified by name | 3 |
| An introduction is available (alumnus, board network, CBS staff) | 5 |
| A warm contact who has responded positively | 8 |
| A champion inside, or a past partner who was satisfied | 10 |

**Why this fixes the main problems:**
- **Relationships become half of the decision** (one full axis), instead of 2.4%.
- **No fact is counted twice:** hiring appears once (*reason to work with us*) and sponsorship behaviour appears once (*track record*).
- **Size has no direct input.** Track record is behaviour, and student pull is measured from students.
- **Every point is explainable in one sentence,** with a source link required for each "2" and for Access ≥ 5.

### 4.2 The 2×2 stays

The 2×2 stays, with simple cut-offs (Fit ≥ 6, Access ≥ 5):

| | Access < 5 | Access ≥ 5 |
|---|---|---|
| **Fit ≥ 6** | **Find an introduction** (time-boxed; max ~5 companies at a time) | **Contact now** |
| **Fit < 6** | **Not now** | **Only for a specific need** (venue, a speaker slot) |

The time box and the cap of 5 on "find an introduction" stop prestige chasing.

### 4.3 Partnership type: chosen by the manager, using a one-page guide

| If… | Then propose… |
|---|---|
| Content fit = 2 | Speaker (always the cheapest first step) |
| Reason = 2 because of hiring | Recruitment event / case workshop |
| Track record = 2 **and** Access ≥ 8 | Sponsorship package |
| Two of the above **and** Long-term = 2 **and** a past partner | Annual partnership |
| Has a venue / service we need | In-kind |
| None of the above | Not now |

Several types may apply. The manager picks the first ask, and writes the reason in one sentence.

### 4.4 Money: which package to offer, not an estimate of their budget

| Situation | Package to propose |
|---|---|
| Paid us before and was satisfied | The same package, or one level up |
| Sponsors other student organisations (level visible) | The matching package level |
| Anything else | The entry package, or a non-cash first step |

There's no DKK estimate of *their* budget and no financial confidence model. The
packages themselves carry the prices. Once there are about 15 closed deals, look at
what actually happened.

### 4.5 CRM: keep, simplified

- **Keep:** stages, follow-up flag, required next action and owner, interaction
  log, lost reasons, cash / in-kind / non-cash separation, renewal dates,
  handover snapshot.
- **Probability:** **stage default only** (no modifiers) until there are 20+ closed deals.
- **Dashboard:**
  - follow-ups due (top);
  - renewals due;
  - pipeline by stage;
  - won vs. target as a simple bar;
  - won and lost lists with reasons.
- **Drop:** target coverage decimals and win rate as a headline figure.

### 4.6 Briefing: a half-page template filled in by a person

The template has six fields, taking about 15 minutes:
1. Why them (with sources)
2. Who, and via whom
3. Our ask (package / first step)
4. Opening angle
5. Three questions to ask
6. Likely objection, from the cheat sheet

No auto-generation until the manual version has proven useful.

### 4.7 Size of the lean version compared with the current design

| | Current design | Lean version |
|---|---|---|
| Rated inputs per company | ~29 (+ confidence each) | 6 |
| Scores shown | 12+ | 2 + a quadrant |
| Tunable parameters | ~150–200 | ~10 |
| Research time per company | 60–90 min | 15–20 min |
| Can be explained to a new board member in | an afternoon | 10 minutes |

---

## 5. What must be true before coding anything

| # | Requirement | Status |
|---|---|---|
| 1 | CBS Talks media kit and package list with prices | ❌ Not started (needs access to CBS Talks) |
| 2 | Audience data from at least the last few events (count, study lines) | ❌ Unknown whether it exists |
| 3 | List of past/current partners with outcomes; renewal pipeline | ❌ |
| 4 | CBS rules for student-organisation sponsorship and outreach checked | ❌ |
| 5 | Lean version run in a spreadsheet: back-test on ~10 past partners and ~5 refusals | ❌ |
| 6 | One semester of real use: is the sheet still updated in week 8? which columns were never used? | ❌ |
| 7 | Decision on the tool (spreadsheet, Airtable, or custom app) based on 6 | ❌ |

**Only after step 6 is there enough evidence to know what an application should
do.** Coding now would harden untested assumptions into software, and make them
harder to change than a spreadsheet column.

---

## 6. What to do with the existing documents

If you agree with this audit, I propose:

1. Write **one** lean specification (`docs/lean-spec.md`) covering §4. It
   replaces the scoring framework, financial model, recommendation engine and
   outreach likelihood documents as the thing to build.
2. Turn the contact catalogue, objection library and GDPR rules into **three
   one-page cheat sheets**.
3. Keep the current documents in an `archive/` folder as background reasoning. Several
   ideas (e.g. type-specific likelihood, financial calibration) may become
   useful once there is real data.
4. Build the spreadsheet MVP from the lean spec.
