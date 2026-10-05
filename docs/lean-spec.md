# CBS Talks Partnership System — Lean Specification

**Version 1.0 · 2026-10-05 · Status: definitive, not yet built**

This is the **only** specification to build from. It replaces the scoring
framework, financial potential model, recommendation engine, outreach
likelihood model, explainability layer, contact discovery layer, outreach
briefing and CRM documents. Those are kept in [`archive/`](archive/) as
background reasoning; the reasons for the change are in [`audit.md`](audit.md).

Supporting one-page cheat sheets:
- [Partnership type & first ask](cheat-sheets/partnership-type.md)
- [Who to contact](cheat-sheets/who-to-contact.md)
- [Conversations & outreach rules](cheat-sheets/conversations-and-outreach.md)

---

## 1. Purpose and design rules

**Purpose:** help the CBS Talks Partnerships Manager and board decide, each
week, **which companies to work on and what to do next**, and keep partnership
knowledge alive across board handovers.

**The system answers four questions:**

| Question | Answered by |
|---|---|
| Who should we work on this week? | The **work queue** (§3.5): renewals → follow-ups → Priority → Build a Path |
| Why is this company a good or bad fit? | **Fit**: five ratings, each with a one-line reason and a source |
| What should we offer, and what partnership type? | The **partnership type cheat sheet**, applied by a person |
| What happened, and what's next? | The **CRM**: opportunities, interactions, next actions |

**Design rules (non-negotiable):**

1. **Two scores only: Fit (0–10) and Access (0–4).** No other composite scores.
2. **No budget estimates.** We record *observed* commercial evidence, never a
   guess of what a company could pay.
3. **Relationships are half the decision.** Access is a full axis of the matrix.
4. **Every rating of 2 and every Access level of 2 or more needs a reason and a source.**
5. **"Not checked" and "checked, nothing found" are different.** A company
   enters the matrix only when all five Fit criteria have been rated.
6. **AI-produced text is always labelled** Verified fact / Source-backed
   inference / Unknown, and is never stored as fact until a person has checked the source.
7. **Guesses become questions.** The system never states a company's objective or
   objection as fact. It lists things to *ask* and things to *prepare for*.
8. **Small enough to maintain:** about 15–20 minutes of research per company,
   and about 1 minute to log an interaction.

---

## 2. The model

### 2.1 Fit (0–10): how good would a partnership be, for both sides?

Five criteria, each rated **0, 1 or 2**, or left **unrated**. Fit = the sum, and
is shown only when all five are rated.

| Criterion | 0 | 1 | 2 | Evidence for a 2 (source required) |
|---|---|---|---|---|
| **F1 Student pull**: would our audience come? | Checked: no sign CBS students care about this company or its field | Relevant to some study lines, or moderate interest | Clear demand: past CBS Talks attendance for this company/sector, a strong result in our audience poll, or explicit student requests | Our event data, poll results, student requests |
| **F2 Content fit**: do they have a story or person for our themes? | No link to any current theme | A relevant topic, but no named speaker or concrete idea | A **named person** or a **concrete event idea** that fits a current theme | The person's talks/interviews; their published work on the topic |
| **F3 Reason to work with CBS Talks**: what's in it for them? | Checked: nothing we offer helps them | Some hiring of business profiles or some interest in our topics | Clear, recurring hiring of CBS-type profiles, **or** an active public agenda on one of our themes | Job postings, graduate programme page, campaigns, their reports |
| **F4 Track record of paying for student engagement** | **Derived** from Commercial Evidence (§2.3). Not rated by hand | | | |
| **F5 Long-term potential**: could this repeat? | One-off reason only | Could plausibly repeat | A recurring need across years (annual graduate hiring, ongoing topic), or a past multi-year partnership | Recurring programmes, past renewals |

**High Fit = 6 or more.** Calibrate this threshold in the back-test (§8, step 4).

Each rating stores: value, a **one-line reason** (≤ 140 characters), a **source
link** (required for a 2), who rated it, and the date.

**Not used:** company size, revenue, market cap, brand fame or rankings as such.
Large companies can score well, but only through student demand, content,
reasons and behaviour that have been observed.

### 2.2 Access (0–4): how reachable is the right person?

