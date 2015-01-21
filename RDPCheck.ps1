$computer = "."
$namespace = "root\CIMV2\TerminalServices"

if	((Get-WmiObject -Class Win32_TerminalServiceSetting -ComputerName $computer -Namespace $namespace).AllowTSConnections -eq 1)
{
	Write-Host "Remote Desktop Connections to $computer are allowed."
}
Elseif	((Get-WmiObject -Class Win32_TerminalServiceSetting -ComputerName $computer -Namespace $namespace).AllowTSConnections -eq 0)
{	
	Write-Host "Remote Desktop Connections to $computer are NOT allowed."
}
