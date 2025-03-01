# Install the AzureAD module if not already installed
if (-not (Get-Module -ListAvailable -Name AzureAD)) {
    Install-Module -Name AzureAD -Force -Scope CurrentUser
}

# Connect to AzureAD
Connect-AzureAD

# Define the list of products with updated SKU names
$products = @(
    "AAD_PREMIUM",  # Azure Active Directory Premium P1
    "EXCHANGESTANDARD",  # Exchange Online (Plan 1)
    "O365_BUSINESS_PREMIUM",  # Microsoft 365 Business Premium
    "SPE_E3",  # Microsoft 365 E3
    "SPE_E5",  # Microsoft 365 E5
    "Microsoft Business Center",
    "ATP_ENTERPRISE",  # Microsoft Defender for Office 365 (Plan 1)
    "POWERAPPS_DEV",  # Microsoft Power Apps for Developer
    "FLOW_FREE",  # Microsoft Power Automate Free
    "POWER_BI_PRO",  # Power BI Pro
    "PROJECT_PLAN3_DEPT",  # Project Plan 3
    "Visio Plan 2"
)

# Main loop
while ($true) {
    Clear-Host
    Write-Host "Select a product to export users with that license:"
    for ($i = 0; $i -lt $products.Count; $i++) {
        Write-Host "$($i + 1): $($products[$i])"
    }
    Write-Host "0: Exit"
    
    $selection = Read-Host "Enter your choice (1-$($products.Count))"

    if ($selection -eq "0") {
        break
    }

    # Validate selection
    if ($selection -match '^[1-9][0-9]*$' -and $selection -le $products.Count) {
        $selectedProduct = $products[$selection - 1]
        Write-Host "You selected: $selectedProduct"

        # Get and display all available SKUs
        $availableSkus = Get-AzureADSubscribedSku | Select-Object SkuPartNumber, SkuId
        Write-Host "Available SKUs:"
        $availableSkus | ForEach-Object { Write-Host "$($_.SkuPartNumber) - $($_.SkuId)" }

        # Get SKU for the selected product
        $sku = $availableSkus | Where-Object { $_.SkuPartNumber -eq $selectedProduct }

        if ($sku) {
            Write-Host ("SKU found for {0}: {1}" -f $selectedProduct, $sku.SkuId)
            $usersWithLicense = Get-AzureADUser -All $true | Where-Object {
                $_.AssignedLicenses -match $sku.SkuId
            }

            if ($usersWithLicense) {
                $exportPath = "C:\${selectedProduct}_users.csv"
                $usersWithLicense | Select-Object DisplayName, UserPrincipalName | Export-Csv -Path $exportPath -NoTypeInformation
                Write-Host "Exported users with license '$selectedProduct' to '$exportPath'."
            } else {
                Write-Host "No users found with license '$selectedProduct'."
            }
        } else {
            Write-Host "No SKU found for '$selectedProduct'."
        }
    } else {
        Write-Host "Invalid selection. Please try again."
    }

    # Pause before the next iteration
    Read-Host "Press Enter to continue..."
}
