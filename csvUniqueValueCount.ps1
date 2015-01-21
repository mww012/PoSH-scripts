# Powershell script to count number of unique lines in a csv file
#
#
#

$csvFile = "C:\file.csv"

$arrNames = Import-Csv $csvFile -Header Name
$hshNames = @{}
$i = ""
$count = ""



Foreach ($i in $arrNames)
{
	if($hshNames.ContainsKey($i.name))
    {
        $count = $hshNames.Item($i.name)
        $count += 1
        $hshNames.Set_Item($i.name, $count)
    }
    Else
    {
        $hshNames.Add($i.name,1)
    }
}

$hshNames.GetEnumerator() | Sort-Object Value

