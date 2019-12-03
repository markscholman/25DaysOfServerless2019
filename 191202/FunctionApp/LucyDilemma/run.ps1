# Input bindings are passed in via param block.
param($Timer)

# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

$bodyObject = Convertfrom-Json '{"phoneNumber":"+3123456789"}' 
$bodyObject.phoneNumber = $env:telephoneNumber

Invoke-RestMethod -Method Post -Uri $env:LogicAppUri `
 -Body (ConvertTo-Json $bodyObject) `
 -ContentType "application/json"

# Write an information log with the current time.
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
