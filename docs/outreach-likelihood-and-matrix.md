# CBS Talks — Outreach Likelihood Score & Prioritization Matrix

**v1.0 (2026-10-05).** Builds on [`scoring-framework.md`](scoring-framework.md),
[`recommendation-engine.md`](recommendation-engine.md) and
[`financial-potential-model.md`](financial-potential-model.md).

This document defines:

1. The **Outreach Likelihood Score (OLS)**, 0–100: how likely an approach is
   to get a constructive response, and how soon.
2. The **Value × Likelihood matrix**: a 2×2 that sorts every company into one of
   four quadrants, each with its own playbook.

The OLS **replaces** sub-score G and the D9 rating (§6).

---

## 0. Design decisions and critique

1. **The two axes must be as independent as possible, or the matrix is
   useless.** Several of your likelihood questions (recruits CBS students,
   sponsors student organisations, employer branding) are also *value*
   signals. If the same evidence drives both axes, companies cluster in
   "high/high" and "low/low", and the two interesting quadrants empty out. So:
   - The heaviest OLS weights go to **pure access factors** (relationship,
     decision maker, CBS connections, timing), which are absent from the value axis.
   - Behavioural factors are kept, but with low weights.
   - The old G mixed in Partner Need (D3). **D3 is removed from the likelihood axis**
     because it already sits on the value axis.
   - Each semester, the system reports the **correlation between the axes**. If it
     goes above about 0.6, the axes are measuring the same thing and the weights need review.
2. **The likelihood factors split into what we can change and what we can't.**
   - **Can change:** relationship, finding the decision maker, using our
     connections, creating a reason to get in touch.
   - **Can't change:** their hiring, events, sponsorships, presence.
   This split drives the most useful output: an **Achievable OLS** that tells
   you whether building a path to a company is realistic (§3.4).
3. **The "easy but low-value" quadrant is a trap.** Student organisations
   naturally spend most of their time where it's easy: reachable companies
   that don't add much. The matrix gives that quadrant a fixed **effort budget**.
4. **A single value axis hides single-purpose partners.** A great speaker
   source can look mediocre on overall value. The matrix has a **lens**
   setting: the value axis can be switched to one partnership type (§4.4).
5. **Thresholds stay fixed for the semester.** If the cut-offs move whenever
   capacity changes, you can't track companies moving between quadrants, and
   moving companies from "Build a path" to "Approach now" is the main measure
   of outreach work. Too many companies in one quadrant is handled by ranking
   within it, not by moving the cut-off.

---

## 1. Structure

```
                     Outreach Likelihood Score (0–100)
┌──────────────────────────┬──────────────────────────────┬────────────────────────┐
│ ACCESS (45)              │ RESPONSIVENESS (30)          │ TIMING (25)            │
│ can we reach the right   │ do they engage with          │ is there a reason      │
│ person?                  │ students and universities?   │ to talk now?           │
│                          │                              │                        │
│ O1 Relationship      20 ◆│ O4 University events      8  │ O8 Reason to contact  │
│ O2 Decision maker    15 ◆│ O5 Student-org sponsorship 7 │    now (trigger)  12 ◆ │
│ O3 CBS connections   10 ◆│ O6 Recruits CBS students   8 │ O9 Growing/hiring  8   │
│                          │ O7 Employer-branding act.  7 │ O10 CPH/DK presence 5  │
└──────────────────────────┴──────────────────────────────┴────────────────────────┘
◆ = factor CBS Talks can change through its own work
```

**Why these weights:**
- **An existing relationship (20) is the strongest single predictor** of a
  response. A warm introduction usually beats any company characteristic.
- **A known decision maker (15) comes next.** A message to the wrong inbox is
  the most common reason student outreach goes nowhere.
- **Responsiveness factors (7–8 each)** show the company has someone used to
  handling requests from students. They are kept low on purpose to protect the
  independence of the two axes.
- **Timing (25)** reflects that the *same* company responds very differently
  depending on when you ask.

---

## 2. The ten factors

