
$ComputerName = "."
    foreach ($i in $ComputerName)
    {
        $results1 = Get-WmiObject -computername . win32_networkadapter | Where-Object {($_.NetConnectionID -like '*Wireless*') -or ($_.NetConnectionID -like '*Wi-Fi*')} | select Name, Speed
        $results2 = Get-WmiObject -computername . win32_networkadapterconfiguration | Where-Object {$_.Description -like $results1.Name} | Select Description, DHCPEnabled, DHCPLeaseObtained, DHCPServer, DNSHostName, IPAddress, MACAddress
        $results2.DHCPLeaseObtained = $results2.DHCPLeaseObtained.Substring(4,2) + "/" + `
                $results2.DHCPLeaseObtained.Substring(6,2) + "/" + `
                $results2.DHCPLeaseObtained.Substring(0,4) + " " + `
                $results2.DHCPLeaseObtained.Substring(8,2) + ":" + `
                $results2.DHCPLeaseObtained.Substring(10,2) + ":" + `
                $results2.DHCPLeaseObtained.Substring(12,2)
        $results1 
        $results2
    }
