$path = 'D:\PSSkripte\DNSServerResourceRecord\target_script.ps1'
Clear-Content -Path $path -Force

Write-Host "`n--Eingabe der Parameter zur Aenderung des FQDN des CName--`n
-Optionale Parameter: Standardwerte sind hier ZoneName=jusitz.thlv.de, ComputerName=jus001zejen (verwaltender DNS-Server)`n
-Erforderliche Parameter: Alias-Name und FQDN`n"
function Get-Data {
    [CmdletBinding()]
    param (
        [string]$Name = (Read-Host "`nAlias-Name(erforderlich)").Trim(),
        [string]$HostAliasName = (Read-Host "`nFQDN(erforderlich)").Trim(),
        [string]$tempzone = (Read-Host "`nZone(optional)").Trim(),
        [string]$tempcompname = (Read-Host "`nDNS-Server(optional)").Trim(),
        [string]$check = (Read-Host "`nWeiterer Eintrag?(j/n)").ToLower()
    )
    process{
        if([string]::IsNullOrEmpty($tempzone)){$ZoneName='jusitz.thlv.de'}else{$ZoneName=$tempzone}
        if([string]::IsNullOrEmpty($tempcompname)){$ComputerName='jus001zejen'}else{$ComputerName=$tempcompname}
        Add-Content -Path $path `
        -Value "Add-DnsServerResourceRecordCName -ZoneName $ZoneName -ComputerName $ComputerName -Name $Name -HostNameAlias $HostAliasName" `
        -Force
        if($check -eq "j"){Get-Data}
    }
}
Get-Data