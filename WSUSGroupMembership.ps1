#	Get WSUS Group Memberships
#	Author: Michael Wood, Willis-Knighton Health System
#	Version 1.0
#
#	Script should query WSUS server for all registered computers and then enumerate the groups for each computer.  The results should be saved to a text file in the format <pc name>,<group1>,<group2>...

#Set variables
#$wsusServer = Read-Host 'Please enter the WSUS server you wish to query.'
$wsusServer = "[wsusServer]"

#Set up $wsus variable
[Void][Reflection.Assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration")
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer($wsusServer,$false)

$computers = $wsus.GetComputerTargets()
$groups = $wsus.GetComputerTargetGroups()
$hshGroups = @{}

foreach ($group in $groups) {
New-Variable -Name ("grp"+$group.Name)
$computers = $group.GetComputerTargets()

$hshGroups.Add($group.Name, ($computers | foreach{$_.FullDomainName}))

Remove-Variable -Name ("grp"+$group.Name)
}
$hshGroups.GetEnumerator() |  | Export-Csv U:\groups.csv
	
