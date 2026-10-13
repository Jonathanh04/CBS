> **Paused (2026-10-13).** The system now runs as the live Partnership Desk on claude.ai
> (`docs/live-app.md`). This plan is kept as an option for moving to Microsoft 365 later.

# CBS Talks Partnership Desk — Microsoft 365 team tool plan

**Decisions:**
- **2026-10-12:** the Partnership Desk becomes a tool the whole CBS Talks team uses, in
  **Microsoft 365 only**. Jonathan maintains it this year and writes a handover guide for the next board.
- **2026-10-12 (after checks):** it is built as a **Power Apps canvas app** with its data in
  **SharePoint lists**.

The rules of the system (Fit, Access, Commercial Evidence, evidence labels, work queue) are
unchanged and still come from [`lean-spec.md`](lean-spec.md).

## Results of the platform checks

| Check | Result | Consequence |
|---|---|---|
| Shared CBS Talks Team/SharePoint | Unknown yet | Needed before the lists are created (step 1) |
| Upload own Excel add-in | "My add-ins" shows only installed and admin-managed add-ins; no "Upload My Add-in" link | Excel add-in route dropped (most likely blocked by CBS) |
| Power Apps with CBS account | Works: a blank canvas app opens in the CBS environment (Swedish UI) | **Chosen route** |
| GitHub visibility | Wanted: private, CBS Talks team only (still public on 2026-10-12) | Owner switches to private and adds teammates as collaborators |

## Architecture

```
CBS Talks Team  (owned by ≥ 2 board members)
└── SharePoint site
     ├── Lists: Companies, Opportunities, Interactions, Contacts, CommercialEvidence,
     │          Evidence, TeamMembers, Packages, Themes, Events, Settings   ← source of truth
     └── Documents: setup file, exports, user guide

Power Apps canvas app "Partnership Desk"  (owner + ≥ 1 co-owner)
     • loads the lists → calculates Fit, Access, quadrant, flags, work queue (lean-spec §3)
     • screens: Today · Matrix · Companies · Company · Pipeline · Dashboard
     • writes every edit back to the lists
     • pinned as a tab in the CBS Talks Team, also usable in the browser and on phones
```

**Why SharePoint lists and not the Excel workbook:**
- **Several people can edit at once safely,** with version history.
- **They're Power Apps' standard data source,** included with Microsoft 365.
- **Excel stays available for reports:** any list can be exported to Excel.

The Excel template in `template/` remains as a stand-alone fallback and as the reference
implementation of the formulas: the app's results must match it on the same example data.

## Steps

| Step | What | Who | Done when |
|---|---|---|---|
| **1. Shared space** | Find out whether CBS Talks has a Team. If not, create "CBS Talks – Partnerships" (Teams → Join or create a team) with at least two board members as owners | Jonathan + board | The team exists and has 2+ owners |
| **2. Lists** | Upload `powerapps/sharepoint-lists-setup.xlsx` to the Team's Files. Create the 11 lists via New → List → From Excel. Delete the example rows and fill in Settings | Jonathan (~30 min) | 11 lists with the right column types |
| **3. App skeleton** | Create the canvas app, connect the 11 lists, add the loading and calculation formulas (provided in `powerapps/`). Check the results against the Excel template on the same example rows | Jonathan pastes, Claude writes the formulas | Fit/Access/quadrant match the template |
| **4. Screens** | Today (work queue), Matrix, Companies, Company page, Pipeline, Dashboard, using the demo's design (CBS Talks navy) | Claude writes formulas and layout instructions, Jonathan builds and tests | Every demo action works on real lists |
| **5. Rollout** | Share the app with the Team, add it as a Teams tab, short user guide, import real partners | Jonathan | Board uses it in the weekly meeting |
| **6. Handover** | Maintainer guide: ownership transfer, co-owners, how to change a rule | Jonathan + Claude | Next board can run it alone |

**How we build it:** I can't open Power Apps from here, so I write every formula and step in
the repository (`powerapps/`), and you paste and test them. Each step has a checkpoint with
expected results, so problems show up immediately. Formulas use the Swedish separators your
Power Apps shows (`;` between arguments, `;;` between actions).

## Rules for building it

- **The app and the Excel template must give the same answers** on the same example data.
- **No real data in the GitHub repository.** Real data lives only in the SharePoint lists.
- **Don't rename list columns' internal names.** The formulas depend on them.
- **Keep the app simple enough** that the next Partnerships Manager can change a threshold in
  the Settings list without touching any formulas.
