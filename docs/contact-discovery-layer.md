# CBS Talks — Contact Discovery Layer

**v1.0 (2026-10-05).** Builds on
[`recommendation-engine.md`](recommendation-engine.md) (partnership types),
[`outreach-likelihood-and-matrix.md`](outreach-likelihood-and-matrix.md) (O1
relationship, O2 decision maker, O3 CBS connections) and
[`financial-potential-model.md`](financial-potential-model.md) (ask size, F3
budget authority, F6 maturity).

For each high-priority company, this layer produces a **Contact Plan**:
- which **role** to contact first;
- who **decides**;
- who could **champion** us internally;
- **how** to reach them;
- **which roles to avoid**;
- **why**.

**Scope:** companies in **Q1** and **Q2** of the matrix, plus any company with a
**fast-track** or **narrow-opportunity** recommendation from the engine.
Everyone else gets no contact plan, since outreach time isn't going to them.

---

## 0. Design decisions and critique

1. **"The person to contact" is really three or four people.** Partnerships
   are rarely decided by the person you email first. The plan separates:
   - **Entry contact:** who we write to first.
   - **Owner / decision role:** who owns the budget or the decision.
   - **Champion:** someone inside who benefits and will push for it. Often a CBS alumnus.
   - **Executive sponsor:** a senior sign-off, *only* for large or annual deals.

   Writing to the decision maker cold is often worse than reaching them through an
   internal champion.
2. **The right role depends on company size, not just partnership type.** In a
   20-person startup the founder handles everything. In a 300-person company
   one HR manager covers recruitment *and* employer branding. In a 5,000-person
   group there is a dedicated university-relations team. The mapping is
   **type × size**.
3. **Match seniority to the size of the ask; don't aim for the top.** A CEO
   who receives a request for a 10,000 DKK event forwards it down, with
   less context than if we'd written to the right person, or ignores it. Aiming
   too high is the most common mistake in student-organisation outreach.
4. **Your role list is missing three roles that matter.**
   - **Events / Sales Manager:** owns venue availability, which is what in-kind venue partnerships need.
   - **CSR / Sustainability Manager:** often owns community-engagement budgets.
   - **Executive Assistant / Chief of Staff:** handles speaking requests for senior
     executives. A routing role, not a decision role.
5. **A warm path beats the right title.** If we already know *anyone* at the
   company, the first step is asking them to introduce us to the target role,
   even if their own role is irrelevant.
6. **Formal processes beat cold emails.** Companies with a formal sponsorship
   programme (F6 ≥ 75) often have an application route. Going around it
   annoys the owner. The plan uses the official route when one exists.
7. **The system recommends a *role*; a person finds the *name*.** No automatic
   scraping of personal data. Names are looked up by hand, recorded with a source and
   date, and handled under GDPR rules (§7).

---

## 1. Role catalogue

Roles are grouped by **seniority level**:
- **L1:** specialist or coordinator
- **L2:** manager
- **L3:** head or director of a function
- **L4:** executive (C-level, country manager, founder of a small company)

