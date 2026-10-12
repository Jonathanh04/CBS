// Partnership Desk · App.OnStart
// Loads every SharePoint list into a collection once, when the app starts.
// Swedish-locale separators: ";" between arguments.
Concurrent(
    ClearCollect(colCompanies; Companies);
    ClearCollect(colCE; CommercialEvidence);
    ClearCollect(colContacts; Contacts);
    ClearCollect(colOpps; Opportunities);
    ClearCollect(colInteractions; Interactions);
    ClearCollect(colEvidence; Evidence);
    ClearCollect(colTeam; TeamMembers);
    ClearCollect(colPackages; Packages);
    ClearCollect(colThemes; Themes);
    ClearCollect(colEvents; Events);
    ClearCollect(colSettings; Settings)
)
