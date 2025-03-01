# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName replacewith@email.com

# Check a single user
Get-Mailbox -Identity "replacewith@email.com"