**Access is derived** from Contacts, Commercial Evidence and opportunity
history: the highest level that applies. It is never typed in by hand, which
removes a whole category of disagreement.

| Level | Name | Applies when |
|---:|---|---|
| 0 | **No path** | No named contact and no introduction route |
| 1 | **Named person** | A Contact in a suitable role (see the [who-to-contact cheat sheet](cheat-sheets/who-to-contact.md)) is named, with a source |
| 2 | **Introduction available** | Someone we know has agreed to, or can realistically, introduce us: a board member, alumnus, CBS staff member or partner. Recorded in `intro_path` with the introducer's name |
| 3 | **Warm contact** | A Contact at the company has responded positively to us in the past 12 months (a logged interaction with outcome *positive*) |
| 4 | **Champion / satisfied past partner** | A Contact is marked *champion* (actively pushing for us internally), **or** the company has a Won partnership whose satisfaction was recorded as *satisfied* |

**High Access = level 2 or more.**

Access automatically drops:
- **No positive interaction for 12 months:** a warm contact counts as a named person again.
- **Contact left the company:** that contact no longer counts.

### 2.3 Commercial Evidence (a record, not a score)

A list of **observed facts** about a company's spending on student or similar
engagement. Each item has a **source** and a **date**.

| Type | Meaning | Source required |
|---|---|---|
| `none_found` | We checked (store *where* and *when*) and found no sponsorship activity | Description of what was checked |
| `sponsors_student_orgs` | Named as a sponsor/partner of a student organisation | URL (partner page, post) |
| `sponsors_university_activities` | Career fairs, university partnerships, sponsored university events | URL |
| `sponsors_similar_events` | Sponsors talks, conferences or community events outside universities | URL |
| `previous_cbs_talks_partner` | Has partnered with CBS Talks before (any type) | Link to the opportunity in our system |
| `previous_cbs_talks_spend` | Has paid CBS Talks: **amount and year from our own records** | Link to the Won opportunity |

**F4 (Track record) is derived from these items:**

| Commercial Evidence | F4 |
|---|---:|
| `previous_cbs_talks_spend` **or** `sponsors_student_orgs` | **2** |
| `sponsors_university_activities` **or** `sponsors_similar_events` **or** `previous_cbs_talks_partner` (non-cash) | **1** |
| only `none_found` | **0** |
| no items at all | **unrated** (the company stays in Research) |

**What is never recorded:** an estimate of their budget. The only DKK amounts in
this field are amounts CBS Talks actually received. Which package to *offer* is
decided with the [partnership type cheat sheet](cheat-sheets/partnership-type.md),
based on these facts.

### 2.4 Labels for AI-produced and researched information

Every Evidence item (and any AI-drafted text pasted into the system) carries one label:

| Label | Meaning | Rules |
|---|---|---|
| **Verified fact** | A person opened the source and confirmed it says this | Source URL + checked_by + checked_at required |
| **Source-backed inference** | A conclusion drawn from a cited source, e.g. "20 graduate postings in 2026 → recurring hiring need" | Must cite the source **and** state the reasoning in one sentence. Shown in italics, prefixed "Inference:" |
| **Unknown** | Something relevant we don't know | Shown as an open question |

- AI-drafted items start as **unchecked** (`ai_drafted = true`, `checked_by` empty).
  They are shown with a warning and **cannot support a Fit rating of 2** until checked.
- An AI suggestion without a source is discarded. It isn't stored as "inference".
- Fit reasons are written by people; they may cite inferences, but the label stays visible.

### 2.5 The matrix

| | **Access 0–1 (low)** | **Access 2–4 (high)** |
|---|---|---|
| **Fit 6–10 (high)** | **Build a Path:** work on getting an introduction. **Max 5 companies at a time**, each time-boxed to one semester | **Priority:** contact now. Assign an owner; first contact within 2 weeks |
| **Fit 0–5 (low)** | **Low Priority:** no outreach. Re-check once a year, or when new evidence appears | **Quick Win:** pursue **only** when it serves a specific current need (a venue, a speaker slot, catering), recorded in `specific_need`. Use standard packages; no custom proposals |

Companies with any Fit criterion unrated are shown as **Research**, outside the matrix.

**Ordering within a quadrant** (sorting only, no new score): Fit (high → low),
then Access (high → low), then oldest last contact first.

