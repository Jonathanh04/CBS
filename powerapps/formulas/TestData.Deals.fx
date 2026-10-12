// Partnership Desk · temporary test button (step 4a) · OnSelect
// Adds fictional "(test)" deals and contact-log rows so the Today screen has something to show.
// Dates are relative to today, so the flags work whenever you run it. Click once, then run OnStart.
// Swedish-locale separators: ";" between arguments and record fields, ";;" between actions.
Collect(
    Opportunities;
    {Title: "ProServ (test)"; OppType: "Recurring sponsor"; Stage: "Won"; Owner: "A.K. (test)"; Contact: "Sofie L. (test)"; IsRenewal: "No"; ValueKind: "Cash"; ProposedDKK: 40000; AgreedDKK: 40000; RenewalDate: DateAdd(Today(); 30; TimeUnit.Days); Satisfaction: "Satisfied"; ClosedOn: DateAdd(Today(); -300; TimeUnit.Days)};
    {Title: "MegaBrand (test)"; OppType: "Recruitment"; Stage: "Contacted"; Owner: "A.K. (test)"; Contact: "Peter N. (test)"; IsRenewal: "No"; ValueKind: "Cash"; NextAction: "Second follow-up email"; NextActionDue: DateAdd(Today(); -3; TimeUnit.Days); Satisfaction: "Unknown"};
    {Title: "Fjord (test)"; OppType: "Speaker"; Stage: "Meeting"; Owner: "A.K. (test)"; Contact: "Emil B. (test)"; IsRenewal: "No"; ValueKind: "Non-cash"; NonCashDescription: "1 keynote"; NextAction: "Meeting: confirm keynote date"; NextActionDue: DateAdd(Today(); 4; TimeUnit.Days); Satisfaction: "Unknown"};
    {Title: "Kobber (test)"; OppType: "In-kind"; Stage: "Proposal sent"; Owner: "A.K. (test)"; Contact: "Ida K. (test)"; IsRenewal: "No"; ValueKind: "In-kind"; NonCashDescription: "Venue and catering, one evening"; NextAction: "Check venue availability"; NextActionDue: DateAdd(Today(); 6; TimeUnit.Days); Satisfaction: "Unknown"}
);;
Collect(
    Interactions;
    {Title: "MegaBrand (test)"; InteractionDate: DateAdd(Today(); -17; TimeUnit.Days); Contact: "Peter N. (test)"; TeamMember: "A.K. (test)"; Channel: "Email"; Direction: "Sent by us"; Summary: "First email about a recruitment event"; Outcome: "No reply"};
    {Title: "MegaBrand (test)"; InteractionDate: DateAdd(Today(); -12; TimeUnit.Days); Contact: "Peter N. (test)"; TeamMember: "A.K. (test)"; Channel: "Email"; Direction: "Sent by us"; Summary: "Follow-up email"; Outcome: "No reply"}
);;
Notify("Test deals added. Now run App → Run OnStart."; NotificationType.Success)
