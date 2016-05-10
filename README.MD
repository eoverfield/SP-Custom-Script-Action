# SharePoint Online Custom Action Script Reference #
This is sample code on how to link to a JavaScript file within SharePoint Online using PnP / PowerShell.
This JavaScript Embed technique is friendly with injecting JavaScript into the new SharePoint Online Document Library UI released by Microsoft in early 2016.
<a href="https://github.com/OfficeDev/PnP-Tools/tree/master/Solutions/SharePoint.UI.Responsive">This is based on the PnP Response UI project released by Microsoft</a>.
 
>**Note**: This is an **Open Source** project, and any contribution from the community
is more than welcome. 

# Setup Instructions #
In order to setup the solution and to enable the Custom Action Script on a target
Site Collection, you simply need to:
* [Download the files included in this solution](#download)
* [Setup software requirements](#requirements)
* [Execute the *Enable-SPCustomScriptAction* cmdlet](#execute)

If you decide to disable this Custom action, please refer to the section [Disable the Custom Action](#disable)

<a name="download"></a>
## Download the files
You can download the files manually, one by one, or you can download the entire branch

<a name="requirements"></a>
## Setup software requirements
This solution requires the OfficeDevPnP.PowerShell commands, which you can install
from the following link:

* <a href="http://aka.ms/officedevpnpcmdlets15">OfficeDevPnP.PowerShell v15 package</a>

If you want, you can also read the following 
<a href="https://github.com/OfficeDev/PnP-PowerShell#installation">instructions</a>
for further details about installing OfficeDevPnP.PowerShell.

<a name="execute"></a>
## Execute the *Enable-SPCustomScriptAction* cmdlet
Once you have installed the OfficeDevPnP.PowerShell commands, you can  simply open a 
PowerShell console, go to the path where you stored the files and execute the *Enable-SPCustomScriptAction*
cmdlet, which is included in the
<a href="./Enable-SPCustomScriptAction.ps1">Enable-SPCustomScriptAction.ps1</a> script file of this solution.

The *Enable-SPCustomScriptAction* cmdlet accepts the following three parameters:
* **TargetSiteUrl**: it is a mandatory parameter, which declares the URL of the Site Collection, where the Responsive UI will be enabled. It has to be provided as a full URL, like for example: https://intranet.mydomain.com/sites/targetSite
* **InfrastructureSiteUrl**: I took this out for ease of the example from the PnP source project. you could add this back in if needed.
* **Credentials**: it is an optional parameter, which defines the user credentials that will be used to authenticate against both the target Site Collection and the infrastructure Site Collection, if any. Should be the credentials of a user, who is Site Collection Administrator for the target Site Collections. If you don't provide this parameter, the script will directly prompt you for credentials.

Here you can see a couple of examples about how to invoke the *Enable-SPCustomScriptAction* cmdlet:

###EXAMPLE 1
```PowerShell
PS C:\> .\Enable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite"
```

The example above enables the Custom Action Script on the target Site Collection with URL https://intranet.mydomain.com/sites/targetSite and uses the same Site Collection for hosting the JavaScript files. The user's credentials are not provided, so the cmdlet will directly prompt the user.

###EXAMPLE 2
```PowerShell
PS C:\> $creds = Get-Credential
PS C:\> .\Enable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite" -Credentials $creds
```
 
The example above enables the Custom Action Script on the target Site Collection with URL https://intranet.mydomain.com/sites/targetSite and uses the same Site Collection for hosting the JavaScript files.The user's credentials are  provided through the *$creds* variable.

<a name="disable"></a>
# Disable the Custom Action Script#
If you want to disable the Custom Action Script on a target Site Collection, you can execute the
*Disable-SPCustomScriptActionI* cmdlet, which is included in the
<a href="./Disable-SPCustomScriptAction.ps1">Disable-SPCustomScriptAction.ps1</a> script file of this solution.

The *Disable-SPCustomScriptAction* cmdlet accepts the following two parameters:
* **TargetSiteUrl**: it is a mandatory parameter, which declares the URL of the Site Collection, where the Custom Action Script will be disabled, if it is enabled. It has to be provided as a full URL, like for example: https://intranet.mydomain.com/sites/targetSite
* **Credentials**: it is an optional parameter, which defines the user credentials that will be used to authenticate against the target Site Collection. Should be the credentials of a user, who is Site Collection Administrator for the target Site Collection. If you don't provide this parameter, the script will directly prompt you for credentials.

Here you can see an example about how to invoke the *Disable-SPCustomScriptAction* cmdlet:

###EXAMPLE 1
```PowerShell
PS C:\> .\Disable-SPCustomScriptAction.ps1 -TargetSiteUrl "https://intranet.mydomain.com/sites/targetSite"
```

The example above disables the Custom Action Script to the target Site Collection with URL https://intranet.mydomain.com/sites/targetSite . The user's credentials are not provided, so the cmdlet will directly prompt the user.

>Note: It is important to notice that even if you disable the Custom Action Script for a target Site Collection, any JavaScript or CSS files will not be removed from that site or from the Infrastructural Site Collection.

<a name="overview"></a>
# Solution Overview #
The solution leverages some JavaScript embedding to allow for JavaScript inclusion throughout the site, even on the new Document Library UI pages.

# Helpful Links #

List all current site based custom actions
{sitecollection}/_api/site/userCustomActions?$orderby=Sequence

List all current web based custom actions
{sitecollection|/{web}/_api/web/userCustomActions?$orderby=Sequence

PnP Custom Action Overview
https://github.com/OfficeDev/PnP-Provisioning-Schema/blob/master/ProvisioningSchema-2015-05.md

PnP Responsive UI Inspiration Project
https://github.com/OfficeDev/PnP-Tools/tree/master/Solutions/SharePoint.UI.Responsive