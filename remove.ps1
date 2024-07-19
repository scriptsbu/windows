$directoryPath = "C:\Windows\System32\drivers\Crowdstrike"
$searchPattern = "*C-000000291*"

$fileToDelete = Get-ChildItem -Path $directoryPath -Filter $searchPattern -ErrorAction SilentlyContinue

if ($fileToDelete) {
    try {
        #Delete the file
        Start-Process powershell.exe -ArgumentList "Remove-Item -Path `"$($fileToDelete.FullName)`" -Force"
        Write-Output "File '$($fileToDelete.Name)' has been deleted."
    }
    catch {
        Write-Output "An error occurred while trying to delete the file: $($_.Exception.Message)"
    }
} else {
    Write-Output "No file containing 'C-000000291' was found in the directory '$directoryPath'."
