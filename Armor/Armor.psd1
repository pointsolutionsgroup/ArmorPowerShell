#
# Module manifest for module 'Armor'
#
# Generated by: Troy Lindsay
#
# Generated on: 7/10/2019
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Armor.psm1'

# Version number of this module.
ModuleVersion = '1.0.333'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '226c1ea9-1078-402a-861c-10a845a0d173'

# Author of this module
Author = 'Troy Lindsay'

# Company or vendor of this module
CompanyName = 'Armor'

# Copyright statement for this module
Copyright = '©2017-2019 Troy Lindsay. All rights reserved.'

# Description of the functionality provided by this module
Description = 'This is an open source, community project that provides a powerful command-line interface for managing and monitoring your Armor Complete (secure public cloud) and Armor Anywhere (security as a service) environments and accounts via a PowerShell module with cmdlets that interact with the published RESTful APIs.

Every code push is built using psake on Windows and Ubuntu Linux via AppVeyor, as well as on macOS and Ubuntu Linux via Travis CI, and tested using the Pester test and mock framework.

Code coverage scores and reports showing 100% coverage are tracked by Coveralls.

Cmdlet & private function documentation is generated programmatically via platyPS and rigorously tested to ensure accuracy.

Every successful continuous integration build is continuously deployed to the AppVeyor NuGet project feed as a prerelease version for contributors.

Every successful continuous integration build on the master branch is continuously deployed to the PowerShell Gallery to deliver rigorously tested new features as fast as possible to end users.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
ScriptsToProcess = 'Lib\ArmorTypes.ps1'

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Add-ArmorCompleteWorkloadTier', 'Connect-Armor', 'Disconnect-Armor', 
               'Get-ArmorAccount', 'Get-ArmorAccountAddress', 
               'Get-ArmorAccountContext', 'Get-ArmorCompleteDatacenter', 
               'Get-ArmorCompleteWorkload', 'Get-ArmorCompleteWorkloadTier', 
               'Get-ArmorIdentity', 'Get-ArmorUser', 'Get-ArmorVM', 
               'Invoke-ArmorWebRequest', 'New-ArmorCompleteVM', 
               'Remove-ArmorCompleteVM', 'Remove-ArmorCompleteWorkload', 
               'Remove-ArmorCompleteWorkloadTier', 'Rename-ArmorCompleteVM', 
               'Rename-ArmorCompleteWorkload', 'Rename-ArmorCompleteWorkloadTier', 
               'Reset-ArmorCompleteVM', 'Restart-ArmorCompleteVM', 
               'Set-ArmorAccountContext', 'Start-ArmorCompleteVM', 
               'Stop-ArmorCompleteVM'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Get-ArmorCompleteVM'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = 'Armor.psd1', 'Armor.psm1', 'en-US\Armor-help.xml', 'Etc\Aliases.json', 
               'Etc\ApiData.json', 'Lib\ArmorTypes.ps1', 
               'Private\Add-ArmorApiUriQuery.ps1', 
               'Private\Assert-ArmorSession.ps1', 
               'Private\Expand-ArmorApiResult.ps1', 
               'Private\Format-ArmorApiRequestBody.ps1', 
               'Private\Get-ArmorApiData.ps1', 'Private\Hide-SensitiveData.ps1', 
               'Private\Invoke-ArmorRestMethod.ps1', 'Private\New-ArmorApiUri.ps1', 
               'Private\Request-ArmorApiToken.ps1', 
               'Private\Select-ArmorApiResult.ps1', 
               'Private\Update-ArmorApiToken.ps1', 
               'Public\Add-ArmorCompleteWorkloadTier.ps1', 
               'Public\Connect-Armor.ps1', 'Public\Disconnect-Armor.ps1', 
               'Public\Get-ArmorAccount.ps1', 'Public\Get-ArmorAccountAddress.ps1', 
               'Public\Get-ArmorAccountContext.ps1', 
               'Public\Get-ArmorCompleteDatacenter.ps1', 
               'Public\Get-ArmorCompleteWorkload.ps1', 
               'Public\Get-ArmorCompleteWorkloadTier.ps1', 
               'Public\Get-ArmorIdentity.ps1', 'Public\Get-ArmorUser.ps1', 
               'Public\Get-ArmorVM.ps1', 'Public\Invoke-ArmorWebRequest.ps1', 
               'Public\New-ArmorCompleteVM.ps1', 
               'Public\Remove-ArmorCompleteVM.ps1', 
               'Public\Remove-ArmorCompleteWorkload.ps1', 
               'Public\Remove-ArmorCompleteWorkloadTier.ps1', 
               'Public\Rename-ArmorCompleteVM.ps1', 
               'Public\Rename-ArmorCompleteWorkload.ps1', 
               'Public\Rename-ArmorCompleteWorkloadTier.ps1', 
               'Public\Reset-ArmorCompleteVM.ps1', 
               'Public\Restart-ArmorCompleteVM.ps1', 
               'Public\Set-ArmorAccountContext.ps1', 
               'Public\Start-ArmorCompleteVM.ps1', 
               'Public\Stop-ArmorCompleteVM.ps1'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Armor','Defense','Cloud','Security','DevOps','Scripting','Automation','Complete','Anywhere','Compliance','PCI-DSS','HIPAA','HITRUST','GDPR','IaaS','SaaS','SECaaS','Windows','Linux','Mac','macOS','PSEdition_Core','PSEdition_Desktop'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/tlindsay42/ArmorPowerShell/blob/master/LICENSE.txt'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/tlindsay42/ArmorPowerShell'

        # A URL to an icon representing this module.
        IconUri = 'https://tlindsay42.github.io/ArmorPowerShell/img/Armor_logo.png'

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'https://tlindsay42.github.io/ArmorPowerShell/'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