| Role | Level | Typically owns | Cares about (their success measures) | Best for | Title variants to search (EN / DA) |
|---|---|---|---|---|---|
| **Campus Recruiter** | L1–L2 | The campus calendar, career fairs, student events | Applicant numbers and quality from target universities | Recruitment partner; delivery of recruitment events | Campus Recruiter, Graduate Recruiter, Early Careers Specialist / Rekrutteringskonsulent, Studenterrekruttering |
| **University Relations Manager** | L2 | Relationships with universities and student organisations; often a small budget | Presence at target universities, partner quality | Recruitment partner; recurring sponsor (student-focused) | University Relations, Campus Relations, Early Careers Manager |
| **Talent Acquisition Manager** | L2 | Recruitment process; graduate programmes in mid-size firms | Time-to-hire, quality of hire | Recruitment partner (mid-size) | Talent Acquisition Manager, Recruitment Manager / Rekrutteringschef |
| **Head of Employer Branding** | L3 | Employer-brand budget; student-facing campaigns and sponsorships | Brand awareness among target talent; employer rankings | One-off/recurring sponsor; annual strategic (owner); content partner (employer-brand content) | Head of Employer Branding, Talent Attraction Lead, Employer Brand Manager / Employer Branding-ansvarlig |
| **Marketing Manager** | L2–L3 | Marketing budget, events, brand visibility | Brand reach, leads, campaign results | One-off sponsor (brand motive); in-kind (products); content partner | Marketing Manager, Brand Manager / Marketingchef |
| **Partnerships / Sponsorship Manager** | L2–L3 | A formal sponsorship programme and its budget | Return on sponsorships, portfolio fit | Any financial type **when a formal programme exists** (F6 ≥ 75) | Partnerships Manager, Sponsorship Manager / Sponsoransvarlig |
| **Communications Director** | L3 | Corporate messaging, executive visibility, media | Reputation, share of voice on strategic topics | Knowledge partner; content partner; speaker routing at large firms | Head of Communications, Communications Director / Kommunikationschef, Kommunikationsdirektør |
| **CSR / Sustainability Manager** *(added)* | L2–L3 | Community-engagement and impact budgets | Impact stories, ESG reporting | Sponsorship with a social/impact angle; knowledge partner on sustainability | CSR Manager, Sustainability Lead, Head of Impact / Bæredygtighedschef |
| **Events / Sales Manager** *(added)* | L2 | Venue availability, catering, event bookings | Utilisation, revenue | **In-kind partner (venue, catering)** | Events Manager, Sales & Events Manager, Conference Manager / Eventchef |
| **Executive Assistant / Chief of Staff** *(added, routing only)* | L1–L2 | The executive's calendar and speaking requests | Protecting the executive's time | **Routing** speaker requests to senior executives | Executive Assistant, Chief of Staff / Direktionsassistent |
| **Country Manager** | L4 | The Danish entity: budget and priorities | Local business results | Executive sponsor for annual strategic; entry role **only** in companies with < 50 DK employees or with a warm relationship | Country Manager, Managing Director / Administrerende direktør, Landechef |
| **CEO / Founder** | L4 | Everything (small companies); strategy (large) | Company growth; their own public profile | **Small companies** (all types); speaker when they *are* the speaker | CEO, Founder, Co-founder / Adm. direktør, Stifter |
| **Relevant senior executive / subject-matter expert** | L3–L4 | A business area or expertise | Visibility for their topic; thought leadership | **Speaker partner**; knowledge partner | Varies: the person identified in the D4 speaker record |

---

## 2. Mapping: partnership type × company size

**Size segments** (from Financial factor F1):
- **S:** < 50 employees in Denmark
- **M:** 50–999
- **L:** 1,000+

Each cell shows **Entry → Owner/Decision** (+ Champion where important).

| Partnership type | S (< 50) | M (50–999) | L (1,000+) |
|---|---|---|---|
| **Recruitment partner** | Founder (or first HR hire) → same | **Talent Acquisition Manager** → HR Director (if paid) | **Campus Recruiter / University Relations Manager** → Head of Talent Acquisition or Employer Branding (if paid) |
| **One-off event sponsor** | Founder → same | **Motive decides:** brand gap/talent → HR or Employer Branding; positioning → Marketing Manager → head of that function | **Head of Employer Branding** (student motive) or **Marketing Manager** (brand motive); **Partnerships Manager** if a formal programme exists |
| **Recurring event sponsor** | Founder → same | Same entry as one-off → **head of function** (budget owner, because recurring means a budget line) | Head of Employer Branding / Partnerships Manager → same, plus their manager's approval |
| **Annual strategic partner** | (rarely eligible) | Existing champion → **HR Director or Marketing Director** + **Country Manager** as executive sponsor | Existing champion → **Head of Employer Branding / Partnerships Manager** (owner) + **executive sponsor** (HR Director, Comms Director or Country Manager), introduced *by the owner* |
| **Speaker partner** | **Founder directly** (often they are the speaker) | **The executive directly** if warm or active on LinkedIn; otherwise via **Communications** | Via **Communications** or **Executive Assistant**; directly only with a warm path |
| **Knowledge partner** | Founder → same | **Subject-matter expert** (e.g. head of insights, chief economist) → Communications (for the use of data or the brand) | **Subject-matter expert** → **Communications Director** |
| **Content partner** | Founder → same | **Marketing / Communications Manager** → same | **Communications** or **Employer Branding** (if employer-brand content) → Head of Communications |
| **Networking partner** | Founder / Partner → same | **Community / Partnerships Manager** → same | **Community / Ecosystem Manager** (VC: platform team; association: member relations) |
| **In-kind partner** | Founder → same | **Events / Sales Manager** (venue) or **Marketing Manager** (products) → General Manager | **Events / Sales Manager** → venue or general manager (free use of space costs them revenue) |

