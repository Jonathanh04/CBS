// Partnership Desk · App.OnStart
// 1) Loads every SharePoint list into a collection.
// 2) Reads the thresholds from the Settings list (with safe defaults).
// 3) Calculates F4, Fit, Access, quadrant, last contact and open deals per company into colScored
//    (rules from docs/lean-spec.md §3).
// 4) Flags every deal (renewal due, overdue, no reply, due this week, missing next action)
//    into colOppFlags and builds the work queue (lean-spec §3.4–3.5):
//    colQueueDeals (renewals + follow-ups) and colQueueCompanies (priority, paths, quick wins).
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
                        OpenOpps: CountRows(Filter(colOpps; Title = c.Title && Stage in ["Planned"; "Contacted"; "Meeting"; "Proposal sent"; "Negotiation"]));
                        IntroPath: c.IntroPath;
                        SpecificNeed: c.SpecificNeed;
                        PathInProgress: c.PathInProgress;
                        PathAction: c.PathAction;
                        PathStartedOn: c.PathStartedOn
                    }
                )
            )
        )
    )
);;
ClearCollect(
    colOppFlags;
    ForAll(
        colOpps As o;
        With(
            {
                isOpen: o.Stage in ["Planned"; "Contacted"; "Meeting"; "Proposal sent"; "Negotiation"];
                lastSent: Max(Filter(colInteractions; Title = o.Title && Direction = "Sent by us"); InteractionDate);
                lastReply: Max(Filter(colInteractions; Title = o.Title && Direction <> "Sent by us"); InteractionDate)
            };
            With(
                {
                    flag: If(
                        o.Stage = "Won" && !IsBlank(o.RenewalDate)
                            && o.RenewalDate <= DateAdd(Today(); gRenewalDays; TimeUnit.Days)
                            && IsEmpty(Filter(colOpps; Title = o.Title && IsRenewal = "Yes"
                                && Stage in ["Planned"; "Contacted"; "Meeting"; "Proposal sent"; "Negotiation"])); "Renewal due";
                        !isOpen; "";
                        IsBlank(o.NextAction) || IsBlank(o.NextActionDue); "Missing next action";
                        o.NextActionDue < Today(); "Overdue";
                        o.Stage = "Contacted" && !IsBlank(lastSent)
                            && lastSent <= DateAdd(Today(); -gNoReplyDays; TimeUnit.Days)
                            && (IsBlank(lastReply) || lastReply < lastSent); "No reply";
                        o.NextActionDue <= DateAdd(Today(); 7; TimeUnit.Days); "Due this week";
                        ""
                    )
                };
                {
                    OppID: o.ID;
                    Company: o.Title;
                    OppType: o.OppType;
                    Stage: o.Stage;
                    Owner: o.Owner;
                    NextAction: o.NextAction;
                    Due: o.NextActionDue;
                    RenewalDate: o.RenewalDate;
                    Satisfaction: o.Satisfaction;
                    Flag: flag;
                    Key: Switch(flag; "Renewal due"; 1; "Overdue"; 2; "No reply"; 3; "Due this week"; 4; 5) * 100000
                        + DateDiff(Date(2020; 1; 1); Coalesce(If(flag = "Renewal due"; o.RenewalDate; o.NextActionDue); Date(2099; 12; 31)); TimeUnit.Days)
                }
            )
        )
    )
);;
ClearCollect(colQueueDeals; Sort(Filter(colOppFlags; Flag <> ""); Key));;
ClearCollect(colRenewCos; Filter(colOppFlags; Flag = "Renewal due"));;
ClearCollect(
    colQueueCompanies;
    AddColumns(
        Filter(colScored; Quadrant = "Priority" && OpenOpps = 0 && !(Company in colRenewCos.Company));
        Why; "Priority: no deal yet";
        NextStep; "Plan the first ask (cheat sheet) and create a deal";
        Key; 100000 + (10 - Fit) * 10 + (4 - Access)
    )
);;
Collect(
    colQueueCompanies;
    AddColumns(
        Filter(colScored; PathInProgress = "Yes");
        Why; "Building a path";
        NextStep; Coalesce(PathAction; "Add a path action");
        Key; 200000 + If(IsBlank(PathStartedOn); 0; DateDiff(Date(2020; 1; 1); PathStartedOn; TimeUnit.Days))
    )
);;
Collect(
    colQueueCompanies;
    AddColumns(
        Filter(colScored; Quadrant = "Quick Win" && !IsBlank(SpecificNeed) && OpenOpps = 0);
        Why; "Quick win for a need";
        NextStep; "Need: " & SpecificNeed;
        Key; 300000 + (10 - Fit) * 10 + (4 - Access)
    )
);;
If(
    CountRows(Filter(colScored; PathInProgress = "Yes")) < gPathCap;
    Collect(
        colQueueCompanies;
        AddColumns(
            FirstN(
                Sort(Filter(colScored; Quadrant = "Build a Path" && PathInProgress <> "Yes"); Fit; SortOrder.Descending);
                gPathCap - CountRows(Filter(colScored; PathInProgress = "Yes"))
            );
            Why; "Path candidate";
            NextStep; "Decide whether to start a path";
            Key; 400000 + (10 - Fit) * 10
        )
    )
)
