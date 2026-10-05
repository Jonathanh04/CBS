# CBS Talks — Partnership CRM

**v1.0 (2026-10-05).** Turns the scoring and recommendation layers into a
working pipeline: stages, tracked fields, expected-value calculations, and a
dashboard. A **clickable dashboard prototype with fictional sample data** goes
with this document (see §7).

How the layers fit together:

```
Scoring & recommendation layers          CRM (this document)
─────────────────────────────────        ───────────────────────────────────────
Priority Score, quadrant, tier      →    which companies enter the pipeline
Recommendation engine               →    partnership type of each opportunity
Financial Potential Model           →    estimated value before a proposal exists
Outreach Likelihood (O1)            →    relationship strength
Contact discovery layer             →    contact person
Outreach briefing                   →    prepared before "Contacted"
                                    ←    outcomes (won/lost, reasons, amounts) feed
                                         calibration of all the models above
```

---

## 0. Design decisions and critique

1. **"Follow-up required" is not a stage; it's a flag.** A follow-up can be
   needed after first contact, after a meeting or after a proposal. If it were a
   stage, a company waiting for a reply on a 25,000 DKK proposal would show as
   "Follow-up required" and lose the information that a proposal is out. It is
   shown as an **overlay flag** on top of the real stage, and it has its own
   dashboard list. You still see it everywhere you expected to.
2. **"Nurture" is a parked state, not a pipeline stage.** It needs a reason and
   a revisit date, otherwise it becomes a place where companies are forgotten.
3. **The pipeline tracks *opportunities*, not companies.** One company can have
   a speaker opportunity in progress and a sponsorship opportunity being
   prepared, at different stages and values. The **company status** shown in
   lists is derived: the most advanced open opportunity.
4. **Probability of closing is calculated, not typed in.** People who own a
   deal are reliably optimistic about it. Probability = a stage default +
   a few evidence-based adjustments, within limits. Overrides are allowed, with a
   reason, and are shown.
5. **Cash, in-kind and non-cash value can't be added together.** A speaker
   commitment has no DKK value. A free venue has an *estimated* market value.
   Adding these to cash sponsorship would make "total pipeline" meaningless. The
   dashboard shows **cash** (the headline), **in-kind (estimated DKK)** and
   **non-cash commitments** (counts: speakers, workshops) separately.
6. **Value has a basis: estimated, proposed or agreed.** Before a proposal
   exists, the value comes from the Financial Potential Model's estimate. It is
   shown as *estimated* and uses the cautious end of the band. Totals show how
   much of the pipeline is just estimates.
7. **Relationship strength is derived from the interaction log** (Outreach
   factor O1). It isn't a separate field someone sets by feel, so the CRM and
   the scoring can't disagree.
8. **"Notes" becomes a structured interaction log** (date, type, person,
   summary, outcome) plus a short free-text field. A single growing notes box is
   unsearchable, can't feed the scoring, and tends to collect personal remarks that
   are a GDPR problem.
9. **Every stage has an exit criterion.** Without one, "Negotiation" means
   whatever the owner feels it means, and the stage probabilities become noise.

---

## 1. Structure

```
Company 1─* Opportunity 1─* Task (next actions)
   │             │
   │             └─* Interaction (contacts, meetings, emails)
   └─ derived: pipeline status (most advanced open opportunity), relationship strength
```

**Opportunity** = one proposed partnership (one type, one value) with one company.
A company that becomes an annual strategic partner has **one** opportunity of
type "Annual strategic", not separate speaker and recruitment opportunities.

---

## 2. Pipeline stages

| Phase | Stage | Definition: enters the stage when… | Exit criterion | Default probability | Max days before flagged |
|---|---|---|---|---:|---:|
| **Research** | **Prospect** | Company is on the long list | Quick screen done | 2% | 30 |
| | **Researching** | Quick screen passed; full assessment underway | Scores not provisional; recommendation exists | 3% | 21 |
| | **Contact identified** | Contact Plan has a **named** entry contact (O2 ≥ 50) | First message sent | 5% | 14 |
| **Active** | **Contacted** | First message sent or introduction made, logged | They reply constructively, **or** follow-up flag | 10% | 10 |
| | **Meeting scheduled** | A meeting has a **date** | Meeting held and logged | 20% | date + 3 |
| | **Proposal sent** | A written proposal with **value and deliverables** was sent | They respond on terms | 40% | 14 |
| | **Negotiation** | They engage on terms (scope, price, dates) in writing or in a meeting | Signed agreement or written "yes", **or** a no | 65% | 21 |
| **Closed** | **Won** | Signed agreement or written confirmation | — | 100% | — |
| | **Lost** | A no, or no response after the follow-up limit | — | 0% | — |
| **Parked** | **Nurture** | Not now, but worth keeping warm. Requires a **reason** and a **revisit date** | Revisit date reached → back to an earlier stage | excluded | revisit date |

**What counts as "pipeline":** only the **Active** stages (Contacted → Negotiation).
Research-phase opportunities are shown separately as **research funnel
potential**, because counting a company we haven't contacted as pipeline
inflates the numbers.

