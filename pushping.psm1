# PoSH module to ping a host and send status notifications to pushover as pushping service

Function pushping
{
    param (
        [parameter(mandatory=$true)]$ip
        #[parameter(mandatory=$true)]$reboot = $(Read-Host -Prompt "Reboot $host ? (y/N)")   
    )
    
    Send-Pushping "Starting ping on $ip..."
    Do
    {
        $status = Test-Connection $ip -Count 1 -Quiet # sets $status as $true or $false
        ping-host $ip $status
    } while ($status -eq $true)
	
	Do
	{
		$status = Test-Connection $ip -Count 1-Quiet # sets $status as $true or $false
		ping-host $ip $status
	} while ($status -eq $false)		
}



Function ping-host($ip, $StartingStatus) # pings $ip and passes $status as $startingstatus.
{
    
    Do
    {
        $CurrentStatus = Test-Connection $ip -Count 1 -Quiet # sets $currentstatus as $true or $false
        Start-Sleep -Milliseconds 500 # wait .5 seconds
    } while ($StartingStatus -eq $CurrentStatus)

    $status = $CurrentStatus # sets global $status to $currentstatus
    
    if ($CurrentStatus -eq $true) # checks $status variable and changes push notification based on status
    {
        Send-Pushping "$ip is responding to pings"
    } else {
        Send-Pushping "$ip is not responding to pings"
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

if ($status -eq $true) # checks $status variable and changes push notification based on status
{
    echo "$ip is responding to pings"
} else {
    echo "$ip is not responding to pings"
}

