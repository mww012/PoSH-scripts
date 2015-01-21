# Find matches in 2 arrays.



$lstIP1 = Get-Content "C:\File1.txt"
$lstIP2 = Get-Content "C:\File2.txt"

foreach ($ip in $lstIP1)
{
    foreach ($i in $lstIP2)
    {
        if ($i -match $ip)
        {
            $lstIP1 | where {$_ -ne $i} | Out-File "C:\results.txt"
        }
    }
}
