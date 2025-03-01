# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName replacewith@email.com

# Import the CSV file
$users = Import-Csv -Path "C:\Users\path\to\file"

# Loop through each user and check for mailbox
foreach ($user in $users) {
    $mailbox = Get-Mailbox -Identity $user.UserPrincipalName -ErrorAction SilentlyContinue
    if ($mailbox) {
        Write-Output "$($user.UserPrincipalName) has a mailbox."
    } else {
        Write-Output "$($user.UserPrincipalName) does not have a mailbox."
    }
}

# Disconnect from Exchange Online
Disconnect-ExchangeOnline -Confirm:$false
