#  SNMP Check Script

$lstServers = Get-Content C:\file.txt

foreach($i in $lstServers)
{
    snmpwalk -v2c -c[snmp read string] $i system
    if($LASTEXITCODE -ne 0)
    {
        $i | Out-File D:\Temp\snmpNotResponding_ips.txt -append
    } else {
        $i | Out-File D:\Temp\snmpResponding_ips.txt -append
    }
}