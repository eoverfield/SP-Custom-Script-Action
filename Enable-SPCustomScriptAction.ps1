<#
.SYNOPSIS
Enables the Custom Script embedded - as demo for allowing custom JS on new SPO Document Library UI

.EXAMPLE
PS C:\> .\Enable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite"

.EXAMPLE
PS C:\> $creds = Get-Credential
PS C:\> .\Enable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite" -Credentials $creds
#>

[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true, HelpMessage="Enter the URL of the target site collection, e.g. 'https://intranet.mydomain.com/sites/targetSite'")]
    [String]
    $TargetSiteUrl,

    [Parameter(Mandatory = $false, HelpMessage="Optional administration credentials")]
    [PSCredential]
    $Credentials
)

if($Credentials -eq $null)
{
	$Credentials = Get-Credential -Message "Enter Admin Credentials"
}

Write-Host -ForegroundColor White "--------------------------------------------------------"
Write-Host -ForegroundColor White "|            Enabling Custom Script Action             |"
Write-Host -ForegroundColor White "--------------------------------------------------------"

Write-Host -ForegroundColor Yellow "Target Site URL: $targetSiteUrl"

try
{
    Connect-SPOnline $targetSiteUrl -Credentials $Credentials
    Apply-SPOProvisioningTemplate -Path .\Custom.Script.Action.Infrastructure.xml -Handlers Files

    Apply-SPOProvisioningTemplate -Path .\Custom.Script.Action.Template.xml -Handlers CustomActions -Parameters @{"InfrastructureSiteUrl"=$targetSiteUrl}
    
    Write-Host -ForegroundColor Green "Custom Script Action application succeeded"
}
catch
{
    Write-Host -ForegroundColor Red "Exception occurred!" 
    Write-Host -ForegroundColor Red "Exception Type: $($_.Exception.GetType().FullName)"
    Write-Host -ForegroundColor Red "Exception Message: $($_.Exception.Message)"
}