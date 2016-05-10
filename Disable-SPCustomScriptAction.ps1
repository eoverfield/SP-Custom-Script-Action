<#
.SYNOPSIS
Disables the Custom Script embedded demo

.EXAMPLE
PS C:\> .\Disable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite"

.EXAMPLE
PS C:\> $creds = Get-Credential
PS C:\> .\Disable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite" -Credentials $creds
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
Write-Host -ForegroundColor White "|            Disabling Custom Script Action            |"
Write-Host -ForegroundColor White "--------------------------------------------------------"

Write-Host -ForegroundColor Yellow "Target Site URL: $TargetSiteUrl"

try
{
    Connect-SPOnline $TargetSiteUrl -Credentials $Credentials

    $customAction = Get-SPOCustomAction -Scope Site | where { $_.Name -eq "RegisterUserScript" }
    Remove-SPOCustomAction -Identity $customAction.Id -Scope Site -Force

    Write-Host -ForegroundColor Green "Custom Script Action  removal succeded"
}
catch
{
    Write-Host -ForegroundColor Red "Exception occurred!" 
    Write-Host -ForegroundColor Red "Exception Type: $($_.Exception.GetType().FullName)"
    Write-Host -ForegroundColor Red "Exception Message: $($_.Exception.Message)"
}