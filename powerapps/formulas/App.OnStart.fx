// Partnership Desk · App.OnStart
// 1) Loads every SharePoint list into a collection.
// 2) Reads the thresholds from the Settings list (with safe defaults).
// 3) Calculates F4, Fit, Access, quadrant, last contact and open deals per company into colScored
//    (rules from docs/lean-spec.md §3).
// Swedish-locale separators: ";" between arguments and record fields, ";;" between actions.
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
);;
Set(gFitHigh; Coalesce(Value(LookUp(colSettings; Title = "FitHigh").SettingValue); 6));;
Set(gAccessHigh; Coalesce(Value(LookUp(colSettings; Title = "AccessHigh").SettingValue); 2));;
Set(gPathCap; Coalesce(Value(LookUp(colSettings; Title = "PathCap").SettingValue); 5));;
Set(gRenewalDays; Coalesce(Value(LookUp(colSettings; Title = "RenewalDays").SettingValue); 90));;
Set(gNoReplyDays; Coalesce(Value(LookUp(colSettings; Title = "NoReplyDays").SettingValue); 10));;
Set(gWarmDays; Coalesce(Value(LookUp(colSettings; Title = "WarmDays").SettingValue); 365));;
ClearCollect(
    colScored;
    ForAll(
        colCompanies As c;
        With(
            {
                ev: Filter(colCE; Title = c.Title);
                live: Filter(colContacts; Company = c.Title && LeftCompany <> "Yes" && DoNotContact <> "Yes")
            };
            With(
                {
                    f4: If(
                        IsEmpty(ev); Blank();
                        !IsEmpty(Filter(ev; EvidenceType = "Previous CBS Talks spend" || EvidenceType = "Sponsors student organisations")); 2;
                        !IsEmpty(Filter(ev; EvidenceType = "Sponsors university activities" || EvidenceType = "Sponsors similar events" || EvidenceType = "Previous CBS Talks partner")); 1;
                        0
                    );
                    access: If(
                        !IsEmpty(Filter(live; Relationship = "Champion"))
                            || !IsEmpty(Filter(colOpps; Title = c.Title && Stage = "Won" && Satisfaction = "Satisfied")); 4;
                        !IsEmpty(Filter(colInteractions; Title = c.Title && Outcome = "Positive"
                            && InteractionDate >= DateAdd(Today(); -gWarmDays; TimeUnit.Days)
                            && Contact in live.Title)); 3;
                        !IsBlank(c.IntroPath); 2;
                        !IsEmpty(Filter(live; !(RoleCategory in ["Executive assistant (routing only)"; "Other"]))); 1;
                        0
                    )
                };
                With(
                    {
                        fit: If(
                            IsBlank(c.F1) || IsBlank(c.F2) || IsBlank(c.F3) || IsBlank(c.F5) || IsBlank(f4); Blank();
                            c.F1 + c.F2 + c.F3 + f4 + c.F5
                        )
                    };
                    {
                        Company: c.Title;
                        Owner: c.Owner;
                        F4: f4;
                        Fit: fit;
                        Access: access;
                        Quadrant: If(
                            c.DoNotContact = "Yes"; "Do not contact";
                            IsBlank(fit); "Research";
                            fit >= gFitHigh && access >= gAccessHigh; "Priority";
                            fit >= gFitHigh; "Build a Path";
                            access >= gAccessHigh; "Quick Win";
                            "Low Priority"
                        );
                        LastContact: Max(Filter(colInteractions; Title = c.Title); InteractionDate);
                        OpenOpps: CountRows(Filter(colOpps; Title = c.Title && Stage in ["Planned"; "Contacted"; "Meeting"; "Proposal sent"; "Negotiation"]))
                    }
                )
            )
        )
    )
)
