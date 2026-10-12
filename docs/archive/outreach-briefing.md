# CBS Talks — Outreach Briefing

**v1.0 (2026-10-05).** The final layer. It combines the scoring framework,
explainability card, recommendation engine, financial model, outreach
likelihood and contact plan into **a one-page briefing the Partnerships Manager
reads before contacting a company**.

A briefing is **not** a pitch and **not** an email draft. It answers: *what do I
need to know, what do I want from this conversation, and what will they push
back on?* It should take about two minutes to read.

---

## 0. Design decisions and critique

1. **"Above 75/100" needs two additions.** I kept your threshold (Priority
   Score A > 75) as the main trigger, but on its own it misses things:
   - **Fast-track companies** are excluded. For example, Fjord Ventures (A = 64.5)
     is the best speaker opportunity in the examples.
     **Added:** briefings also go to fast-track and narrow-opportunity companies.
   - **Companies with "Build a path" status** (high value, not yet reachable) below 75 are excluded,
     e.g. Nordlys (A = 68). That's acceptable, because their next step is getting an
     introduction, not a briefed conversation. They get a briefing as soon as
     the introduction is agreed.
   - **Provisional scores** (coverage < 70%) never get a briefing, even above
     75. A briefing built on assumptions gives a false sense of preparation.
     They get a research list instead.
2. **"Likely objective" and "likely objection" are inferences.** They are labelled
   [I] and come from **named rules** (an objection library, §3), each linked
   to the evidence that triggered it. They are never invented for the occasion.
