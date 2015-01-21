
Function Get-RemoteWLANInfo {

    param(
        [string] $ComputerName
    )

    begin
    {
        echo "Retrieving WLAN info from $computer..."
    }
    process
    {
        $results1 = Get-WmiObject -computername $ComputerName win32_networkadapter | Where-Object {($_.NetConnectionID -like '*Wireless*') -or ($_.NetConnectionID -like '*Wi-Fi*')} | select Name, Speed
        $results2 = Get-WmiObject -computername $ComputerName win32_networkadapterconfiguration | Where-Object {$_.Description -like $results1.Name} | Select Description, DHCPEnabled, DHCPLeaseObtained, DHCPServer, DNSHostName, IPAddress, MACAddress
        $results2.DHCPLeaseObtained = $results2.DHCPLeaseObtained.Substring(4,2) + "/" + `
                $results2.DHCPLeaseObtained.Substring(6,2) + "/" + `
                $results2.DHCPLeaseObtained.Substring(0,4) + " " + `
                $results2.DHCPLeaseObtained.Substring(8,2) + ":" + `
                $results2.DHCPLeaseObtained.Substring(10,2) + ":" + `
                $results2.DHCPLeaseObtained.Substring(12,2)
        $results1 
        $results2
    }
    end
    {
        echo ""
        echo "Finished retrieving WLAN info."
    }
}