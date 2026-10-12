# CLAUDE.md

Guidance for Claude (and anyone else) working in this repository.

## What this is

A deliberately simple partnership system for **CBS Talks** (a student organisation at
Copenhagen Business School). It helps the Partnerships Manager decide which companies to
work on each week, record why, and keep partnership knowledge across yearly board handovers.

**Status:** designed, not yet in real use. A spreadsheet MVP is waiting for real CBS Talks
data (packages, themes, events, past partners). Next step is the back-test and a
one-semester trial, see `docs/lean-spec.md` §8.

## Where things are

| Path | What it is |
|---|---|
| `docs/lean-spec.md` | **The only specification to build from.** Model, rules, CRM workflow, schema, dashboard, plan |
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
   first, then the workbook generator and the demo, so all three stay consistent.

## Data and privacy

- Example data must be **fictional** and clearly marked "(example)" or "fictional".
- **Never commit real partner data, contact details or amounts** to this repository. Real
  data lives in the CBS Talks shared drive.
- Contacts: work data only (published work email or LinkedIn), no guessed emails, no
  personal opinions (GDPR). See `docs/cheat-sheets/conversations-and-outreach.md`.
- The demo carries the CBS Talks logo: don't publish it anywhere public without the user's okay.

## Commands

```bash
# Rebuild the spreadsheet template (needs openpyxl)
python3 tools/build_workbook.py

# Recalculate and check formulas (needs LibreOffice with Calc); must report 0 errors
python3 <xlsx-skill>/scripts/recalc.py template/CBS-Talks-Partnerships.xlsx 200

# Rebuild the demo: replace __LOGO__ in demo/src/partnership-desk.src.html with the
# base64 of demo/src/cbs-talks-logo.jpg and write demo/partnership-desk.html
python3 -c "import base64;s=open('demo/src/partnership-desk.src.html').read();b=base64.b64encode(open('demo/src/cbs-talks-logo.jpg','rb').read()).decode();open('demo/partnership-desk.html','w').write(s.replace('__LOGO__',b))"
```

Spreadsheet formulas must stay compatible with Excel, Google Sheets and LibreOffice:
no `FILTER`, `SORT`, `UNIQUE`, `XLOOKUP` or other spilling functions.

## Don't

- Don't build a custom application before the one-semester spreadsheet trial (spec §8, step 6).
- Don't reintroduce ideas from `docs/archive/` without the user asking.
