# CLAUDE.md

Guidance for Claude (and anyone else) working in this repository.

## What this is

A deliberately simple partnership system for **CBS Talks** (a student organisation at
Copenhagen Business School). It helps the Partnerships Manager decide which companies to
work on each week, record why, and keep partnership knowledge across yearly board handovers.

**Status:** live, no real data yet. **Decision (2026-10-13): the system is the live Partnership
Desk, a private claude.ai page with its own database**, used by the Partnerships Manager.
The user adds data in the page or asks Claude to add it. Page URL, data shapes and backups:
`docs/live-app.md`. The Microsoft 365 plan (Power Apps + SharePoint lists,
`docs/m365-team-tool.md`) is paused and kept as a later option.

## Where things are

| Path | What it is |
|---|---|
| `docs/lean-spec.md` | **The only specification to build from.** Model, rules, CRM workflow, schema, dashboard, plan |
| `docs/live-app.md` | **The live Partnership Desk:** URL, how to add data (page or Claude), data shapes, backups |
| `app/src/partnership-desk.src.html` | Live page source (`__LOGO__` placeholder); `tools/build_app.py` writes `app/partnership-desk.html` |
| `docs/m365-team-tool.md` | Paused Microsoft 365 plan (Power Apps + SharePoint lists) |
| `docs/powerapps-data-model.md` | SharePoint lists and columns for the Power Apps version |
| `powerapps/` | Power Apps build material: list setup workbook, formulas, build guides |
| `tools/build_sharepoint_setup.py` | Generates `powerapps/sharepoint-lists-setup.xlsx` |
| `docs/cheat-sheets/` | One-page guides: partnership type, who to contact, conversations & outreach rules |
| `docs/audit.md` | Why the earlier, complex design was replaced |
| `docs/archive/` | **Superseded.** Background reasoning only: never build from these |
| `template/CBS-Talks-Partnerships.xlsx` | Spreadsheet MVP (generated, do not edit by hand) |
| `tools/build_workbook.py` | Generates the spreadsheet from the spec |
| `demo/partnership-desk.html` | Clickable demo with CBS Talks branding (generated) |
| `demo/src/` | Demo source (`partnership-desk.src.html` with a `__LOGO__` placeholder) and the logo |

## Rules that must not be broken

1. **Two scores only:** Fit (0–10, five criteria rated 0–2) and Access (0–4, derived, never typed in).
   Don't add composite scores, probabilities, or expected values without the user asking.
2. **No budget estimates.** Record only observed Commercial Evidence. The only DKK amounts
   stored are amounts CBS Talks actually received.
3. **Evidence labels:** every researched or AI-drafted claim is *Verified fact*,
   *Source-backed inference* (with source + reasoning) or *Unknown*. AI drafts stay unchecked
   until a person verifies the source.
4. **Guesses become questions.** Never present a company's "likely objective" or "likely
   objection" as fact.
5. **Keep it maintainable by volunteers:** ~15–20 minutes research per company, ~1 minute to
   log a contact. Prefer removing features to adding them.
6. **The spec is the source of truth.** If the logic changes, update `docs/lean-spec.md`
   first, then the live page, the workbook generator and the demo, so they stay consistent.

## Data and privacy

- Example data must be **fictional** and clearly marked "(example)" or "fictional".
- **Never commit real partner data, contact details or amounts** to this repository. Real
  data lives in the live page's database and in backup files in the user's CBS OneDrive.
- Contacts: work data only (published work email or LinkedIn), no guessed emails, no
  personal opinions (GDPR). See `docs/cheat-sheets/conversations-and-outreach.md`.
- The demo and the live page carry the CBS Talks logo: don't publish them anywhere public
  without the user's okay. The live page is private; only the user changes its sharing.

## Commands

```bash
# Rebuild the spreadsheet template (needs openpyxl)
python3 tools/build_workbook.py

# Recalculate and check formulas (needs LibreOffice with Calc); must report 0 errors
python3 <xlsx-skill>/scripts/recalc.py template/CBS-Talks-Partnerships.xlsx 200

# Rebuild the live page, then publish app/partnership-desk.html to the URL in docs/live-app.md
python3 tools/build_app.py

# Rebuild the demo: replace __LOGO__ in demo/src/partnership-desk.src.html with the
# base64 of demo/src/cbs-talks-logo.jpg and write demo/partnership-desk.html
python3 -c "import base64;s=open('demo/src/partnership-desk.src.html').read();b=base64.b64encode(open('demo/src/cbs-talks-logo.jpg','rb').read()).decode();open('demo/partnership-desk.html','w').write(s.replace('__LOGO__',b))"
```

Spreadsheet formulas must stay compatible with Excel, Google Sheets and LibreOffice:
no `FILTER`, `SORT`, `UNIQUE`, `XLOOKUP` or other spilling functions.

## Don't

- Don't add a second data store: the live page's database is the source of truth. Don't rename
  stored fields without updating `docs/live-app.md` and migrating the existing documents.
- When adding data for the user with `ArtifactData`, read first and pin writes with `if_version`;
  never invent companies, contacts or facts, and keep the evidence-label rules.
- Power Apps formulas in `powerapps/` use Swedish-locale separators (`;` between arguments,
  `;;` between actions) because that is how the maintainer's Power Apps is set up.
- The GitHub repository should be private, with access for the CBS Talks team only (it was still
  public on 2026-10-12; the owner changes this in GitHub settings).
- Don't reintroduce ideas from `docs/archive/` without the user asking.
