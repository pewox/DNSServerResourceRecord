$path = 'D:\PSSkripte\DNSServerResourceRecord\target_script.ps1'
Clear-Content -Path $path -Force

Write-Host "`n--Eingabe der Parameter zur Aenderung des FQDN des CName--`n
-Optionale Parameter: Standardwerte sind hier ZoneName=jusitz.thlv.de, ComputerName=jus001zejen (verwaltender DNS-Server)`n
-Erforderliche Parameter: Alias-Name und FQDN`n"
function Set-Data {
    param (
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [string]$HostAliasName,
        [Parameter(Mandatory)]
        [string]$ZoneName,
        [Parameter(Mandatory)]
        [string]$ComputerName
    )
    process {
        Write-Host $Name, $HostAliasName, $ZoneName, $ComputerName
        #Add-DnsServerResourceRecordCName -ZoneName $ZoneName -ComputerName $ComputerName -Name $Name -HostNameAlias $HostAliasName
        Add-Content -Path $path `
        -Value "Add-DnsServerResourceRecordCName -ZoneName $ZoneName -ComputerName $ComputerName -Name $Name -HostNameAlias $HostAliasName" `
        -Force
    }
}

function Get-Data {
    param (
        [string]$Name = (Read-Host "Alias-Name(erforderlich)").Trim(),
        [string]$HostAliasName = (Read-Host "`nFQDN(erforderlich)").Trim(),
        [string]$tempzone = (Read-Host "`nZone(optional)").Trim(),
        [string]$tempcompname = (Read-Host "`nDNS-Server(optional)").Trim(),
        [string]$check = (Read-Host "`nWeiterer Eintrag ?(j/n)").ToLower()
    )
    process{
        if([string]::IsNullOrEmpty($tempzone)){$ZoneName='jusitz.thlv.de'}else{$ZoneName=$tempzone}
        if([string]::IsNullOrEmpty($tempcompname)){$ComputerName='jus001zejen'}else{$ComputerName=$tempcompname}
        Set-Data -Name $Name -HostAliasName $HostAliasName -ZoneName $ZoneName -Computername $ComputerName
        if($check -eq "j"){Get-Data}
    }
}
Get-Data