powershell -ExecutionPolicy ByPass -NoExit {

$source = "D:\Drive"
$destination = "U:\Backups"

$date = Get-Date -Format "MM-dd-yyyy HHmm"
$backupname = "D Backup $date"
$fullpath = Join-Path -Path $destination -ChildPath $backupname

# Find existing backup. 
$existing = Get-ChildItem -Path $destination -Filter "D Backup *" -ErrorAction SilentlyContinue

# Delete old backup if exists. 
if ($existing -ne $null) {
    Write-Host "Deleting old backup: $($existing.FullName)"
    $existing | Remove-Item -Recurse -Force -Verbose}

# Copy files to backup. 
try {
    Copy-Item -Path $source -destination $fullpath -Recurse -Force
    Write-Host "Backup Complete on $date" 
} catch {
    Write-Error "Backup Failed." }
}