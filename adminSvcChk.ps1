# PoSH script to enumerate all servers in AD, then enumerate the services on each server and list all services using the "administrator" account.
# Set filters for search
$strCategory = "computer"
$strOperatingSystem = "Windows*Server*"

# Set search location
$objDomain = New-Object System.DirectoryServices.DirectoryEntry
$objSearcher = New-Object System.DirectoryServices.DirectorySearcher
$objSearcher.SearchRoot = $objDomain
$objSearcher.Filter = ("OperatingSystem=$strOperatingSystem")
$colProplist = "name"

foreach ($i in $colPropList){$objSearcher.PropertiesToLoad.Add($i)}
$colResults = $objSearcher.FindAll()

# Clear text file
"" | Out-File $Home\adminSvcs.txt

foreach ($objResult in $colResults)
   {
	$addressName = $objResult.Properties.name
	$pingReply = Get-WmiObject -Class Win32_PingStatus -Filter "Address='$addressName'"
	if ($pingReply.StatusCode -eq 0)
		{
		Write-Host "$addressName"
		"" | Out-File $Home\adminSvcs.txt -append
		$addressName | Out-File $Home\adminSvcs.txt -append
		Get-WmiObject -class Win32_Service -computer $addressName -ea "Stop" | where {$_.startname -match "administrator"} | Select-Object -property displayname, name,  startname | Sort-Object -property startname | Out-File $Home\adminSvcs.txt -append
		trap
			{
			"Error accessing $addressName" | Out-File $Home\adminSvcsError.txt -append
			continue
			}
		}
	else
		{
		"" | Out-File $Home\adminSvcs.txt -append
		"The server, " + $addressName + ", did not respond to the poll." | Out-File $Home\adminSvcs.txt -append
		}
	}

