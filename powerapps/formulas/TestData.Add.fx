// Partnership Desk · temporary test button (step 3 checkpoint) · OnSelect
// Adds the fictional "(test)" rows to Companies, CommercialEvidence, Contacts and Interactions.
// Click once, then run App.OnStart again. Remove the rows with TestData.Remove.fx afterwards.
// Swedish-locale separators: ";" between arguments and record fields, ";;" between actions.
Collect(
    Companies;
    {Title: "ProServ (test)"; Owner: "A.K. (test)"; F1: 2; F2: 2; F3: 2; F5: 2; PathInProgress: "No"; DoNotContact: "No"};
    {Title: "MegaBrand (test)"; Owner: "A.K. (test)"; F1: 2; F2: 1; F3: 1; F5: 1; PathInProgress: "Yes"; PathAction: "Ask alumni network for an introduction"; PathStartedOn: Date(2026; 10; 3); DoNotContact: "No"};
    {Title: "Nordlys (test)"; Owner: "A.K. (test)"; F1: 1; F2: 1; F3: 2; F5: 2; IntroPath: "Alumnus in their talent team (test)"; PathInProgress: "No"; DoNotContact: "No"};
    {Title: "Fjord (test)"; Owner: "A.K. (test)"; F1: 1; F2: 2; F3: 1; F5: 1; PathInProgress: "No"; DoNotContact: "No"};
    {Title: "Kobber (test)"; Owner: "A.K. (test)"; F1: 0; F2: 0; F3: 1; F5: 1; SpecificNeed: "Venue for an autumn event"; PathInProgress: "No"; DoNotContact: "No"};
    {Title: "Gamma (test)"; Owner: "A.K. (test)"; F1: 0; F2: 0; F3: 0; F5: 0; PathInProgress: "No"; DoNotContact: "No"};
    {Title: "Vesterled (test)"; Owner: "A.K. (test)"; F1: 2; PathInProgress: "No"; DoNotContact: "No"}
);;
Collect(
    CommercialEvidence;
    {Title: "ProServ (test)"; EvidenceType: "Previous CBS Talks spend"; Description: "Paid last year"; AmountDKK: 40000};
    {Title: "MegaBrand (test)"; EvidenceType: "Sponsors student organisations"; Description: "Partner of two CBS organisations"};
    {Title: "Nordlys (test)"; EvidenceType: "None found (checked)"; Description: "Checked partner pages"};
    {Title: "Fjord (test)"; EvidenceType: "None found (checked)"; Description: "Checked partner pages"};
    {Title: "Kobber (test)"; EvidenceType: "Sponsors similar events"; Description: "Hosts local business events"};
    {Title: "Gamma (test)"; EvidenceType: "None found (checked)"; Description: "Checked partner pages"}
);;
Collect(
    Contacts;
    {Title: "Sofie L. (test)"; Company: "ProServ (test)"; RoleCategory: "Employer branding"; Relationship: "Champion"; Source: "Test"; LeftCompany: "No"; DoNotContact: "No"};
    {Title: "Peter N. (test)"; Company: "MegaBrand (test)"; RoleCategory: "University relations"; Relationship: "Named"; Source: "Test"; LeftCompany: "No"; DoNotContact: "No"};
    {Title: "Emil B. (test)"; Company: "Fjord (test)"; RoleCategory: "Founder / CEO (small company)"; Relationship: "Champion"; Source: "Test"; LeftCompany: "No"; DoNotContact: "No"};
    {Title: "Ida K. (test)"; Company: "Kobber (test)"; RoleCategory: "Marketing"; Relationship: "Named"; Source: "Test"; LeftCompany: "No"; DoNotContact: "No"}
);;
Collect(
    Interactions;
    {Title: "Kobber (test)"; InteractionDate: Date(2026; 10; 3); Contact: "Ida K. (test)"; TeamMember: "A.K. (test)"; Channel: "Email"; Direction: "Received from them"; Summary: "Interested in hosting"; Outcome: "Positive"}
);;
Notify("Test data added. Now run App → Run OnStart."; NotificationType.Success)