### 2.1 Follow-up required (flag)

Set automatically when **any** of these is true:

- The next action's due date has passed.
- No logged reply within the stage's "max days" (e.g. 10 days after Contacted).
- A meeting was held but nothing was logged within 3 days.

**Follow-up limit:** after **3 unanswered attempts** (spread over at least 3
weeks), the opportunity moves to **Lost** (reason: "no response") or **Nurture**.
It also triggers the Outreach Likelihood cool-off rule.

### 2.2 Stage-change automations

| Event | What the system does |
|---|---|
| → Contact identified | Generate the Contact Plan if missing |
| → Contacted | Require an approved **Outreach Briefing** (for companies covered by the briefing rules); log the first Interaction; set a follow-up due date (+10 days) |
| → Meeting scheduled | Create a task "log meeting outcome" for date + 1 |
| → Proposal sent | Require value, deliverables, partnership type; value basis becomes **proposed** |
| → Won | Require agreed value, deliverables, start/end dates, **renewal date**; create handover tasks (delivery owner, kick-off); value basis becomes **agreed** |
| → Lost | Require a **lost reason** (fixed list, §3) and the objection raised (OB1–OB10 or "other"); feeds the objection library and calibration |
| → Nurture | Require reason + revisit date; create a reminder on that date |
| Responsible person leaves the board | Every open opportunity they own is flagged "needs new owner" |

---

## 3. Tracked fields

| Field | Type | Source | Rules |
|---|---|---|---|
| **Pipeline status** | Stage | Manual (with exit criteria) | Company status derived from its most advanced open opportunity |
| **Last contact date** | Date | **Derived** from the latest Interaction | Never typed by hand |
| **Next action** | Text + **due date** | Manual | **Required** for every open opportunity. Without a next action, an opportunity is flagged |
| **Responsible person** | Board member | Manual | Required from "Researching" on. Must be an active board member |
| **Contact person** | Person record | From the Contact Plan | Shows role, warmth and verification date |
| **Partnership type** | One of the engine's types | Default from the Recommendation Engine; editable | A change from the engine's recommendation needs a reason |
| **Proposed value** | DKK + **value basis** (estimated / proposed / agreed) + **value kind** (cash / in-kind / non-cash) | Estimated: Financial Potential Model; proposed/agreed: manual | Non-cash opportunities record units (e.g. "1 keynote") and no DKK value |
| **Probability of closing** | % | **Calculated** (§4.2) | Override allowed with reason; shown next to the calculated value |
| **Expected value** | DKK | **Calculated** | = Potential value × probability (§4.3) |
| **Notes** | Short free text (≤ 500 characters) + the Interaction log | Manual | No personal opinions about people (GDPR); use Interactions for anything dated |
| **Relationship strength** | None / Cold / Contact / Warm / Champion | **Derived** from O1 (0 / 25 / 50 / 75 / 100) | Never typed by hand |
| *Added:* Priority Score, quadrant | — | Scoring layers | Shown, not edited |
| *Added:* Expected close date | Date | Manual | Needed for "this semester" pipeline |
| *Added:* Lost reason | Fixed list | Manual (required on Lost) | No budget · Chose another organisation · Not relevant for them · Bad timing · No response · Terms not agreed · We withdrew · Other |
| *Added:* Renewal date | Date | Required on Won | Reminder 90 days before |

---

## 4. Calculations

### 4.1 Potential Partnership Value (PPV)

The value used for an opportunity follows this order of precedence:

| Basis | When | Value used |
|---|---|---|
| **Agreed** | Won | The agreed amount |
| **Proposed** | Proposal sent / Negotiation | The proposed amount |
| **Estimated** | Before a proposal | The **cautious value** of the estimated tier from the Financial Potential Model |
| Not estimated | Financial confidence "Not estimated" | No value; excluded from totals and listed as "value unknown" |

Cautious values per estimated tier:

| Estimated tier | < 5k | 5–10k | 10–20k | 20–50k | 50k+ |
|---|---:|---:|---:|---:|---:|
| Value used (DKK) | 2,500 | 5,000 | 10,000 | 20,000 | 50,000 |

The lower edge of each band (the midpoint for < 5k) keeps estimated pipeline from being inflated.

- **In-kind:** an estimated market value (e.g. normal venue hire price), always
  labelled *estimated* and reported separately from cash.
- **Multi-year deals:** PPV is the **first-year** value. The contract total is
  shown separately.

### 4.2 Probability of closing

```
P = stage default (§2)
  + relationship:  Champion +10 · Warm +5 · None (after Contacted) −5
  + past CBS Talks partnership that ended well: +10
  − proposed value above the top of the estimated tier: −10
  − an unresolved objection logged (e.g. "no budget"): −10

limits:  P ≥ ½ × stage default
         P ≤ the next stage's default (so evidence can't make "Contacted" look like "Proposal sent")
         P ≤ 90% for any open opportunity
```

