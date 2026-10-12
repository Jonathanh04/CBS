# Step 3 — App skeleton (about 1 hour)

Goal: a Power Apps canvas app that loads the 11 SharePoint lists and calculates **Fit, Access and
quadrant** for every company, checked against known answers.

Swedish Power Apps names are given in *italics* where they differ.

## Before you start

- The 11 lists exist with **exactly** these names: Companies, CommercialEvidence, Contacts,
  Opportunities, Interactions, Evidence, TeamMembers, Packages, Themes, Events, Settings.
- Column types are as in the setup file's Read me (numbers for F1–F5, dates for *…On/…Date* columns).
- The **Settings** list has its 11 rows (FitHigh = 6, AccessHigh = 2, …).

> **If the lists are still under "My lists" (personal):** you can do this step anyway. Later,
> when you recreate the lists in the Team site **with the same names**, you only remove the
> old data sources and add the new ones. The formulas stay the same.

## 1. Create the app (5 min)

1. make.powerapps.com → **Create** (*Skapa*) → **Blank app** (*Tom app*) → **Blank canvas app**
   (*Tom arbetsyteapp*) → name it **Partnership Desk**, format **Tablet** (*Surfplatta*) → Create.
2. **Settings** (*Inställningar*, the gear icon) → **General** (*Allmänt*) → **Data row limit**
   (*Gräns för dataraderna*) → set to **2000**. Close settings.
3. Left bar → **Data** (*Data*, the cylinder icon) → **Add data** (*Lägg till data*) → search
   **SharePoint** → choose your connection (your CBS account) → pick the site where the lists
   are. For "My lists", choose the site that appears under your name, or paste its address.
   Tick **all 11 lists** → **Connect** (*Anslut*).

## 2. Load the data and calculate the scores: App.OnStart (10 min)

1. In the **Tree view** (*Trädvy*), click **App**.
2. In the property dropdown at the top left, choose **OnStart**.
3. Delete what's in the formula bar and paste the **whole** contents of
   [`formulas/App.OnStart.fx`](formulas/App.OnStart.fx). It loads the 11 lists, reads the
   thresholds from Settings (with safe defaults), and calculates F4, Fit, Access and quadrant
   per company into the collection **colScored**.
4. Run it: in the Tree view, click **…** next to **App** → **Run OnStart** (*Kör OnStart*).

✅ **Check:** left bar → **Variables** (*Variabler*, the `{x}` icon) → **Collections**
(*Samlingar*): 12 collections, including **colScored** with one row per company.

> An earlier version put the rules in **App → Formulas** (named formulas). That gave an error
> in practice, so the calculation now runs in OnStart, where collections always work. If you
> pasted the old version, clear **App → Formulas** completely.

## 3. Test screen (10 min)

1. **Insert** (*Infoga*) → **Vertical gallery** (*Lodrätt galleri*). If it asks for a data source,
   close that question.
2. With the gallery selected, set its **Items** property to:

```
Sort(colScored; Company)
```

3. Click the **first row's title label** inside the gallery, and set its **Text** property to:

```
ThisItem.Company & "  ·  Fit " & ThisItem.Fit & "  ·  Access " & ThisItem.Access & "  ·  " & ThisItem.Quadrant
```

4. Delete the gallery's other labels (subtitle, body) if they show errors.

## 4. Test data (15 min)

1. Open [`step3-test-data.xlsx`](step3-test-data.xlsx) (fictional rows marked "(test)").
2. For each tab (**Companies, CommercialEvidence, Contacts, Interactions**): open the SharePoint
   list with the same name → **Edit in grid view** (*Redigera i rutnätsvy*) → in Excel, copy the
   data rows (not the header) → click the first empty row in the grid → paste → **Exit grid view**.
3. Back in Power Apps: **App → … → Run OnStart** again to reload the data and recalculate.

## 5. ✅ Checkpoint

The gallery must show exactly this:

| Company | Fit | Access | Quadrant |
|---|---:|---:|---|
| Fjord (test) | 5 | 4 | Quick Win |
| Gamma (test) | 0 | 0 | Low Priority |
| Kobber (test) | 3 | 3 | Quick Win |
| MegaBrand (test) | 7 | 1 | Build a Path |
| Nordlys (test) | 6 | 2 | Priority |
| ProServ (test) | 10 | 4 | Priority |
| Vesterled (test) | *(empty)* | 0 | Research |

These are the same results as the Excel template and the demo for these companies, worked
out from the spec's rules.

**If everything matches:** step 3 is done. Delete the "(test)" rows from the four lists, or keep
them until step 4, and tell me.

**If something differs:** send me a screenshot of the gallery, plus, if possible, the red error
message from the formula bar. The most common causes, so you can check them first:

| Symptom | Likely cause |
|---|---|
| A whole column is empty or errors | A list or column name differs (e.g. `Settings` vs `Setting`, or a column created with a space) |
| Fit empty for every company | F1–F5 were created as text instead of Number, or CommercialEvidence is empty |
| Kobber shows Access 2 or 1, not 3 | InteractionDate isn't a date column, or the Contact name doesn't exactly match the Contacts Title |
| Red underline on `;` or `;;` | Your Power Apps uses English separators after all. Tell me and I'll send the comma version |
