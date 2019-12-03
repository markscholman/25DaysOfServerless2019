$twilioSid = (ConvertTo-SecureString -AsPlainText -String "<TWILIO_SID>" -Force)
$twilioToken = (ConvertTo-SecureString -AsPlainText -String "<TWILIO_TOKEN>" -Force)

$rg = New-AzResourceGroup -Name '25DaysOfServerless' -Location 'westeurope' -Force
$deployParams = @{
    Name = "day2-$(Get-Date -Format "yyMMddHHmm")"
    ResourceGroupName = $rg.ResourceGroupName
    TemplateFile = './azuredeploy.json'
    WorkflowName = 'day2'
    TwilioSid = $twilioSid
    TwilioToken = $twilioToken
    Verbose = $true
}
$result = New-AzResourceGroupDeployment @deployParams

#Test App
$uri = $result.Outputs.webHookURI.Value
$body = '{"phoneNumber":"+3123456789"}' 
Invoke-RestMethod -Method Post -Uri $uri `
 -Body $body `
 -ContentType "application/json"
