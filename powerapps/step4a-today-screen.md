# Step 4a — The Today screen (about 1 hour)

Goal: the weekly work queue from `docs/lean-spec.md` §3.5, in two lists side by side.
- **Left:** renewals → overdue → no reply → due this week → missing next action (deals).
- **Right:** Priority prospects without a deal → paths in progress → quick wins → path candidates (companies).

Swedish Power Apps names in *italics*. **Before pasting anything, check that the property
dropdown at the top left shows the property named in the step.**

## 1. Update OnStart (5 min)

1. Tree view → **App** → property **OnStart**.
2. Replace everything with the contents of [`formulas/App.OnStart.fx`](formulas/App.OnStart.fx).
   It's the same as before, plus deal flags and the two queues at the end.
3. **App → … → Run OnStart.**

✅ **Check:** Variables (`{x}`) → Collections: you now also have **colOppFlags**,
**colQueueDeals**, **colRenewCos** and **colQueueCompanies**.

## 2. Add test deals (2 min)

1. Select **Button1** → property **OnSelect** → replace with the contents of
   [`formulas/TestData.Deals.fx`](formulas/TestData.Deals.fx).
2. **Alt+click** the button **once** ("Test deals added").
3. **App → … → Run OnStart.**

## 3. Create the screen (5 min)

1. **New screen** (*Ny skärm*) → **Blank** (*Tom*).
2. Rename it **TodayScreen**: double-click its name in the Tree view. Don't call it just "Today",
   because Power Apps has a function with that name.
3. Screen property **Fill**: `ColorValue("#F3F4F8")`
4. Make it the start screen: Tree view → **App** → property **StartScreen** → `TodayScreen`

## 4. Header (5 min)

**Insert → Rectangle** (*Rektangel*), then set:

| Property | Value |
|---|---|
| X | `0` |
| Y | `0` |
| Width | `Parent.Width` |
| Height | `64` |
| Fill | `ColorValue("#1B2A53")` |

**Insert → Text label** (*Textetikett*), then set:

| Property | Value |
|---|---|
| Text | `"Today · CBS Talks Partnership Desk"` |
| X / Y | `24` / `12` |
| Width / Height | `800` / `40` |
| Color | `Color.White` |
| Size | `20` |
| FontWeight | `FontWeight.Bold` |

*Optional:* **Insert → Media → Image** (*Bild*), upload `demo/src/cbs-talks-logo.jpg`, and set
X `Parent.Width - 64`, Y `0`, Width `64`, Height `64`.

## 5. The two section titles (5 min)

Insert two **Text labels**:

| | Left title | Right title |
|---|---|---|
| Name | `lblDealsTitle` | `lblCompaniesTitle` |
| Text | `"Renewals and follow-ups  (" & CountRows(colQueueDeals) & ")"` | `"Prospects and paths  (" & CountRows(colQueueCompanies) & ")"` |
| X / Y | `24` / `76` | `Parent.Width / 2 + 8` / `76` |
| Width / Height | `Parent.Width / 2 - 32` / `36` | `Parent.Width / 2 - 32` / `36` |
| Size | `16` | `16` |
| FontWeight | `FontWeight.Semibold` | `FontWeight.Semibold` |
| Color | `ColorValue("#1B2A53")` | `ColorValue("#1B2A53")` |

## 6. Left list: deals (15 min)

1. **Insert → Blank vertical gallery** (*Tomt lodrätt galleri*). If it asks for data, close the question.
2. Rename it **galDeals** and set:

| Property | Value |
|---|---|
| Items | `colQueueDeals` |
| X / Y | `24` / `116` |
| Width | `Parent.Width / 2 - 32` |
| Height | `Parent.Height - 132` |
| TemplateSize | `78` |
| Fill | `Color.White` |

3. Click the **pencil icon** at the top left of the gallery (or click inside its first row). Then
   **Insert → Text label** three times, so the labels land **inside** the gallery. In the Tree view
   they should appear indented under galDeals. Set them as follows:

**Label 1: company** (name it `lblDealCompany`)

| Property | Value |
|---|---|
| Text | `ThisItem.Company & "  ·  " & ThisItem.OppType & "  ·  " & ThisItem.Stage` |
| X / Y | `12` / `8` |
| Width / Height | `Parent.TemplateWidth - 180` / `28` |
| FontWeight | `FontWeight.Semibold` |
| Size | `13` |

