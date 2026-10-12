# CBS Talks Partnership Desk — Microsoft 365 team tool plan

**Decision (2026-10-12):** the Partnership Desk becomes a tool the whole CBS Talks team uses,
and it lives **in Microsoft 365 only**. It is maintained by Jonathan this year, with a
handover guide for the next board.

This replaces the earlier plan to run a spreadsheet trial for a semester before
building any app (`lean-spec.md` §8, step 6). The rules of the system (Fit, Access, Commercial
Evidence, evidence labels, work queue) are unchanged and still come from `lean-spec.md`.

---

## 1. Architecture

```
  CBS Talks Team / SharePoint site (owned by the organisation, not a person)
  └── CBS-Talks-Partnerships.xlsx          ← the single source of truth
        tblCompanies, tblOpportunities, tblInteractions, tblContacts,
        tblCommercialEvidence, tblEvidence, tblTeam, tblPackages, tblThemes, tblEvents
        + formulas (Fit, Access, quadrant, flags, work queue, dashboard)

  Partnership Desk (the UI)  ── reads/writes the tables ──►  same workbook
        • Option A (recommended): Excel add-in, opens inside Excel for the web / desktop
        • Option B: Power Apps app on the same tables
        • Option C: standalone web app with Microsoft login (Microsoft Graph)
```

**Why the workbook stays the source of truth:**
- **The data stays in CBS Talks' own Microsoft 365**, not on an outside server, so there's no extra GDPR processor.
- **It still works if the app breaks:** anyone can open the workbook in Excel.
- **It survives board handovers:** the file belongs to the organisation's Team or SharePoint site.

The template already has every data tab as a **named Excel table**, which all three options need.

## 2. The three options

| | **A. Excel add-in** (recommended) | B. Power Apps | C. Web app + Microsoft login |
|---|---|---|---|
| What users see | The Desk in a side panel or full window inside Excel | A Power Apps app (browser, Teams, phone) | A website; sign in with the CBS account |
| Reads/writes data via | Office.js, directly in the open workbook | Excel or SharePoint connector | Microsoft Graph |
| Needs CBS IT? | Usually not, **if** uploading custom add-ins is allowed (check 2) | Depends on Power Apps licences for CBS student accounts (check 3) | Usually **yes**: an app registration and consent in the CBS tenant |
| Reuses the demo's design and rules | Yes, almost all of it | No; rebuilt in Power Fx | Yes |
| Version control (GitHub) | Yes | Poor (exported packages) | Yes |
| Hosting | Static files over HTTPS (e.g. GitHub Pages or Azure Static Web Apps, free tiers) | Microsoft hosts it | Static hosting + app registration |
| Maintenance by next board | Moderate (JavaScript; handover guide) | Low-code, but logic is hidden in the app | Moderate, plus IT dependency |

**Recommendation: Option A.** It needs the fewest permissions, reuses the work already done,
keeps the data in the workbook, and can be version-controlled in this repository. Option B is
the fallback if custom add-ins are blocked but Power Apps works.

These are assumptions about the CBS tenant: I can't see its settings from here. The checks in §3
decide which option is possible.

## 3. Checks to do first (about 15 minutes, with your CBS account)

1. **Shared space:** does CBS Talks have a Team or SharePoint site? Who owns it? It should be
   owned by the organisation or by several board members, never only by one person.
2. **Custom add-ins:** open any workbook in Excel for the web → **Home → Add-ins → More add-ins →
   My add-ins**. Is there an **"Upload My Add-in"** option? (Take a screenshot either way.)
3. **Power Apps:** go to make.powerapps.com with your CBS account. Can you create a blank app?
4. **Hosting:** may this repository be public (it contains no real data, but it does contain
   the CBS Talks logo)? If not, we'll use Azure Static Web Apps instead of GitHub Pages.

## 4. Steps

| Step | What | Done when |
|---|---|---|
| **0. Workbook in M365** (can start now) | Upload `template/CBS-Talks-Partnerships.xlsx` to the CBS Talks Team/SharePoint, open in Excel for the web, check dropdowns, Work Queue and Dashboard calculate | The team can use the sheet directly |
| **1. Read-only Desk** | Add-in shows Today, Matrix, Companies, Pipeline, Dashboard and company pages from the live tables | Same results as the workbook's Work Queue and Dashboard |
| **2. Editing** | Log contact, re-rate Fit, move stage (with required fields), add company/contact/evidence, all written back to the tables | Every action in the demo works on the real file |
| **3. Team rollout** | Hosting, add-in installed for the board (each person uploads the manifest, or IT deploys it centrally), short user guide | Whole board uses it in the weekly meeting |
| **4. Handover** | Maintainer guide: how to update, rebuild and redeploy; who owns what | Next board can run it without Jonathan |
| Optional later | Weekly Teams reminder of follow-ups due (Power Automate) | Only if the team wants it |

## 5. Rules for building it

- **The workbook formulas and the add-in must give the same answers.** The rules in
  `lean-spec.md` are implemented once in the add-in's code. The test suite compares them with
  the workbook's calculated columns on the example data.
- **No real data in this repository.** The add-in reads data only from the user's open workbook.
- **Respect the Excel table structure:** the add-in adds rows and edits cells inside the
  tables; it never renames or removes columns.
