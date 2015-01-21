$ip = "."


Function ping-host($ip, $StartingStatus)
{
    
    Do
    {
        $CurrentStatus = Test-Connection $ip -Count 1 -Quiet
        Start-Sleep -Milliseconds 500
        echo "$ip $StartingStatus $CurrentStatus"
    } while ($StartingStatus -eq $CurrentStatus)

    $status = $CurrentStatus
    
    if ($CurrentStatus -eq $true)
    {
        echo "$ip is responding to pings"
    } else {
        echo "$ip is not responding to pings"
    }

}


Function Send-Pushping
{
	param (
        [parameter(Mandatory=$true)][string]$message, # Message to be sent to client
        [parameter(Mandatory=$false)][string]$title # optional title used by pushover notification
    ) # end parameters
    

    $user = '[user token]'
    $token = '[application token]'
    $uri = 'https://api.pushover.net/1/messages.json' # Pushover API address
    $parameters = @{ # Parameters to be sent to Pushover service for notification
        token = $token
        user = $user
        title = $title
        message = $message
   }
    $parameters | Invoke-RestMethod -Uri $uri -Method Post | Out-Null # Post rest method used to push $parameters to Pushover; Out-Null to remove all output
}

if ($status -eq $true)
{
    echo "$ip is responding to pings"
} else {
    echo "$ip is not responding to pings"
}


Do
{
    $status = Test-Connection $ip -Count 1 -Quiet
    ping-host $ip $status
} while ($true -eq $true)