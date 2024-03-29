# ==============================================================================================
# 
# Microsoft PowerShell Source File -- Created with SAPIEN Technologies PrimalScript 2012
# 
# NAME: Text File Search
# 
# AUTHOR: Michael Wood
# DATE  : 8/24/2012
# 
# COMMENT: Script looks for a given string in a given text file and saves the results to a new text file with the name of the search string.
# 
# ==============================================================================================

$strPattern = Read-Host -Prompt "What string would you like to search for?" 
$strFileLocation = Read-Host "Where would you like to save the output file?"
$strOutFile = "$strFileLocation\$strPattern.txt"

$strReadFile = Get-Content "C:\SyslogSearchPattern.txt"


$strResult = Get-Content $strReadFile | Select-String $strPattern
echo $strResult

New-Item -ItemType file $strOutFile -Value "Search results for the pattern $strPattern."  -Force

Add-Content -Path $strOutFile -Value ""
Add-Content -Path $strOutFile -Value $strResult