**Example (fictional):** Ravn Advisory, Proposal sent (40%), warm relationship (+5),
proposed 25,000 DKK against an estimated 10–20k (−10) → **35%**.

Overrides need a reason ("verbal yes from the HR Director on 3 Oct") and are
shown as *calculated 35% → override 70%*.

### 4.3 Expected Partnership Value

```
Expected Partnership Value (EPV) = Potential Partnership Value × Probability of Closing
```

Calculated per opportunity, for cash and in-kind separately. Non-cash
opportunities have no EPV; they're reported as **expected commitments**
(probability-weighted counts, e.g. "2.4 expected speakers").

### 4.4 Dashboard totals

| Metric | Definition |
|---|---|
| **Total pipeline value** | Σ PPV of **open Active-stage** cash opportunities |
| **Weighted pipeline value** | Σ EPV of the same opportunities |
| **Estimated share** | Share of the total pipeline whose value basis is "estimated", shown so nobody reads it as committed money |
| **Won (this semester)** | Σ agreed value of opportunities won in the semester |
| **Target coverage** | Weighted pipeline ÷ (semester target − won). **Below 1.0 means the pipeline can't reach the target even if things go as expected** |
| **Win rate** | Won ÷ (Won + Lost), opportunities closed in the period |
| **Research funnel potential** | Σ estimated value of Research-phase opportunities (shown separately, not in the pipeline) |
| **In-kind (estimated)** | Σ estimated value of in-kind opportunities, open and won, separate from cash |

---

## 5. Dashboard

**Filters** (one row at the top): responsible person · partnership type · semester.

| Section | Content | Why it's there |
|---|---|---|
| **Headline figures** | Total pipeline · Weighted pipeline · Won vs. target (with a progress bar) · Target coverage · Win rate | The five numbers the board asks about |
| **Follow-ups due** | Overdue (red, with an icon) and due within 7 days (amber), sorted by due date; with owner, company, next action | The list people act on daily. Placed high on purpose |
| **Companies by stage** | Count and cash value per stage, grouped Research / Active / Closed / Parked | Shows where the pipeline is thin or stuck |
| **Highest-priority prospects** | Open opportunities sorted by Priority Score: quadrant, stage, relationship, next action | Where the most valuable effort is |
| **Won partnerships** | Company, type, agreed value, close date, renewal date | Delivery and renewal tracking |
| **Lost partnerships** | Company, type, value, reason; plus a chart of lost reasons | Feeds the objection library and calibration |
| **Non-cash and in-kind** | Speakers, workshops, venues: committed and expected | Keeps non-cash value visible |

---

## 6. Calibration and data quality

- **Stage probabilities are starting assumptions.** After about 20 closed
  opportunities, replace each default with the **observed** share of
  opportunities that reached Won from that stage. Show both until the observed
  numbers are reliable.
- **Estimate accuracy:** compare each Won amount with the Financial Potential
  estimate made before the proposal (financial model §7).
- **Lost reasons and objections** feed the outreach briefing's objection library each semester.
- **Data quality checks shown on the dashboard:**
  - open opportunities with no next action
  - no owner
  - estimated value older than 6 months
  - overrides older than their expiry
- **Board handover:** the dashboard's state at the handover date is saved as a
  snapshot. The incoming board reviews every open opportunity with its previous owner.

---

## 7. Prototype

A clickable dashboard prototype with **fictional sample data** is in
[`prototype/pipeline-dashboard.html`](../prototype/pipeline-dashboard.html)
(also published as a private artifact). It shows every calculation in this document working on
example rows:
- probability with its breakdown on hover
- expected value
- totals and target coverage
- follow-up flags
- stage counts, won/lost tables and lost reasons

It isn't the application: it has no data entry and stores nothing. The
semester target (120,000 DKK) and all companies, people and amounts are placeholders.

---

## 8. Implementation path

| Phase | What |
|---|---|
| MVP (spreadsheet) | `Pipeline` tab, one row per opportunity, with the §3 fields; probability and EPV as formulas; an `Interactions` tab; a `Dashboard` tab built from pivot tables and the §4.4 formulas |
| v1 (application) | Opportunity, Task and Interaction entities from the data model; stage-change automations (§2.2); the dashboard as in the prototype; weekly email or Slack digest of follow-ups due |

---

## 9. Weaknesses

1. **Small numbers.** With about 20–40 opportunities a semester, weighted pipeline
   swings a lot when one large deal moves. Look at the list behind the number,
   not just the total.
2. **Stages depend on honest logging.** If interactions aren't logged, last-contact
   dates, follow-up flags and relationship strength are all wrong. Logging must
   take under a minute, or it won't happen.
3. **Estimated values can make the pipeline look healthier than it is.** That's
   why the estimated share is shown, and why research-phase value is kept out of
   the pipeline.
4. **Probability rules are simple.** They ignore deal size, partnership type and
   timing. Calibration (§6) is the fix, once there is data.
5. **A CRM doesn't build relationships.** The dashboard should prompt
   conversations, not replace them. The most important column is still
   "next action".