These match your examples: recruitment → campus / talent acquisition;
thought leadership → communications / marketing / senior executive;
sponsorship → marketing / employer branding / partnerships; speaker → the
relevant executive or expert. Size then decides which variant applies.

---

## 3. Selection rules

Applied in order for the engine's **primary** partnership type. Each secondary type
gets its own entry role only if it differs.

| # | Rule | Effect |
|---|---|---|
| R1 | **Do-not-contact / cool-off** (OLS caps) | No contact plan, or "wait until <date>" |
| R2 | **Warm-path override:** any Person at the company with warmth ≥ 50 (O1) | **Entry contact = that person** (as introducer or champion), whatever their role. The target role is still calculated, and the plan says "Ask <person> to introduce us to <target role>" |
| R3 | **Official channel:** F6 ≥ 75 **and** a public application route [V] **and** the type is financial | Entry = the **application route + the Partnerships Manager** named there. Don't go around it |
| R4 | **Type × size mapping** (§2) | Gives the target and owner roles |
| R5 | **Motive adjustment:** use the company's strongest need flag (talent / brand_gap / positioning / audience) | Picks between alternatives in a cell. Talent → HR roles; brand gap → Employer Branding; positioning → Communications / Marketing |
| R6 | **Seniority matching** to the ask (estimated tier) | < 10k: entry L1–L2. 10–50k: entry L2, decision L3. 50k+ or annual strategic: owner L3 **plus** an L4 executive sponsor, never L4 alone |
| R7 | **Seniority ceiling:** no L4 as *entry* contact **unless** the company is size S, **or** the L4 is the proposed speaker, **or** O1 ≥ 50 with that L4 | Prevents "just email the CEO" |
| R8 | **Budget authority abroad** (F3 ≤ 50) | Entry stays local (Danish HR or Employer Branding). The plan notes "decision likely in <region>; ask the local contact to champion internally" |
| R9 | **Multi-threading:** annual strategic and recurring types | At least **two** named contacts (owner + champion or executive sponsor) before the proposal goes out |
| R10 | **Fallback chain** if the role can't be found | Campus Recruiter → University Relations → TA Manager → HR Manager → HR Director. Employer Branding → Marketing → Communications. **Never a generic info@ inbox** unless the company is size S |

Every role recommendation is tagged **[I]**, because it's an inference from
rules. A **named person** is **[V]** only with a source and verification date.

---

## 4. The Contact Plan (output)

```
CONTACT PLAN — <company>                          for: <partnership type> (<commitment>)
──────────────────────────────────────────────────────────────────────────────
TARGET ROLE      <role> (<level>)                                         [I: rules]
  Why:           1. Owns: <what they own that matches the ask>
                 2. Level fits the ask: <ask size> → <level>
                 3. Motive: <their success measure ↔ what we offer>
DECISION ROLE    <role>, if different, + why
CHAMPION         <named person or role> — why they'd push for us
EXEC SPONSOR     <only for annual strategic / 50k+>
ENTRY ROUTE      warm intro via <person> / application route / direct email / LinkedIn message
BACKUP ROLE      <next in fallback chain>
AVOID            <role> — <why contacting them would hurt>
FIND THEM        Search titles: <EN / DA variants> · Where: LinkedIn, team page, career-fair lists
NAMED PERSON     <name, title> [V — source, verified <date>] · Responsibility: confirmed / assumed
                 (or "not yet identified" — O2 = 0)
──────────────────────────────────────────────────────────────────────────────
```

The plan **feeds O2** (Identifiable decision maker) in the Outreach Likelihood Score:
- no role identified → 0;
- role known → 25;
- named person → 50;
- named person with a contact route → 75;
- confirmed responsibility → 100.