3. **Responses to objections may only use verified facts about CBS Talks.**
   If an objection is "what's the ROI?" and we have no audience data, the
   briefing says so ("Missing: attendance by study line, so collect this
   before the meeting") instead of writing a confident answer we can't back up.
4. **The first contact aims for a conversation, not a deal.** Each briefing
   states the **goal of the first contact** (usually a 30-minute meeting), the
   **questions to ask**, and **what not to say**. These were missing from the brief
   and they matter more than the pitch.
5. **Check for collisions first.** Several board members may know the same
   company. Before any outreach, the briefing checks that nobody else at CBS
   Talks has an open thread with this company.

---

## 1. Inclusion rules

| Rule | Briefing? |
|---|---|
| A > 75 **and** not provisional **and** not excluded / do-not-contact / cooling off | **Yes** |
| Fast-track (a type-specific score ≥ 80 and OLS ≥ 60) | **Yes**, focused on that partnership type |
| Narrow opportunity (engine verdict) | **Yes**, short version focused on that type |
| "Build a path" (high value, not reachable), A ≤ 75 | Not yet. A briefing is generated when an introduction is agreed (O1 ≥ 50) |
| Provisional, even if A > 75 | **No.** A research list instead |

A briefing **expires after 30 days** or as soon as a score, contact or trigger
changes. It must then be regenerated, because outdated briefings lead to
embarrassing mistakes (a contact who left, an expired trigger).

---

## 2. The briefing: fields, sources and rules

| # | Field | Source | Rules | Max length |
|---|---|---|---|---|
| 1 | **Why contact them** | Explainability card: bottom line + top 3 reasons | Evidence, not restated scores; tagged | 3 bullets |
| 2 | **Who to contact** | Contact Plan | Entry contact + route, owner/decision role, champion; verification date of the named person | 3 lines |
| 3 | **Their likely objective** | Need flags (D3) + the role's success measures (contact catalogue) | Always **[I]**, with the facts it rests on. Phrased in *their* terms, e.g. "fill ~20 graduate roles", not "partner with us" | 2 bullets |
| 4 | **What CBS Talks should offer** | Recommendation engine (primary + secondary, commitment) + offering catalog | The **entry offer** for this first conversation, plus where it could lead | 2–3 lines |
| 5 | **Event / topic to propose** | Card field 5 (event concept) | Format · working title · theme · status (our idea / discussed / agreed) | 2 lines |
| 6 | **Suggested sponsorship level** | Financial Potential Model | Estimated tier (**labelled as an estimate**) + confidence + **which package to propose and when**. Rules below | 3 lines |
| 7 | **First-contact angle** | Card field 8 (opening angle) | **Verified facts only**; hook → value → small ask; written as a direction, not a finished email | 2–3 sentences |
| 8 | **Evidence** | Evidence store | Every claim used in the briefing, with tag, source and date; a count of verified / inferred / missing | List |
| 9 | **Likely objection** | Objection library (§3) | Top 1–2 objections whose triggers match; each shows its trigger evidence | 2 items |
| 10 | **How to respond** | Objection library | An honest, specific response using only [V] facts about CBS Talks; an alternative offer if the answer is no | 2 items |
| + | **Goal of first contact** | Rules (§4) | One sentence | 1 line |
| + | **Questions to ask** | Rules (§4) | 3–4 discovery questions, chosen to fill the largest unknowns | 4 bullets |
| + | **Don't say** | Rules (§4) | Inferences about them, the estimate, competitor names | 2–3 bullets |
| + | **Before you send: checklist** | System checks | Collision, contact still in role, trigger still fresh, exclusivity, cool-off | Checklist |

### Rules for field 6 (sponsorship level)

- Show the **estimated tier, plausible range and confidence**, always labelled
  *"estimate, not a known budget"*.
- **Map to a package:** propose the CBS Talks package that matches the estimated
  tier (the package list is to be defined by CBS Talks; see financial model §7).
- **When to raise money:**
  - **Financial type is "later":** no money in the first contact. Write "Level: no cash
    ask now; potential est. X after the first collaboration".
  - **Ready, confidence High:** propose the matching package in the first meeting.
  - **Ready, confidence Medium or Low:** ask about their budget process first and
    propose after hearing it.
- **Never** state the estimate to the company. Never present a single DKK number as their budget.

---

## 3. Objection library

Objections are selected by **trigger signals** from the company's data. The
**top two** by match strength are shown. Each response follows the same
pattern: **acknowledge → answer with a verified fact → offer a smaller or
different alternative**.

| ID | Likely objection | Triggered by | Response approach | Facts about CBS Talks needed (must be [V]) |
|---|---|---|---|---|
| OB1 | "We already work with other CBS organisations." | F4 = 100; IR3 (partner of ≥ 3 CBS organisations) | Ask what those partnerships deliver; position the **difference** (format, audience, topic depth), not "more of the same"; offer to complement, e.g. a talk on a topic their other partnerships don't cover | Audience composition by study line; event formats; past partner list |
| OB2 | "We have no budget for this" / "The budget is already set." | F10 ≤ 25; financial estimate level D; contact outside their budget-planning period | Accept it; offer a **non-cash entry** (speaker slot, recruitment pilot); ask **when budget planning happens** and log a follow-up date | Non-cash offerings in the catalog |
| OB3 | "What's the return? How many people, and which profiles?" | F6 ≥ 75 (mature sponsor); Partnerships Manager or Marketing as owner | Give hard numbers from past events; propose **measurable KPIs** (attendance by study line, applications via tracked link, survey results) and a post-event report | Attendance and profile data from past events; a sample post-event report |
| OB4 | "CBS students aren't really our target." | D5 ≤ 50 or `audience` ≤ 1; F8 ≤ 50 | Be specific: name the study lines that match their roles; if it truly doesn't fit, **switch type** (speaker / positioning) or accept and lower the priority | Study-line breakdown of the audience |
| OB5 | "Our executives don't have time to speak." | Speaker type with an L4 speaker at a size-L company | Offer alternatives: a different expert, a 30-minute fireside chat, longer lead time, co-presenting with a junior colleague | Format options; lead times |
| OB6 | "That's decided by our group/regional office." | F3 ≤ 50 | Ask the local contact to **champion** it internally; provide an English one-pager; propose a smaller pilot within local authority | English one-pager |
| OB7 | "We'd want a say in the content and speakers." | Knowledge or content type; any R2 (independence) penalty flag | Explain the **editorial independence policy** clearly: what they can shape (format, case material, their own speaker's talk) and what they can't (speaker selection, conclusions, other speakers). Better to say this early than lose credibility later | Written editorial independence policy |
| OB8 | "Student organisations change every year, so there's no continuity." | Annual strategic or recurring type; past partner with handover problems | Show the **handover process** and named continuity contact; offer a written agreement with fixed deliverables; cite renewal history if it exists | Handover procedure; renewal rate |
| OB9 | "Students already know us; we don't need more visibility." | `brand_gap` = 0; mutual-value cap applied | Don't argue. Switch to *their* agenda (positioning topic) or a niche audience they under-reach. If neither fits, accept it; the score already flagged this | — |
| OB10 | "Bad timing; we're busy / not hiring right now." | O9 = 0 (hiring freeze); O8 = 0; outside recruitment season | Agree a specific follow-up date tied to their cycle; offer a low-effort touchpoint meanwhile (an invitation as guests) | Event calendar |

**If a required CBS Talks fact is missing**, the response is shown with a
warning: *"Response needs: attendance by study line [?]. Collect before the
meeting or don't use this argument."*

---

## 4. Goal, questions and "don't say" rules

**Goal of first contact** (by situation):

| Situation | Goal |
|---|---|
| Warm relationship, financial type ready | A meeting to discuss a concrete package |
| Warm, no financial readiness | A meeting to agree a first collaboration (speaker / pilot) |
| Introduction via champion | A 20–30 minute exploratory call with the target role |
| Formal application route | A complete application **plus** a short call with the programme owner if possible |

**Questions to ask.** The system picks 3–4 questions that would fill the largest
unknowns or low-confidence factors:

| Gap in data | Question |
|---|---|
| Decision process unknown (O2 < 100) | "Who else would usually be involved in a decision like this?" |
| Budget process unknown (F10 UNKNOWN) | "When do you plan next year's student or employer-branding activities?" |
| Saturation / other partners (OB1 triggered) | "What has worked well, or not, in your other student partnerships?" |
| Objective uncertain (D3 Low confidence) | "Which profiles are hardest for you to reach right now?" |
| Success criteria unknown (F6 ≥ 75) | "How would you measure whether a partnership like this worked?" |

**Don't say:**
- Never state our **inferences** about them as facts ("you're unknown among students").
- Never mention the **financial estimate**.
- Never name **other companies** we're talking to, or their terms.
- Don't promise **content control** that conflicts with the independence policy.
- Don't promise **audience numbers** we can't document.

**Before you send: checklist** (checked by the system where possible)

- [ ] **Collision check:** no other open outreach thread with this company by another board member
- [ ] **Contact still in role:** named person verified within 6 months; re-check on LinkedIn
- [ ] **Trigger still fresh:** the trigger used in the angle is under 6 months old
- [ ] **No exclusivity conflict** with a current partner (sponsor types)
- [ ] **Not in cool-off**, not do-not-contact
- [ ] **Facts about us in the angle are documented** (CBS Talks profile)

---

## 5. Briefing template

```
═══════════════════════════════════════════════════════════════════════════════
OUTREACH BRIEFING — <COMPANY>                    generated <date> · expires <date>
Priority <A> · <quadrant> · Confidence <H/M/L> · Owner: <board member>
═══════════════════════════════════════════════════════════════════════════════
GOAL OF FIRST CONTACT   <one sentence>

1  WHY CONTACT THEM      • <reason> [tag]  • <reason> [tag]  • <reason> [tag]
2  WHO                   Entry: <person/role> via <route> · Owner: <role> · Champion: <…>
3  THEIR LIKELY OBJECTIVE • <objective in their terms> [I: based on …]
4  WHAT WE OFFER          Now: <entry offer> · Later: <secondary/target>
5  EVENT / TOPIC          <format>: "<title>" — theme <…> · status <…>
6  SPONSORSHIP LEVEL      Est. <tier> (estimate, not a known budget) · confidence <…>
                          Package: <…> · Raise money: <now / after hearing budget process / later>
7  FIRST-CONTACT ANGLE    <2–3 sentences, verified facts only>
8  EVIDENCE               <n> V · <n> I · <n> ?   (full list below)
9  LIKELY OBJECTIONS      OB<x>: "<…>" — triggered by <evidence>
10 RESPONSES              OB<x>: <acknowledge → fact → alternative>

ASK THEM                  • <q1> • <q2> • <q3>
DON'T SAY                 • <…> • <…>
BEFORE YOU SEND           ☐ collision ☐ contact in role ☐ trigger fresh ☐ exclusivity ☐ facts about us

EVIDENCE LIST             [V] <claim> — <source>, <date>
                          [I] <claim> — rule <IRx> / author
                          [?] <missing item> — affects <field>
═══════════════════════════════════════════════════════════════════════════════
```

---

## 6. Example briefings

All companies, people and facts below are **fictional**. ProServ's ratings are
hypothetical and are not an assessment of any real firm. The CBS Talks facts used
(attendance, past results) are placeholders, marked [V*], and must come from the
real CBS Talks profile once it exists.

### 6.1 ProServ (warm), A = 89, approach now. Annual strategic partner

```
═══════════════════════════════════════════════════════════════════════════════
OUTREACH BRIEFING — PROSERV (hypothetical)       generated 2026-10-05 · expires 2026-11-04
Priority 89 · Q1 Approach now · Confidence High · Owner: J.H.
═══════════════════════════════════════════════════════════════════════════════
GOAL OF FIRST CONTACT   A review meeting with last year's contact and the Head of Employer
                        Branding, ending with agreement to receive an annual proposal.

1  WHY       • Paid partner last year (one event series, 40k DKK); ended well [V — our records]
             • Volume hiring of business graduates; graduate programme [V — careers page, Sep 2026]
             • Published a 2026 report on AI and the future of work, which matches our theme
               "Work after AI" [V — company website]
2  WHO       Entry: last year's Employer Branding Specialist (champion, warm) [V, verified Sep 2026]
             Owner: Head of Employer Branding [I] · Exec sponsor: HR Director, introduced by the owner
3  OBJECTIVE • Keep a steady flow of CBS graduates into their advisory practice [I — talent = 2]
             • Be visibly associated with the AI-and-work debate [I — positioning = 2, report]
4  OFFER     Now: annual partnership, i.e. "Work after AI" series (2 talks) + case workshop
             + recruitment mixer + content series. Later: category exclusivity at renewal
5  EVENT     Talk series: "Work after AI" — their partner on stage with a researcher and a
             union voice (not a solo company talk) · status: our idea, not discussed
6  LEVEL     Est. 20–50k DKK (estimate, not a known budget) · High (paid 40k last year)
             Package: Strategic package [? package list not yet defined]
             Raise money: in the first meeting (ready, High confidence)
             Upside: 50k+ plausible if exclusivity is included
7  ANGLE     Open with last year's results (attendance and applicant feedback) and propose
             turning a one-off series into a year-round partnership around the topic of
             their own 2026 report.
8  EVIDENCE  9 V · 4 I · 2 ?
9  OBJECTIONS OB8 "Student organisations change every year" — annual type; our board changes in May
             OB3 "What did we get last time?" — F6 = 100 (formal sponsorship programme)
10 RESPONSES OB8: Yes, our board changes yearly. Show the handover procedure, name a
             continuity contact, and put deliverables in a written annual agreement.
             OB3: Bring last year's numbers (attendance 180 [V*], 35% from target study lines
             [V*]) and propose tracked KPIs for this year, with a report after each event.
ASK THEM     • How did last year's partnership perform against your own targets?
             • Who besides you would be involved in an annual agreement?
             • When is next year's employer-branding budget set?
DON'T SAY    • The 20–50k estimate · • "Exclusivity" before they raise competition themselves
BEFORE SEND  ☐ collision ☐ champion still in role (verified Sep 2026) ☐ report < 6 months old
             ☐ no exclusivity conflict ☐ last year's numbers documented
═══════════════════════════════════════════════════════════════════════════════
```

### 6.2 ProServ (cold), A = 83.5, build a path. Recruitment pilot

Included because A > 75. Because likelihood is low, **the first contact is the
introducer, not the company**.

```
═══════════════════════════════════════════════════════════════════════════════
OUTREACH BRIEFING — PROSERV, no relationship (hypothetical)
Priority 83.5 · Q2 Build a path · Confidence Medium · Owner: M.S.
═══════════════════════════════════════════════════════════════════════════════
GOAL OF FIRST CONTACT   Step 1: the CBS alumnus at ProServ agrees to introduce us to their
                        campus recruiting team. Step 2: a 20-minute call with the Campus Recruiter.

1  WHY       • Volume hiring of business graduates [V — careers page]
             • Sponsors two other CBS student organisations [V — partner pages, Sep 2026]
             • Strong student relevance across several study lines [V — pulse survey]
2  WHO       Introducer: CBS alumnus (Audit department, not HR) [V — LinkedIn, Sep 2026]
             Target: Campus Recruiter / University Relations [I] · Decision (if paid): Head of TA
             Named person: not yet identified (O2 = 0) → identify first
3  OBJECTIVE • Fill graduate classes with strong candidates from target universities [I — talent = 2]
4  OFFER     Now: one case workshop (recruitment pilot), no fee or a small fee
             Later: event sponsorship; annual partnership as the long-term target
5  EVENT     Case workshop: "Advising a company through an AI rollout" — theme "Work after AI"
             · status: our idea
6  LEVEL     No cash ask now (financial type is "later": no relationship)
             Potential after the pilot: est. 20–50k (estimate) · Medium (pattern evidence)
7  ANGLE     To the alumnus: a short personal note. We're planning a case workshop for CBS
             students on <topic>; would they connect us with whoever runs campus recruitment?
8  EVIDENCE  6 V · 3 I · 3 ?
9  OBJECTIONS OB1 "We already work with other CBS organisations" — sponsors two
             OB10 "Our campus calendar is already planned" — contact in October [I]
10 RESPONSES OB1: Ask what those partnerships cover; offer what they don't (a case format on
             the AI topic, rather than another logo at a fair).
             OB10: Agree to slot into the spring calendar; ask when it gets planned and log the date.
ASK THEM     • Which universities and study lines are you focusing on this year?
             • What has worked well in your other student partnerships?
             • When is the spring campus calendar planned?
DON'T SAY    • Names of the other CBS organisations' deals · • Any money before the pilot
BEFORE SEND  ☐ collision (two other CBS organisations already work with them; check none
             of our members are involved) ☐ alumnus agreed to be named ☐ cool-off: none
═══════════════════════════════════════════════════════════════════════════════
```

### 6.3 Fjord Ventures, A = 64.5, fast-track (Speaker). Short version

```
OUTREACH BRIEFING — FJORD VENTURES (fictional) · Fast-track: Speaker · Owner: A.K.
GOAL         Founder confirms a spring keynote date.
WHY          Founder has two recorded keynotes on fintech regulation [V]; central to our theme [V]
WHO          Founder directly (warm, O1 = 100) [V]
OBJECTIVE    Visibility for the founder's regulatory agenda [I — positioning = 2]
OFFER/EVENT  Keynote + Q&A: "Who should regulate money you can't see?" · our idea
LEVEL        No cash ask: est. < 5k (estimate) · Low. Not a sponsor; value is the speaker
ANGLE        Refer to their recent talk and ask for one evening in March for CBS students.
OBJECTION    OB5 "No time": offer a 30-minute fireside chat with a moderator, booked 3 months ahead
ASK          Could they introduce 1–2 portfolio founders for later events? (networking partner)
```

---

## 7. Generation and review

Generated through the same pipeline as the explainability card: rules select
the content, then templates (or an AI writer under the same validation contract)
phrase it, then the Partnerships Manager approves it.

Additional validation for briefings:
- The angle (field 7) uses only [V] claims.
- Objection responses (field 10) use only [V] facts about CBS Talks, or carry
  the "missing fact" warning.
- Field 6 always carries the estimate label and never a single number.
- All checklist items are evaluated before the status can change to "ready to send".

**Data model:** add `Briefing` (company, generated_at, expires_at, inclusion_rule,
fields{} with claim IDs, objections[] with trigger evidence, checklist results,
status: draft / approved / sent / expired, approved_by), an `ObjectionRule`
table (the §3 library, versioned) and a `CBSTalksProfile` fact list (the facts
objection responses depend on).

**Feedback loop:** after each first contact, the owner logs which objection was
actually raised (one of OB1–OB10, or "other: …"). Each semester, compare predicted
and actual objections. Retire triggers that never fire correctly; add new
objections that keep coming up.

---

## 8. Weaknesses

1. **Briefings are only as good as the CBS Talks profile.** Most good objection
   responses need our own data: attendance, study lines, past results. Until
   that exists, many responses will show "missing fact" warnings. **Collecting
   audience data at every event is the highest-value data task for CBS Talks**,
   ahead of any company research.
2. **The objection library starts as educated guesses.** The ten objections are
   common in sponsorship sales, but they aren't yet validated for CBS Talks. The
   feedback loop (§7) is how they become reliable.
3. **A briefing can make people too confident.** A well-prepared page may tempt
   people to follow it like a script. The questions section is there to keep
   the first conversation about listening.
4. **The 75 threshold is arbitrary.** Track how many briefings per semester it
   produces. If it's more than the team can use (more than about 10–15), raise it; if far
   fewer, lower it or include all "Approach now" companies.