---

## 3. Priority logic (exact rules)

All logic consists of simple, deterministic functions over stored fields.

### 3.1 Fit

```
F4 = derive_track_record(commercial_evidence)            # table in §2.3
fit = F1 + F2 + F3 + F4 + F5     if all five are not null
    = null ("Research")          otherwise
high_fit = fit >= 6
```

### 3.2 Access

```
access = 4 if any contact.relationship == "champion" (and not left_company)
              or any won opportunity with satisfaction == "satisfied"
         3 if any contact has an interaction with outcome "positive" in the last 365 days
              (and not left_company)
         2 if company.intro_path is not empty
         1 if any contact exists in a suitable role (not left_company, not do_not_contact)
         0 otherwise
high_access = access >= 2
```

### 3.3 Quadrant

```
if company.do_not_contact:   "Do not contact"   (hidden from queues)
elif fit is null:            "Research"
elif high_fit and high_access:   "Priority"
elif high_fit:                   "Build a Path"
elif high_access:                "Quick Win"
else:                            "Low Priority"
```

### 3.4 Flags (computed daily)

| Flag | Rule |
|---|---|
| **Renewal due** | A Won opportunity with `renewal_date` ≤ today + 90 days **and** no open renewal opportunity for that company |
| **Overdue** | Open opportunity with `next_action_due` < today |
| **Due this week** | Open opportunity with `next_action_due` ≤ today + 7 |
| **Missing next action** | Open opportunity with no `next_action` or no due date |
| **No reply** | Stage *Contacted* and no logged reply for 10 days |
| **Path overdue** | Company in Build a Path with `path_started_at` more than one semester ago |
| **Path cap exceeded** | More than 5 companies with `path_in_progress = true` |
| **Stale research** | `fit_reviewed_at` more than 12 months ago |
| **Unchecked AI evidence** | Evidence with `ai_drafted = true` and no `checked_by` |

### 3.5 The work queue (the main screen)

Shown in exactly this order:

1. **Renewals:** every *Renewal due* company, earliest renewal date first.
2. **Follow-ups:** *Overdue*, then *No reply*, then *Due this week*; earliest due date first.
3. **Priority prospects without an open opportunity:** quadrant Priority with no
   open opportunity; sorted as in §2.5. Shows the suggested first step from the cheat sheet.
4. **Building paths:** companies with `path_in_progress = true`, oldest first,
   with their path action. Shows up to 5. If fewer than 5 are in progress, the top
   un-started Build a Path companies are listed as candidates.

Quick Wins appear only when `specific_need` is set. Low Priority never appears.

---

## 4. CRM workflow

### 4.1 Opportunity stages

```
Planned → Contacted → Meeting → Proposal sent → Negotiation → Won
                                                           ↘ Lost
          (any open stage) → Nurture → (back to Planned on its revisit date)
```

| Stage | Enter when | Required fields on entry |
|---|---|---|
| **Planned** | We've decided to approach | partnership type, owner, contact (or intro path), next action + due date |
| **Contacted** | First message sent or introduction made | an Interaction logged |
| **Meeting** | A meeting has a date | meeting date (as the next action) |
| **Proposal sent** | A written proposal with deliverables and price was sent | package or proposed value (DKK, or non-cash description) |
| **Negotiation** | They respond on terms (scope, price, dates) | — |
| **Won** | Written confirmation or signed agreement | agreed value (or non-cash description), start/end date, **renewal date** |
| **Lost** | A no, or 3 unanswered attempts over at least 3 weeks | **lost reason** (fixed list) |
| **Nurture** | Not now, but worth keeping warm | **reason** and **revisit date** |

**Follow-up is a flag, not a stage** (§3.4). There are no probabilities and no
expected values in the MVP (see §9).

**Lost reasons (fixed list):** No budget · Chose another organisation · Not
relevant for them · Bad timing · No response · Terms not agreed · We withdrew · Other.

### 4.2 After Won: delivery and renewal

| When | What | Field |
|---|---|---|
| On Won | Set the delivery owner and the renewal date (default: 60 days before the agreement ends) | `renewal_date` |
| After each partner event | Send a short **partner report**: attendance, study-line mix, photos, feedback | `report_sent_at` on the Event |
| After delivery | Record satisfaction: *satisfied / neutral / unsatisfied / unknown*, with a one-line reason from a conversation | `satisfaction` |
| 90 days before the renewal date | The company appears in the Renewals queue | — |