Finding the right person therefore raises the likelihood score directly.

---

## 5. Worked examples (fictional companies and people)

### 5.1 ProServ (warm), Annual strategic partner · size L · past partner

```
TARGET ROLE      Head of Employer Branding (L3) — owner                      [I]
  Why:           1. Owns the student-facing employer-brand budget and the CBS relationship
                 2. Annual strategic (est. 20–50k) → L3 owner + L4 sponsor (R6)
                 3. Their success measure is student awareness and applicants, which is our audience
CHAMPION         Our contact from last year's partnership, Employer Branding Specialist   [V]
EXEC SPONSOR     HR Director — introduced by the Head of Employer Branding, not contacted cold
ENTRY ROUTE      Warm: last year's contact (R2) → set up a review meeting with the Head of EB
COMPONENT ROLES  Recruitment: University Relations Manager (delivers the events)
                 Speaker: proposed partner via Communications (R7: no cold L4 request)
AVOID            Country Managing Partner as first contact — an annual deal at this size
                 is owned by Employer Branding; going over their head damages the champion
```

### 5.2 ProServ (cold), Recruitment partner pilot · size L · no contacts

```
TARGET ROLE      Campus Recruiter / University Relations Manager (L2)       [I]
  Why:           1. Owns the campus calendar and runs case workshops at universities
                 2. Pilot event (est. < 20k) → L2 entry (R6)
                 3. Measured on applicants from target universities; CBS is one
DECISION ROLE    Head of Talent Acquisition, only if the pilot is paid
ENTRY ROUTE      CBS alumnus at the firm (works in Audit, not HR) → ask for an
                 introduction (R2 not met: warmth < 50; use as introducer only if they agree)
BACKUP ROLE      Talent Acquisition Manager
AVOID            Marketing — graduate recruitment isn't their remit; the request
                 would be forwarded or lost
FIND THEM        "Campus", "Early Careers", "University Relations", "Studenterrekruttering"
NAMED PERSON     Not yet identified (O2 = 0) → OLS capped at 60. Identifying them is
                 the single largest likelihood lever (+15)
```

### 5.3 Nordlys Logistics, Recruitment partner pilot · size M · alumnus in their talent team

```
TARGET ROLE      Talent Acquisition Manager (L2)                            [I]
  Why:           1. In a mid-size company, TA runs the graduate programme and campus activity
                 2. Case workshop pilot (est. 5–10k) → L2 (R6)
                 3. Measured on filling ~20 business-graduate roles a year [V]; we offer direct access
DECISION ROLE    HR Director — only if the pilot carries a fee
CHAMPION         CBS alumnus in the talent team, known to board member A.K.   [V]
ENTRY ROUTE      Warm: A.K. → alumnus → introduction to the TA Manager (R2)
AVOID            Marketing Manager — Nordlys has no dedicated employer-branding role,
                 and marketing focuses on customers [I]; recruitment requests would stall
                 CEO — far above the size of this ask (R7)
```

### 5.4 Fjord Ventures, Speaker partner · size S · warm founder

```
TARGET ROLE      CEO / Founder (L4)                                         [I]
  Why:           1. The founder *is* the proposed speaker (D4 Person record)
                 2. Size S: the founder decides everything (R7 exception)
                 3. Positioning need = 2: they want visibility on fintech regulation [V]
ENTRY ROUTE      Direct: existing warm relationship (O1 = 100)
SECONDARY        Networking partner → same person; ask for introductions to portfolio founders
AVOID            —
```

### 5.5 Kobber Hotels, In-kind partner (venue) · size M · narrow opportunity

```
TARGET ROLE      Events / Sales Manager (L2)                                [I]
  Why:           1. Owns venue availability and event bookings
                 2. In-kind, no cash → L2 (R6)
                 3. Measured on utilisation, so suggest off-peak dates (weekday evenings
                    in low season) when free use costs them least
DECISION ROLE    Hotel General Manager — free use of a revenue-generating room needs their approval
CHAMPION         Marketing Manager (existing warm contact, O1 = 75)          [V]
ENTRY ROUTE      Warm: Marketing Manager → introduction to the Events Manager (R2)
AVOID            Group-level executives — a local venue decision; escalating makes it bigger than it is
```

