# PoSH Script to pull Servers in AD.  Returns $colResults containing server objects

Function Get-ADServers
{
    $strCategory = "computer"
    $strADstring = "LDAP://dc=contoso,dc=com"
    $objDomain = New-Object System.DirectoryServices.DirectoryEntry("$strADstring")


    $objSearcher = New-Object System.DirectoryServices.DirectorySearcher

    $objSearcher.SearchRoot = $objDomain

    $objSearcher.Filter = ("OperatingSystem=Window*Server*")

    $objSearcher.PropertiesToLoad.Add("Name") | Out-Null
    
    $colResults = $objSearcher.FindAll()

    $colResults
}