Scale: 0 / 25 / 50 / 75 / 100. Ratings of 75 or more need [V] evidence.
Unknowns are handled per factor (shown in each table), because some unknowns
simply mean "we can't reach them yet".

### Access

#### O1 — Existing relationship (weight 20) ◆

| Score | Definition |
|---|---|
| **0** | No contact on record |
| 25 | One-way contact: we wrote and got no reply, or a brief exchange at an event without follow-up |
| **50** | A named contact responded positively at least once (meeting, call, or constructive email) |
| 75 | Warm contact: two or more positive interactions in the past 12 months |
| **100** | **Active champion** inside the company, **or** a current/past CBS Talks partner whose partnership ended well |

**Source:** **Auto** from the interaction log, pipeline and Person records. *Never
UNKNOWN*: if we don't have it on record, it's 0. Board members' private
contacts count only once logged as an Interaction.

#### O2 — Identifiable decision maker (weight 15) ◆

| Score | Definition |
|---|---|
| **0** | We don't know which function or person decides on student partnerships |
| 25 | We know the likely *function* (e.g. Employer Branding) but have no name |
| **50** | A **named person** in the right function, but responsibility and contact route are unconfirmed |
| 75 | Named person, with a contact route (email or introduction path) |
| **100** | Named person with a **confirmed** responsibility for student engagement or sponsorship (they said so, or it's in their role description) **and** a contact route |

**Source:** **Assisted** (LinkedIn role search, company website, conversations).
Default 0 until searched. **Cap:** if O2 = 0, OLS is capped at 60. A high
likelihood needs a target.

#### O3 — CBS connections: employees or alumni (weight 10) ◆

| Score | Definition |
|---|---|
| **0** | No CBS alumni found among employees |
| **50** | CBS alumni work there, but not in relevant functions, **or** in relevant functions but with no path from our network |
| **100** | CBS alumni in a **relevant function** (HR, employer branding, comms, leadership) **and** reachable through our network (board members, former CBS Talks members, CBS faculty, existing partners) |

**Source:** **Manual** (LinkedIn alumni lookup, entered by hand; don't scrape).
UNKNOWN until searched (counted as 35).

### Responsiveness

#### O4 — Participation in university events (weight 8)

| Score | Definition |
|---|---|
| **0** | Searched, none found in the past 2 years |
| **50** | Occasional: one or two university events a year (a career fair, a guest lecture) at any Danish university |
| **100** | Regular presence **at CBS**: several events a year, e.g. CBS career fair plus case competitions or guest lectures |

**Source:** **Manual,** sharing evidence with Financial factor F5. UNKNOWN until searched.

#### O5 — Sponsors student organisations (weight 7)

**= Financial factor F4** (reused, not re-rated). Here it indicates that the company has
someone used to answering student-organisation requests.

#### O6 — Actively recruits CBS students (weight 8)

| Score | Definition |
|---|---|
| **0** | No recruitment aimed at business students |
| **50** | Recruits business graduates generally (CBS students can apply) but doesn't target CBS specifically |
| **100** | **Explicitly targets CBS:** CBS career fair, CBS job bank postings, CBS-specific programmes or campus recruitment at CBS |

**Source:** **Assisted** (CBS job bank, career fair lists, postings).
It's different from D5: D5 asks whether the jobs are valuable to students; O6
asks whether CBS is already on their recruitment radar.

#### O7 — Employer-branding activity (weight 7)

**= Financial factor F2** (reused). Active employer-branding teams answer
student requests because it's part of their job.

### Timing

#### O8 — Obvious reason to contact now (weight 12) ◆

| Score | Definition |
|---|---|
| **0** | No reason beyond "we'd like a partnership" |
| **50** | **A general or self-created reason:** graduate-recruitment season approaching, their budget planning period, **or** a specific CBS Talks event whose theme matches their agenda (a reason we created) |
| **100** | **A specific, dated, external trigger within the past 6 months:** a new employer-branding or HR hire, an expansion or new Danish office, a launch, an anniversary, a public statement on our topic, or a recent similar sponsorship |

**Source:** a **Trigger** record (type, date, source, expiry). A trigger
**expires after 6 months** and the score falls back automatically. **Mode:**
**Assisted** (news alerts, LinkedIn job changes; logged by hand).

#### O9 — Growing or hiring (weight 8)

| Score | Definition |
|---|---|
| **0** | Hiring freeze, layoffs or restructuring in Denmark in the past 12 months |
| **50** | Stable: normal hiring activity |
| **100** | Clear growth: rising Danish headcount (company register), a sharp increase in postings, a funding round, or an expansion announcement |

**Source:** **Assisted** (company-register headcount trend, posting counts, news).

#### O10 — Presence in Copenhagen / Denmark (weight 5)

| Score | Definition |
|---|---|
| **0** | No Danish presence |
| **50** | Danish presence outside Copenhagen, or a sales office only |
| **100** | Copenhagen-area office with relevant functions (HR, marketing, leadership) |

**Source:** **Auto** from the company register, with a person checking.
It's different from Financial F3: F3 is about *budget authority*; O10 is about
*physical reach* (can they visit, can we visit, can their staff attend).

---

## 3. Calculation

### 3.1 Base score

```
OLS_raw = Σ (weight_i × O_i) / 100
```

### 3.2 Caps (shown as separate lines on the card)

| Condition | Cap | Card wording |
|---|---|---|
| **Do-not-contact** (they asked us not to contact them, or a GDPR objection) | **OLS = 0; excluded from outreach** | "Do not contact (requested on <date>)" |
| Declined us in the past 12 months | **20** | "Declined on <date>; revisit after <date + 12 months>" |
| Past CBS Talks partnership ended badly | **25** | "Previous partnership ended badly. Needs Partnerships Manager approval" |
| Two or more unanswered contact attempts in the past 3 months | **40**, plus a **cool-off** until 3 months after the last attempt | "Cooling off until <date>; try a different contact or route" |
| No decision maker identified (O2 = 0) | **60** | "No decision maker identified yet" |

### 3.3 Confidence

- **Coverage** = the share of OLS weight from rated factors (O1 always counts as rated).
- **Provisional** if coverage < 70%. A provisional OLS is shown hollow in the matrix and
  can't place a company in "Approach now".

### 3.4 Achievable OLS: is building a path realistic?

For companies with a low score, the important question is *can we change it?*
The system recalculates the OLS with the factors we can change raised to
**realistic** levels, while the factors we can't change stay as they are:

| Factor | Realistic level after path-building |
|---|---|
| O2 Decision maker | 100 (assumes research succeeds; flagged if the company is very small or opaque) |
| O1 Relationship | 50 if O3 ≥ 50 (someone can introduce us), otherwise 25 |
| O8 Reason to contact | at least 50 (we can always create a reason: a fitting event invitation) |
| O3 CBS connections | unchanged (alumni exist or they don't; using them shows up in O1) |
| O4–O7, O9, O10 | unchanged (company facts) |

```
If OLS < 50 and Achievable OLS ≥ 50  → "Buildable path"
If OLS < 50 and Achievable OLS < 50  → "Hard path": even with work, unlikely to respond
```

The **likelihood levers** shown on the card are the two factors we can change
with the largest possible gain, e.g. "Identify the decision maker (+15)" and
"Ask the alumnus in their talent team for an introduction (+10)".

---

## 4. The Value × Likelihood matrix

### 4.1 Axes

| Axis | Measure | High when |
|---|---|---|
| **Value** (vertical) | **Fit** from the scoring framework: the Priority Score without outreach, including the mutual-value cap and risk multiplier | Fit ≥ **65** |
| **Likelihood** (horizontal) | **OLS** | OLS ≥ **50** |

Fit, not A, is used for the value axis because A already includes likelihood
(through D9). Using A would count likelihood on both axes.

### 4.2 The four quadrants

```
                    LOW LIKELIHOOD (OLS < 50)        HIGH LIKELIHOOD (OLS ≥ 50)
                 ┌───────────────────────────────┬───────────────────────────────┐
 HIGH VALUE      │  Q2  BUILD A PATH             │  Q1  APPROACH NOW             │
 (Fit ≥ 65)      │  Worth it, not reachable yet. │  Best use of outreach time.   │
                 │  Invest in access, time-boxed.│  Owner + contact in 4 weeks.  │
                 │  ~30% of capacity             │  ~50% of capacity             │
                 ├───────────────────────────────┼───────────────────────────────┤
 LOW VALUE       │  Q4  PARK                     │  Q3  OPPORTUNISTIC            │
 (Fit < 65)      │  No outreach. Re-screen on a  │  Easy, but limited value.     │
                 │  trigger or yearly.           │  Only for a specific need.    │
                 │  0% of capacity               │  Max ~20% of capacity         │
                 └───────────────────────────────┴───────────────────────────────┘
```

### 4.3 Quadrant playbooks

| | Q1 Approach now | Q2 Build a path | Q3 Opportunistic | Q4 Park |
|---|---|---|---|---|
| **Meaning** | High value, reachable | High value, not yet reachable | Reachable, limited value | Neither |
| **Action** | Assign an owner within 1 week; first contact within 4 weeks using the engine's primary type and opening angle | Work the **likelihood levers**: find the decision maker, ask for an introduction, invite them as guests to a fitting event, engage with their content | Low-effort outreach **only when** it serves a current objective (in-kind need, a speaker slot to fill) **or** Fit is 50–64. Use standard packages, no custom proposals | No outreach. Automatic re-screen when a trigger is logged (O8 = 100) or at the yearly review |
| **Effort budget** | ~50% of outreach time | ~30% | ≤ 20% (hard cap) | 0% |
| **Time box** | Until a reply or 3 attempts | **One semester.** If still in Q2 after that, re-evaluate; if Achievable OLS < 50 ("hard path"), move to watch-list | Per opportunity | — |
| **Success measure** | Meetings booked, deals closed | **Companies moved Q2 → Q1** | Objective filled at low effort | — |
| **Ranking within quadrant** | Priority Score A | Fit, then Achievable OLS | Objective match, then A | — |

**Overflow:** if Q1 has more companies than the team can handle, work them in
order of A. The rest wait in Q1; they don't drop to another quadrant.

### 4.4 Lenses: switching the value axis

By default the value axis is overall Fit. It can be switched to a single
partnership type's **suitability** (Recommendation Engine, Step 3):

| Lens | Value axis = | Use when |
|---|---|---|
| Overall (default) | Fit | Semester planning |
| Speaker | Speaker suitability (D) | Filling speaker slots |
| Recruitment | Recruitment suitability (E) | Planning career events |
| Financial | Financial Potential Score | Closing a budget gap |
| In-kind | In-kind suitability | Finding a venue, catering, AV |

The same thresholds apply (≥ 65 high). A company can be Q3 on the overall
lens and **Q1 on the Speaker lens**. That is how the engine's fast-track and
"narrow opportunity" recommendations show up on the matrix.

### 4.5 Display rules

- **Borderline:** companies within ±5 points of either threshold are shown on
  the line, marked "borderline". Their quadrant can flip with a single new piece of evidence.
- **Provisional** (Fit or OLS coverage < 70%): hollow marker, cannot be in Q1,
  and listed in the research queue.
- **Excluded or do-not-contact:** not shown.
- **Movement:** each company shows its quadrant last semester, with an
  arrow if it moved.
- **Badges:** "Fast-track (Speaker)", "Narrow opportunity (In-kind)", "Cooling off",
  "Borderline".

---

## 5. Worked examples (fictional companies)

I checked all values with a short script.

| Factor (weight) | Nordlys | MegaBrand | Fjord | ProServ (warm) | ProServ (cold) | Kobber Hotels | Gamma |
|---|---:|---:|---:|---:|---:|---:|---:|
| O1 Relationship (20) | 0 | 25 | 100 | 100 | 0 | 75 | 0 |
| O2 Decision maker (15) | 50 | 50 | 100 | 100 | 0 | 100 | 0 |
| O3 CBS connections (10) | 100 | 50 | 50 | 100 | 50 | 0 | 0 |
| O4 University events (8) | 50 | 100 | 50 | 100 | 100 | 0 | 0 |
| O5 Student-org sponsorship (7) | 0 | 100 | 0 | 100 | 100 | 0 | 0 |
| O6 Recruits CBS (8) | 50 | 100 | 0 | 100 | 100 | 0 | 0 |
| O7 Employer branding (7) | 50 | 100 | 25 | 100 | 100 | 50 | 0 |
| O8 Reason now (12) | 50 | 50 | 100 | 50 | 0 | 50 | 0 |
| O9 Growing/hiring (8) | 100 | 50 | 100 | 50 | 50 | 50 | 50 |
| O10 CPH/DK (5) | 100 | 100 | 100 | 100 | 100 | 100 | 100 |
| **OLS** | **48** | **62.5** | **71** | **90** | **44** | **48.5** | **9** |
| Achievable OLS | 65.5 (buildable) | — | — | — | 75 (buildable) | 48.5 (hard path) | 35 |
| **Fit** | 70.7 | 55 (capped) | 63.6 | 88.9 | 88.9 | 46.3 | 29.3 |
| **Quadrant (overall)** | **Q2** (borderline OLS) | **Q3** | **Q3** (borderline) | **Q1** | **Q2** | **Q4** (borderline OLS) | **Q4** |
| Lens view | — | — | **Q1 on Speaker lens** (97.5) | — | — | **Q2 on In-kind lens** (100; OLS borderline) | — |

```
                 LOW LIKELIHOOD                    HIGH LIKELIHOOD
 HIGH VALUE   Q2: ProServ (cold) 44 · 89        Q1: ProServ (warm) 90 · 89
              Q2: Nordlys 48 · 71 (borderline)
 ────────────────────────────────────────────────────────────────────────────
 LOW VALUE    Q4: Kobber 48.5 · 46 (borderline) Q3: MegaBrand 62.5 · 55
              ↳ Kobber: Q2 on In-kind lens
              Q4: Gamma 9 · 29                  Q3: Fjord 71 · 64 (borderline)
                                                      ↳ Q1 on Speaker lens
                                       (OLS · Fit)
```

What the examples show:

- **Nordlys (Q2, buildable):** the likelihood levers are "Ask the CBS
  alumnus in their talent team for an introduction (O1 0 → 50, +10)" and
  "Confirm the employer-branding lead (O2 50 → 100, +7.5)". Achievable OLS is 65.5,
  so a semester of path-building should move it to Q1.
- **ProServ cold (Q2, buildable):** a high-value company we can't reach yet.
  Biggest lever: identify the decision maker (+15). This is the kind of
  company the "Build a path" quadrant exists for.
- **MegaBrand (Q3):** easy to reach because they run a full student programme, but
  low value to us because they don't need us. Respond if they come to us;
  don't use Q1 time on them.
- **Fjord (Q3 overall, Q1 on the Speaker lens):** the lens makes the speaker
  opportunity visible. It matches the engine's fast-track.
- **Kobber Hotels (Q4, "hard path"):** a warm contact and a known decision maker,
  but no student or university engagement. **This shows a real weakness in the
  model** (§8, point 1): the responsiveness factors are built for student-facing
  partnerships and undervalue partners like venues. On the In-kind lens it moves to Q2
  (high in-kind value, borderline likelihood). The lens and the engine's "narrow
  opportunity" rule are the safety net.
- **Gamma (Q4):** no reason to act.

---

## 6. Changes to the existing framework

| Item | Change |
|---|---|
| **Sub-score G** | **G = OLS.** The old formula (0.75·D9 + 0.25·D3) is retired; D3 no longer feeds likelihood (§0.1) |
| **D9 in the Priority Score** | **D9 = OLS** (continuous, not rounded). The D9 scoring aid in the framework is replaced by this model. Weight in A stays at 12 |
| **Action tiers** (framework §6.3) | **Tiers A/B map to Q1/Q2.** Tier C (Fit 50–64) and Tier D are now shown as Q3/Q4 by likelihood, with the Q3 sub-rule (Fit 50–64 = opportunistic; Fit < 50 = only for an objective-driven narrow opportunity) |
| **Recommendation engine** | Thresholds unchanged (G ≥ 50 for financial readiness, G ≥ 60 for fast-track and annual readiness); G is now the OLS |
| **Explainability card** | Adds the quadrant, the two likelihood levers and any active cap (cool-off, declined) to the confidence/next-step section |
| **Data model** | `OutreachFactor` ratings O2–O4, O6, O8–O10 (O1, O5, O7 are derived); a `Trigger` entity (company, type, date, source, expires_at); `Interaction.answered` for the unanswered-attempts cap; `Company.do_not_contact` with date and reason |

### 6.1 Effect on earlier worked examples

Because G and D9 are now calculated differently, some earlier numbers change:

| Company | Old G | New OLS | A old → new | Effect on recommendation |
|---|---:|---:|---|---|
| Nordlys | 44 | 48 | 65 → 68 | None. Still Build a path; sponsorship still "after first collaboration" |
| MegaBrand | 44 | 62.5 | 55 → 55 (capped) | One-off sponsorship becomes **ready now** (G ≥ 50) rather than "after first collaboration". Primary stays Recruitment |
| Fjord | 88 | 71 | 68 → 64.5 | None. Fast-track still applies (G ≥ 60) |
| ProServ (warm) | 75 | 90 | 87 → 89 | None. Annual strategic stays primary |
| ProServ (cold) | 38 | 44 | 81 → 83.5 | None |
| Kobber Hotels | 69 | 48.5 | 50 → 46.6 | In-kind commitment changes from **recurring** to **one-off pilot** (recurring needs G ≥ 50) |
| Gamma | 44 | 9 | 32 → 27 | None |

I've updated the two affected lines in `recommendation-engine.md`.

---

## 7. Data collection order

The fastest way to fill the OLS during the quick screen (about 5 minutes per company):

1. **O1:** automatic from our records.
2. **O10, O9:** company register (headcount and trend) and a postings count.
3. **O2:** LinkedIn search for the employer-branding / talent-attraction / HR lead.
4. **O3:** LinkedIn alumni filter "Copenhagen Business School" at the company.
5. **O8:** check news and LinkedIn job changes for a trigger in the past 6 months.

O4–O7 come with the full assessment. They are shared with the Financial
Potential Model, so they are researched once.

---

## 8. Weaknesses

1. **Bias toward student-facing partners.** The responsiveness block (30 points)
   rewards companies that already engage with students. Venues, ecosystem
   organisations and knowledge partners score lower even when they would gladly
   say yes (see Kobber). Mitigations: the type lenses and the engine's narrow-opportunity
   rule. **If this misfires repeatedly, add a type-specific likelihood** that
   replaces the responsiveness block for in-kind, networking and knowledge types.
2. **Network bias is still there.** O1 and O3 reward companies close to the
   current board's network. The Q2 playbook and the Achievable OLS exist to
   reach beyond that, and the sector-diversity check (engine §6) watches for it.
3. **The axes still overlap a little.** O5 and O7 reuse financial factors, and
   O6 relates to D5. Watch the correlation report (§0.1).
4. **Fixed thresholds create cliff edges.** 49 versus 50 changes the
   quadrant. The borderline marker (±5) shows where that matters.
5. **Triggers depend on someone noticing them.** Without news alerts or a routine
   check, O8 stays at 0 or 50 and the "contact now" signal is lost. Make
   checking for triggers a weekly 15-minute task for one board member.
6. **Achievable OLS assumes the path-building works.** It's an *upper*
   estimate. The time box on Q2 keeps that optimism in check.
