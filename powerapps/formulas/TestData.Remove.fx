// Partnership Desk · temporary cleanup button · OnSelect
// Removes every "(test)" row added by TestData.Add.fx and TestData.Deals.fx. Run App.OnStart again afterwards.
// Swedish-locale separators: ";" between arguments, ";;" between actions.
RemoveIf(Companies; EndsWith(Title; "(test)"));;
RemoveIf(CommercialEvidence; EndsWith(Title; "(test)"));;
RemoveIf(Contacts; EndsWith(Title; "(test)"));;
RemoveIf(Interactions; EndsWith(Title; "(test)"));;
RemoveIf(Opportunities; EndsWith(Title; "(test)"));;
Notify("Test data removed. Now run App → Run OnStart."; NotificationType.Success)