**Label 2: what to do** (name it `lblDealNext`)

| Property | Value |
|---|---|
| Text | `If(ThisItem.Flag = "Renewal due"; "Renewal date " & Text(ThisItem.RenewalDate; "d mmm yyyy") & "  ·  satisfaction: " & ThisItem.Satisfaction; Coalesce(ThisItem.NextAction; "Add a next action") & If(IsBlank(ThisItem.Due); ""; "  ·  due " & Text(ThisItem.Due; "d mmm"))) & "  ·  " & ThisItem.Owner` |
| X / Y | `12` / `38` |
| Width / Height | `Parent.TemplateWidth - 180` / `28` |
| Size | `12` |
| Color | `ColorValue("#5B6380")` |

**Label 3: the flag** (name it `lblDealFlag`)

| Property | Value |
|---|---|
| Text | `ThisItem.Flag` |
| X / Y | `Parent.TemplateWidth - 160` / `22` |
| Width / Height | `148` / `30` |
| Align | `Align.Center` |
| FontWeight | `FontWeight.Semibold` |
| Size | `11` |
| Fill | `Switch(ThisItem.Flag; "Overdue"; ColorValue("#F6D8D8"); "No reply"; ColorValue("#F6D8D8"); "Missing next action"; ColorValue("#F6D8D8"); "Due this week"; ColorValue("#FDEBC4"); ColorValue("#E3E8F5"))` |
| Color | `If(ThisItem.Flag in ["Overdue"; "No reply"; "Missing next action"]; ColorValue("#B42F2F"); ColorValue("#131A2E"))` |
| BorderRadius *(if shown)* | `14` |

## 7. Right list: companies (10 min)

The quickest way: select **galDeals** → **Ctrl+C** → **Ctrl+V**. Rename the copy **galCompanies**
and change:

| Property | Value |
|---|---|
| Items | `colQueueCompanies` |
| X | `Parent.Width / 2 + 8` |

Then change the three labels inside it:

| Label | Text |
|---|---|
| first (company) | `ThisItem.Company & "  ·  Fit " & ThisItem.Fit & "  ·  Access " & ThisItem.Access` |
| second (what to do) | `ThisItem.NextStep` |
| third (pill) | `ThisItem.Why` |

For the third label, set **Fill** to
`Switch(ThisItem.Why; "Priority: no deal yet"; ColorValue("#1B2A53"); "Building a path"; ColorValue("#E3E8F5"); ColorValue("#E6F4EE"))`
and **Color** to `If(ThisItem.Why = "Priority: no deal yet"; Color.White; ColorValue("#131A2E"))`.

## 8. ✅ Checkpoint

Press **▷** (Preview). With the test data, the screen should show:

**Left: Renewals and follow-ups**

| # | Company | Flag |
|---|---|---|
| 1 | ProServ (test) · Recurring sponsor · Won | Renewal due (renewal date in 30 days, satisfaction Satisfied) |
| 2 | MegaBrand (test) · Recruitment · Contacted | Overdue (due 3 days ago) |
| 3 | Fjord (test) · Speaker · Meeting | Due this week (in 4 days) |
| 4 | Kobber (test) · In-kind · Proposal sent | Due this week (in 6 days) |

You may also see **Nordlys Logistics (example)**, the example deal from the setup file, as
*Overdue* or *Due this week*, depending on today's date. That's correct.

**Right: Prospects and paths**

| # | Company | Pill |
|---|---|---|
| 1 | Nordlys (test) · Fit 6 · Access 2 | Priority: no deal yet |
| 2 | MegaBrand (test) · Fit 7 · Access 1 | Building a path |

Why these and no others:
- ProServ is Priority but appears as a renewal instead.
- Fjord and Kobber are Quick Wins but already have open deals.
- Gamma is Low Priority, and Vesterled is still in Research.

**If something differs or turns red:** hover over the first red part and send me a screenshot of
the message, or a screenshot of the screen in Preview.

Next step (4b): the company page, opened by tapping a row, with Fit ratings, Access, contacts
and **Log contact**.