---

## 6. Process

| Step | Who | When | Time |
|---|---|---|---|
| Contact plan generated (roles, routes, avoid) | System | When a company enters Q1/Q2, or gets a fast-track or narrow opportunity | — |
| Find the named person (titles, LinkedIn, team pages) | Company owner (board member) | Within 1 week of entering Q1; during the semester for Q2 | ~10 min |
| Verify responsibility (job description, a post about their role, or ask the introducer) | Company owner | Before first contact | ~5 min |
| **Re-verify before each outreach** if verified more than 6 months ago | Company owner | Before each contact | ~2 min |
| Log every contact attempt and reply (feeds O1 and the unanswered cap) | Whoever made contact | Same day | — |

**Contact-person turnover is a real risk.** People change jobs often, and
CBS Talks' board changes every year. When a champion leaves, the system flags the
company ("champion left, relationship at risk") and asks for a new contact
plan. Multi-threading (R9) exists for exactly this reason.

---

## 7. Data protection and outreach rules

This layer handles **personal data**, so these rules are part of the design,
not an afterthought:

- **Lawful basis:** document a *legitimate interest* assessment for storing
  business contact data of professionals for partnership outreach. Store only
  work-related data: name, title, company, work email, LinkedIn URL, source,
  date. No private phone numbers, private emails or personal opinions.
- **No scraping and no automatic enrichment** of personal data. Look up by hand and record the source.
- **Transparency:** the first message says where we found the person
  ("I found you through LinkedIn / was introduced by…") and offers an easy opt-out.
- **Objections:** "please don't contact me" → immediately set `do_not_contact`
  for that person (and the company, if they say so).
- **Retention:** delete Person records with no interaction for 24 months, and
  delete people who have left the company once the handover is done.
- **Email addresses:**
  - Use published addresses, introductions or LinkedIn messages.
  - **Don't guess addresses** (firstname.lastname@).
  - Send personal one-to-one messages only, never mass mailings.
- **To verify with CBS / legal:** how Danish rules on unsolicited electronic
  marketing apply to sponsorship requests from a student organisation. I'm not
  in a position to give a legal conclusion. The warm-introduction-first design
  reduces the exposure either way.

---

## 8. Data model changes

| Entity | Fields added |
|---|---|
| **Person** | `role_category` (from the §1 catalogue), `seniority_level` (L1–L4), `responsibility_confirmed` (bool + evidence), `verified_at`, `source`, `contact_route` (intro / application / published email / LinkedIn), `do_not_contact`, `left_company_at` |
| **ContactPlan** | `company_id`, `partnership_type`, `target_role`, `decision_role`, `champion_person_id`, `exec_sponsor_role`, `entry_route`, `backup_role`, `avoid[]` (role + reason), `named_person_id`, `rules_fired[]`, `status` (draft / in use / outdated), `created_at` |
| **Explainability card** | Field 8 ("Opening angle"): the *Path* line now comes from the Contact Plan (entry route + target role) |
| **Outreach Likelihood** | O2 is derived from the ContactPlan + Person status (§4) |

---

## 9. Weaknesses

1. **Titles are inconsistent.** "Talent Attraction Partner" may own employer
   branding in one company and do admin in another. That's why the plan
   distinguishes *confirmed* from *assumed* responsibility, and why O2 = 100
   needs confirmation.
2. **The size mapping is a simplification.** Some 800-person companies have
   full university-relations teams; some 2,000-person companies have a single
   HR generalist. The motive adjustment (R5) and what is actually found during
   research should override the mapping. Record the actual structure on the Company.
3. **The real decision process is invisible from outside.** Budget may sit with a
   different team than the title suggests. The first conversation should
   always include "who else would be involved in a decision like this?", and the
   answer should update the plan.
4. **Warm-path override can route through weak introducers.** An introduction
   from someone with no standing may hurt more than a well-written direct
   message. The owner can override R2 with a reason.
5. **Research time.** About 15 minutes per company is manageable for 20–30
   Q1/Q2 companies a semester. It isn't for the full long list, which is why
   the layer is limited to high-priority companies.