Satisfaction recorded as *satisfied* raises Access to 4. It is the system's way
of rewarding good delivery.

### 4.3 Logging

- **Interaction** (≤ 1 minute): date, channel, contact, one-line summary, outcome
  (*positive / neutral / negative / no reply*), and update next action.
- **Last contact date** is always derived from Interactions, never typed in.
- **Notes:** one short free-text field per company (≤ 500 characters). Nothing
  personal about individuals (GDPR).

### 4.4 Outreach briefing (manual, half a page)

Before first contact with a **Priority** company or a renewal, the owner fills in
this template (about 15 minutes):

```
COMPANY                 Fit __/10 · Access __ · Commercial evidence: __
1. Why them             (from Fit reasons, with sources)
2. Who, and via whom    (contact + intro path; checked still in role on __)
3. Our first ask        (from the partnership type cheat sheet: type + package)
4. Opening angle        (2–3 sentences, verified facts only)
5. Questions to ask     (pick 3 from the conversations cheat sheet)
6. Prepare for          (possible objections from the cheat sheet; labelled as
                         possibilities, not predictions)
7. Unknowns             (what we don't know and want to learn)
```

There is no "likely objective" field. Their goals are something to **ask about**
(item 5), not to assume.

### 4.5 Weekly routine (30 minutes, Partnerships Manager + owners)

1. Go through the work queue top to bottom: each item gets an owner and a next action.
2. Check flags: overdue, missing next action, path cap.
3. Move stages and log anything not yet logged.
4. Once a month: review Low Priority and Research items that have new evidence.

### 4.6 Board handover (every year)

- Export a snapshot of all open opportunities, renewals and contacts.
- Each outgoing owner goes through their open opportunities with the incoming
  owner and reassigns them in the system.
- Deactivate outgoing team members. Their open items show *needs new owner* until reassigned.

---

## 5. Required company fields

**Required** = must be filled for the company to leave Research.

| Field | Required | Notes |
|---|---|---|
| Name | ✅ | |
| Website | ✅ | |
| CVR number | optional | For Danish entities |
| Industry | ✅ | Short fixed list (about 12 values) |
| Size band (DK employees) | optional | Descriptive only. **Not used in any rule** |
| Owner (board member) | ✅ | |
| F1 Student pull + reason (+ source if 2) | ✅ | |
| F2 Content fit + reason (+ source if 2) | ✅ | |
| F3 Reason to work with CBS Talks + reason (+ source if 2) | ✅ | |
| F5 Long-term potential + reason (+ source if 2) | ✅ | |
| Commercial Evidence (≥ 1 item, `none_found` allowed) | ✅ | Derives F4 |
| Fit reviewed at / by | ✅ | Set automatically when ratings change |
| Contacts (name, title, role category, relationship, source, verified at) | for Access ≥ 1 | |
| Intro path (who can introduce us, and their agreement) | optional | Access 2 |
| Specific need | for Quick Win | e.g. "venue for 19 Nov", "speaker on AI and work" |
| Path in progress, path action, path started at | for Build a Path | Max 5 in progress |
| Notes | optional | ≤ 500 characters |
| Do not contact + reason + date | when applicable | Hides from all queues |

**Contact fields:** name, title, role category (from the who-to-contact cheat sheet),
relationship (*named / champion*), CBS alumnus (yes/no/unknown), work email or
LinkedIn URL (published or given to us only), source, verified at, left company,
do not contact.

---

## 6. Required CBS Talks organisation fields

The system can't support outreach without these. **Collect them first** (§8, step 1).

