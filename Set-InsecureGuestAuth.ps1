<#
Version: 1.0
Author: Andy Friar (moxie365.com)
Script: Set-InsecureGuestAuth.ps1
Description:
The script hardcodes AllowInsecureGuestAuth to workaround inplace upgrade of Windows 10 20H2
Even though the GPO policy is set hardcoding is required.
Release notes:
Version 1.0: Original published version. 
The script is provided "AS IS" with no warranties.
#>

$AllowInsecureGuestAuth = (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters).AllowInsecureGuestAuth

if ($AllowInsecureGuestAuth -ne 1) {
    $registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters\"
    $registryKey = "AllowInsecureGuestAuth"
    $registryValue = 1
    
    try
    {
        Set-ItemProperty -Path $registryPath -Name $registryKey -Value $registryValue -ErrorAction Stop
        $exitCode = 0
    }
    catch
    {   
        Write-Error -Message "Could not write regsitry value" -Category OperationStopped
        $exitCode = -1
    }
}

exit $exitCode