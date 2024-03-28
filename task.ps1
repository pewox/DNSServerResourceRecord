$action = New-ScheduledTaskAction -Execute 'powershell' -argument '-ExecutionPolicy Bypass -File C:\PSScripte\CName\test.ps1 -Name "neu" -HostAliasName "neu.jusitz.thlv.de" -Zonename "neueZone"'
$trigger = New-ScheduledTaskTrigger -once -At 09:02
$principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest #-LogonType ServiceAccount  
Register-ScheduledTask -taskname 'FQDN-Rename' -Action $action -Trigger $trigger -Principal $principal -AsJob -Force | Out-Null