| Field | Why it's needed |
|---|---|
| Mission / one-paragraph description | Opening angles, briefings |
| **Themes** for the current year | F2 Content fit |
| **Events:** date, title, theme, attendance, study-line mix (from registration), partner(s), partner report sent | F1 Student pull; the facts every pitch depends on; renewal reports |
| **Audience summary:** typical attendance, study-line distribution, international share, social and newsletter reach (each with a date) | Answers "who will we reach?" |
| **Packages:** name, price (DKK), what's included, capacity per semester | First asks; no budget guessing |
| **Past and current partners** (imported as Companies + Won opportunities) | Renewal pipeline; F4 and Access 4 |
| **Semester:** dates and a cash target (DKK) | Dashboard target bar |
| **Team members:** name, role, email, active, term start/end | Owners and handover |
| **Editorial independence policy** (short text) | Answers content-control questions honestly |
| **CBS rules check:** what CBS allows for student-organisation sponsorships, who was asked, when | Must be done before outreach |
| Category exclusivities currently granted | Avoids conflicting deals |

---

## 7. Database schema

Designed so the **spreadsheet MVP** (one tab per table) and a later database
use the same structure. Types are given for a relational database. In a
spreadsheet, IDs are row IDs and enums are dropdowns.

```
team_members
  id               PK
  name             text      not null
  role             text      -- e.g. "Partnerships Manager"
  email            text
  active           boolean   default true
  term_start       date
  term_end         date

org_profile                  -- single row
  mission          text
  audience_summary text
  typical_attendance int
  study_line_mix   text      -- or json: {"BSc IB": 0.22, ...}
  reach_summary    text      -- social/newsletter, with dates
  independence_policy text
  cbs_rules_notes  text
  cbs_rules_checked_at date
  semester_start   date
  semester_end     date
  semester_cash_target_dkk int

themes
  id PK · name text · year text · active boolean

packages
  id PK · name text · price_dkk int · includes text · capacity_per_semester int · active boolean

events
  id PK · title text · date date · theme_id FK themes
  attendance int · study_line_mix text · report_sent_at date

companies
  id               PK
  name             text      not null
  website          text      not null
  cvr              text
  industry         enum      (fixed list)
  size_band        enum      ('<50','50-249','250-999','1000+', null)   -- descriptive only
  owner_id         FK team_members
  f1_student_pull  smallint  check in (0,1,2) null
  f1_reason        text      -- ≤140
  f1_source        text      -- required if f1 = 2
  f2_content_fit   smallint  null
  f2_reason        text
  f2_source        text
  f3_reason_to_work smallint null
  f3_reason        text
  f3_source        text
  f5_long_term     smallint  null
  f5_reason        text
  f5_source        text
  fit_reviewed_at  date
  fit_reviewed_by  FK team_members
  intro_path       text      -- "Board member X via alumnus Y (agreed 2026-10-01)"
  specific_need    text      -- Quick Win justification
  path_in_progress boolean   default false
  path_action      text
  path_started_at  date
  notes            text      -- ≤500
  do_not_contact   boolean   default false
  do_not_contact_reason text
  created_at       timestamp
  -- derived (views, not stored): f4_track_record, fit, access, quadrant, last_contact_at

commercial_evidence
  id               PK
  company_id       FK companies
  type             enum ('none_found','sponsors_student_orgs','sponsors_university_activities',
                         'sponsors_similar_events','previous_cbs_talks_partner','previous_cbs_talks_spend')
  description      text      not null   -- what was observed, or what was checked for none_found
  source_url       text      -- required except for previous_cbs_talks_* (use opportunity_id)
  opportunity_id   FK opportunities null
  amount_dkk       int       -- ONLY for previous_cbs_talks_spend, from our records
  observed_year    int
  recorded_by      FK team_members
  recorded_at      date

evidence                     -- supporting facts/inferences for Fit reasons and briefings
  id               PK
  company_id       FK companies
  criterion        enum ('F1','F2','F3','F5','access','general')
  statement        text      not null
  label            enum ('verified_fact','source_backed_inference','unknown')
  reasoning        text      -- required for source_backed_inference
  source_url       text      -- required unless label = unknown
  ai_drafted       boolean   default false
  checked_by       FK team_members null
  checked_at       date

contacts
  id               PK
  company_id       FK companies
  name             text      not null
  title            text
  role_category    enum      (from the who-to-contact cheat sheet)
  relationship     enum ('named','champion') default 'named'
  cbs_alumnus      enum ('yes','no','unknown')
  work_email       text      -- published or given to us only
  linkedin_url     text
  source           text      not null
  verified_at      date
  left_company     boolean   default false
  do_not_contact   boolean   default false

opportunities
  id               PK
  company_id       FK companies
  type             enum ('speaker','recruitment','event_sponsor','recurring_sponsor',
                         'annual_partner','knowledge','content','networking','in_kind')
  stage            enum ('planned','contacted','meeting','proposal_sent','negotiation',
                         'won','lost','nurture')
  owner_id         FK team_members
  contact_id       FK contacts null
  is_renewal       boolean   default false
  previous_opportunity_id FK opportunities null
  value_kind       enum ('cash','in_kind','non_cash')
  package_id       FK packages null
  proposed_value_dkk int     -- set at proposal_sent
  agreed_value_dkk int       -- set at won
  non_cash_description text  -- e.g. "1 keynote", "venue for one evening"
  next_action      text
  next_action_due  date
  start_date       date
  end_date         date
  renewal_date     date      -- required at won
  satisfaction     enum ('satisfied','neutral','unsatisfied','unknown') default 'unknown'
  satisfaction_reason text
  lost_reason      enum      (fixed list, §4.1)
  nurture_reason   text
  nurture_until    date
  created_at       timestamp
  closed_at        date

interactions
  id               PK
  company_id       FK companies
  opportunity_id   FK opportunities null
  contact_id       FK contacts null
  team_member_id   FK team_members
  date             date      not null
  channel          enum ('email','linkedin','call','meeting','event','other')
  summary          text      -- ≤280
  outcome          enum ('positive','neutral','negative','no_reply')

opportunity_events            -- which events delivered a partnership
  opportunity_id FK · event_id FK
```

