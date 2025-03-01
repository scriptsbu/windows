# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName alberto.santiago.1@torc.ai

# Check a single user
Get-Mailbox -Identity "alberto.santiago@torc.ai"
