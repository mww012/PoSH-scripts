

$strCategory = "computer"
$strADstring = "LDAP://ou=servers,dc=consoto,dc=com"
$objDomain = New-Object System.DirectoryServices.DirectoryEntry("$strADstring")


$objSearcher = New-Object System.DirectoryServices.DirectorySearcher

$objSearcher.SearchRoot = $objDomain

$objSearcher.Filter = ("OperatingSystem=Window*Server*")

$objSearcher.PropertiesToLoad.Add("Name") | Out-Null

 

$colResults = $objSearcher.FindAll()

$colResults