**Eleven tables** (plus one link table); four of them (org profile, themes,
packages, team) are small and change rarely. All derived values (F4, Fit,
Access, quadrant, last contact, flags) are **views or formulas, never stored**,
so they can't go out of sync.

**Validation rules** (enforced by the database, or by data validation in the spreadsheet):
- Fit rating = 2 requires a non-empty source.
- `previous_cbs_talks_spend` requires `opportunity_id` and `amount_dkk`; `amount_dkk` is not allowed on any other evidence type.
- An `evidence` row with label ≠ unknown requires `source_url`; *source_backed_inference* requires `reasoning`.
- Stage transitions require the fields listed in §4.1.
- `path_in_progress = true` is refused once 5 companies already have it.

---

## 8. Implementation plan

### Step 1 — Collect CBS Talks basics (weeks 1–2 after joining; no system needed)
- Packages with prices, themes, the editorial independence policy.
- Event history with attendance, and study-line mix if registration data has it.
- The list of past and current partners: what they got, what they paid, how it went.
- **A check of CBS's rules** for student-organisation sponsorships and outreach.
- A one-page media kit built from the above. Useful in every conversation, system or not.

### Step 2 — Build the spreadsheet MVP (1–2 days)
- Google Sheet in a CBS Talks shared drive (not a personal drive). One tab per
  table in §7, with dropdowns for enums.
- Formula tabs: `Fit & Access` (F4, Fit, Access, quadrant), `Work queue`
  (§3.5 order), `Dashboard` (§9).
- Conditional formatting for flags. Protect the formula tabs.

### Step 3 — Import existing knowledge (2–3 hours)
- Past and current partners as Companies + Won opportunities (with renewal dates
  and satisfaction where known), and `previous_cbs_talks_*` evidence.
- Known contacts from the outgoing board's inboxes and memory, with sources.

### Step 4 — Back-test (half a day)
- Rate about **10 past partners** and **5 companies that said no**.
- Expected: most past partners have Fit ≥ 6; most refusals show either low Fit
  or low Access.
- If not, adjust the **anchors** (wording), and only then the threshold of 6.
  Write down what changed and why.

### Step 5 — Use for one semester
- Long list of 40–60 companies, quick-rated (15–20 minutes each, spread across the board).
- Weekly 30-minute routine (§4.5).
- **Week 8 check:** is the sheet still updated? Which columns are always empty?
  Which flags did people ignore? Remove what isn't used.

### Step 6 — Decide on the tool (end of semester)
| If the sheet… | Then |
|---|---|
| works and the team is happy | Keep it. Spend the effort on the media kit and delivery |
| works but is getting slow or error-prone | Move to **Airtable** (or similar no-code database) using the same schema |
| needs things no-code tools can't do | Build a **small custom app** from §7. **Only if** a maintainer is guaranteed across board handovers; otherwise it will be abandoned after one year |

