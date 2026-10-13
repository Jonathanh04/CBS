# The live Partnership Desk

**Decision (2026-10-13):** the Partnership Desk runs as a **private claude.ai page** with its own
database. It replaces the Power Apps / SharePoint plan in `docs/m365-team-tool.md`, which stays in
the repository as a later option. The Partnerships Manager is the only user for now.

- **Page:** https://claude.ai/artifact/LDoz7FzxTEPe1BvbiWvuVg (private: only the owner can open it)
- **Source:** `app/src/partnership-desk.src.html` (a `__LOGO__` placeholder for the logo)
- **Build:** `python3 tools/build_app.py` writes `app/partnership-desk.html`, which is published to
  the same URL. Rules follow `docs/lean-spec.md`, like the demo.

## Adding data

1. **In the page:** Add company, rate Fit (click a number), add commercial evidence, contacts and
   evidence, create deals, log contacts, move deals through the pipeline.
2. **Through Claude:** Claude reads and writes the page's database with the `ArtifactData` tool
   on the URL above. Use the data shapes below, new ids for new documents (`c-…`, `o-…`, `i-…`),
   and the document's current `version` (`if_version`) when changing an existing one.

Real partner data lives **only** in the page's database and in backups, never in this repository.

## Backups

Settings → **Download backup** saves a JSON file of everything. The browser saves it to
Downloads; move it to the CBS OneDrive (or set the browser to ask where to save). Do this monthly
and before every board handover. **Restore from a backup** writes a backup file back into the
page. Deleting the page deletes its database, so the backups are the long-term copy. The JSON
maps onto the SharePoint lists in `docs/powerapps-data-model.md` if CBS Talks moves to
Microsoft 365 later.

## Data shapes

| Collection | Document id | Fields |
|---|---|---|
| `companies` | `c-<random>` (examples: `ex-<name>`) | `name`, `industry` (§5.1), `size`, `owner` (a team name), `website`, `intro` (intro path: Access 2), `need` (specific need), `path` (`{action, started}` or null), `dnc` (bool), `fit` (`{f1, f2, f3, f5}`, each `[rating 0–2 or null, reason, source]`), `fitReviewed`, `commercial` (list of `{k, type, desc, src, amount, year, on, by}`), `contacts` (list of `{k, name, title, role (§5.2), rel: Named/Champion, alumni, email, linkedin, source, verified, left, dnc}`), `evidence` (list of `{k, crit, text, label, src, reasoning, ai, checked}`), `example` |
| `opps` | `o-<random>` | `co` (company id), `type`, `stage`, `owner`, `contact` (contact name), `renewal`, `kind` (Cash/In-kind/Non-cash), `pkg`, `proposed`, `agreed`, `noncash`, `why`, `next`, `due`, `end`, `renewalDate`, `satisfaction`, `satReason`, `lost`, `nurture`, `nurtureUntil`, `closed` |
| `interactions` | `i-<random>` | `date`, `co`, `opp`, `contact`, `by`, `channel`, `dir` (Sent by us / Received from them / Two-way), `summary`, `outcome` |
| `config` | `settings` | `semester` (`{name, start, end, target}`), `packages` (list of `{name, price}`) |
| `config` | `team` | `members` (list of `{name, role, active}`) |

Dates are `yyyy-mm-dd` text. `k` is a short random key for items inside a company's lists.
Fit, F4, Access, quadrants and flags are calculated by the page, never stored.
