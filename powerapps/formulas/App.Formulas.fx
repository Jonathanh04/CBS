// Partnership Desk · App.Formulas (named formulas)
// Rules from docs/lean-spec.md §3. Recalculate automatically when the collections change.
// Swedish-locale separators: ";" between arguments and record fields, ";;" ends each formula.

// ---- Settings (from the Settings list; change values there, not here) ----
FitHigh = Value(LookUp(colSettings; Title = "FitHigh").SettingValue);;
AccessHigh = Value(LookUp(colSettings; Title = "AccessHigh").SettingValue);;
PathCap = Value(LookUp(colSettings; Title = "PathCap").SettingValue);;
RenewalDays = Value(LookUp(colSettings; Title = "RenewalDays").SettingValue);;
NoReplyDays = Value(LookUp(colSettings; Title = "NoReplyDays").SettingValue);;
WarmDays = Value(LookUp(colSettings; Title = "WarmDays").SettingValue);;
TodayDate = Today();;
OpenStages = ["Planned"; "Contacted"; "Meeting"; "Proposal sent"; "Negotiation"];;

// ---- One scored row per company: F4, Fit, Access, quadrant, last contact, open deals ----
Scored = ForAll(
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
                        && InteractionDate >= DateAdd(TodayDate; -WarmDays; TimeUnit.Days)
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
                        fit >= FitHigh && access >= AccessHigh; "Priority";
                        fit >= FitHigh; "Build a Path";
                        access >= AccessHigh; "Quick Win";
                        "Low Priority"
                    );
                    LastContact: Max(Filter(colInteractions; Title = c.Title); InteractionDate);
                    OpenOpps: CountRows(Filter(colOpps; Title = c.Title && Stage in OpenStages))
                }
            )
        )
    )
);;