**AI in the MVP:** none built in. Board members may use an AI assistant for
research, but anything pasted in goes into `evidence` with `ai_drafted = true`
and stays unchecked until a person verifies the source.

---

## 9. Dashboard requirements

One page, in this order. Every number is a count or a sum of recorded amounts:
no probabilities, no expected values, no estimates.

| # | Section | Content |
|---|---|---|
| 1 | **Work queue** | §3.5: Renewals → Follow-ups → Priority without opportunity → Building paths. Each row: company, why it's here (flag), owner, next action, due date |
| 2 | **Matrix** | Counts per quadrant (Priority / Build a Path / Quick Win / Low Priority / Research), each clickable to its list. Path counter "3 / 5 in progress" |
| 3 | **Semester money** | Cash **won** vs. target (bar) · cash in **Proposal sent + Negotiation** (proposed values, labelled "proposed, not committed") · number of open opportunities by stage |
| 4 | **Non-cash and in-kind** | Won and open: speakers, workshops, venues (listed, not summed in DKK) |
| 5 | **Won this semester** | Company, type, agreed value / description, renewal date, satisfaction |
| 6 | **Lost this semester** | Company, type, lost reason; count per reason |
| 7 | **Data health** | Open opportunities without a next action · companies without an owner · contacts not verified in 6 months · unchecked AI evidence · path cap exceeded |

Filters: owner, opportunity type, semester.

**Explicitly not in the MVP:** probability of closing, weighted pipeline,
expected value, win-rate headline, budget estimates, target coverage ratios. Add
stage-based probabilities **only** after 20+ closed opportunities exist to
calibrate them, and only if the board actually needs a forecast.

---

## 10. Worked example (fictional companies)

These illustrate the rules; they aren't evidence that the thresholds are right.
The back-test (§8, step 4) is.

| Company | F1 | F2 | F3 | F4 (from evidence) | F5 | **Fit** | Access | **Quadrant** | Suggested first step (cheat sheet) |
|---|---:|---:|---:|---|---:|---:|---|---|---|
| ProServ: past partner, paid us, satisfied | 2 | 2 | 2 | 2 (previous spend) | 2 | **10** | 4 (satisfied past partner) | **Priority**, and **Renewal due** | Renewal: same package or one up |
| MegaBrand: sponsors two CBS organisations; we only know a name | 2 | 1 | 1 | 2 (sponsors student orgs) | 1 | **7** | 1 (named person) | **Build a Path** | Find an introduction; then a recruitment event |
| Nordlys: hires graduates, never sponsored anyone; alumnus can introduce | 1 | 1 | 2 | 0 (checked, none found) | 2 | **6** | 2 (introduction available) | **Priority** | Recruitment pilot (case workshop) as a non-cash first step (no sponsorship found) |
| Fjord: founder is a great speaker, warm contact | 1 | 2 | 1 | 0 (none found) | 1 | **5** | 4 (champion) | **Quick Win**, need: "speaker for March" | Speaker slot, no cash ask |
| Kobber Hotels: venue, warm contact | 0 | 0 | 1 | 1 (sponsors local events) | 1 | **3** | 3 (warm) | **Quick Win**, need: "venue for 19 Nov" | In-kind venue |
| Gamma Software | 0 | 0 | 0 | 0 (none found) | 0 | **0** | 0 | **Low Priority** | — |

Compared with the old model, MegaBrand is no longer suppressed: its sponsorship
behaviour counts. The past partner goes straight to the top through Renewals.

---

## 11. Known limits (accepted on purpose)

1. **Fit ratings are still judgement.** Short anchors, a reason and a source for
   every 2, plus the back-test, keep them honest enough for ranking. They are
   not measurements.
2. **The threshold of 6 is a starting point.** Adjust it once, after the back-test, and then leave it alone for the semester.
3. **Access favours our existing network.** That's deliberate. Relationships close
   deals. The Build a Path quadrant (max 5) is how the network grows on purpose.
4. **No forecast.** The board sees committed money and money under proposal, not a
   prediction. That's a feature until there's enough history to forecast honestly.
