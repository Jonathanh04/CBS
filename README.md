# CBS
CBS School projects

## CBS Talks Partnership System

A deliberately simple system to help the CBS Talks Partnerships Manager decide
which companies to work on, record why, and keep partnership knowledge across
board handovers.

**Start here:** [`docs/lean-spec.md`](docs/lean-spec.md), the definitive specification. The system runs as the live
Partnership Desk, a private claude.ai page: see [`docs/live-app.md`](docs/live-app.md).

| Document | Purpose |
|---|---|
| [`docs/lean-spec.md`](docs/lean-spec.md) | Model (Fit + Access), priority logic, CRM workflow, fields, schema, dashboard, implementation plan |
| [`docs/live-app.md`](docs/live-app.md) | **The live Partnership Desk**: link, adding data, backups, data shapes |
| [`app/src/partnership-desk.src.html`](app/src/partnership-desk.src.html) | Live page source; build with `python3 tools/build_app.py` |
| [`docs/m365-team-tool.md`](docs/m365-team-tool.md) | Paused plan for a Microsoft 365 version (Power Apps + SharePoint lists) |
| [`docs/powerapps-data-model.md`](docs/powerapps-data-model.md) | SharePoint lists and columns for the Power Apps version |
| [`powerapps/step3-app-skeleton.md`](powerapps/step3-app-skeleton.md) | Step 3: create the app, load the lists, calculate Fit/Access/quadrant, checkpoint |
| [`powerapps/step4a-today-screen.md`](powerapps/step4a-today-screen.md) | Step 4a: the Today screen (weekly work queue: renewals, follow-ups, prospects, paths) |
| [`powerapps/sharepoint-lists-setup.xlsx`](powerapps/sharepoint-lists-setup.xlsx) | File that creates the SharePoint lists (New → List → From Excel) |
| [`docs/cheat-sheets/partnership-type.md`](docs/cheat-sheets/partnership-type.md) | Which partnership type and package to propose |
| [`docs/cheat-sheets/who-to-contact.md`](docs/cheat-sheets/who-to-contact.md) | Which role to contact, by type and company size |
| [`docs/cheat-sheets/conversations-and-outreach.md`](docs/cheat-sheets/conversations-and-outreach.md) | Questions, objections to prepare for, outreach and GDPR rules |
| [`template/CBS-Talks-Partnerships.xlsx`](template/CBS-Talks-Partnerships.xlsx) | **The spreadsheet MVP**: open the 'Start here' tab first (example rows are fictional) |
| [`demo/partnership-desk.html`](demo/partnership-desk.html) | **Clickable demo** of the lean system with CBS Talks branding (fictional data; open in a browser; nothing is saved). Source in `demo/src/` |
| [`tools/build_workbook.py`](tools/build_workbook.py) | Rebuilds the template from the specification (`python3 tools/build_workbook.py`) |
| [`docs/audit.md`](docs/audit.md) | Why the earlier, more complex design was replaced |
| [`docs/archive/`](docs/archive/) | Superseded design documents (background only) |
