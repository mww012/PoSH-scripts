# Script enumerates AD servers, then enumerates a list of installed programs via wmi and looks of a specific application
$servers = Get-ADServers
$serverNames = $servers.properties.name
"" | Out-File -FilePath "C:\success_output.txt"
"" | Out-File -FilePath "C:\unsuccessful_orError.txt"
"" | Out-File -FilePath "C:\noRepsonse.txt"

foreach ($i in $serverNames)
{
    if ((Test-Connection -ComputerName $i -Quiet -Count 1) -eq $true)
    {
        $tryWMI = Get-WmiObject -computername $i -Class Win32Reg_AddRemovePrograms -ErrorAction SilentlyContinue | Select-Object DisplayName | Where-Object {$_.DisplayName -like "[application]"}
        if ($tryWMI -ne $null)
        {
            $i | Out-File -Append -FilePath "C:\success_output.txt"
            echo "$i has networker"
        } else {
            $i | Out-File -Append -FilePath "C:\unsuccessful_orError.txt"
            echo "$i does not have networker or has an error"
        }
    
    
    } else {
        $i | Out-File -Append -FilePath "C:\noRepsonse.txt"
        echo "$i does not respond to ping"
    
    
    
    
    }
}
