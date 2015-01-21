# PoSH script for to map map between multiple UNC path locations
$driveLetter = "G:" 
$driveMap = Get-WmiObject -Class win32_logicaldisk | Select DeviceID,ProviderName,DriveType | Where-Object {$_.DeviceID -like "*$driveLetter*"}
$location1 = "\\server1\folder1"
$location2 = "\\server2\folder2"


Function getUserResponse($currentProvider, $driveLetter)
 {
     switch ($currentProvider)
    {
        $location1 { $newProvider = $location2 }
        $location2 { $newProvider = $location1 }
        "n" { $newProvider = $location1 
                $currentProvider = "not mapped" }
    }
    
    
    $userResp = Read-Host "Your $driveLetter drive is currently $currentProvider.  Would you like to map it to $newProvider`?[y/n]"
    $returnArray = @($userResp, $newProvider)

     
    if ($userResp -eq 'Y') {
        return $returnArray
    } elseif ($userResp -eq 'N') {
        return $returnArray
    } else {
        Write-Host "Please answer 'y' or 'n'."
        getUserResponse $currentProvider $driveLetter
    }
}


Function mapDrive($isMapped, $driveLetter)
{
    $response = getUserResponse $isMapped $driveLetter
    $net = New-Object -ComObject WScript.Network
    

    if ($response[0] -eq 'y') {
        if ($net.EnumNetworkDrives() -like $driveLetter)
        {
            $net.RemoveNetworkDrive($driveLetter, 1, 1)
            Start-Sleep -s 2
        }
        $net.MapNetworkDrive($driveLetter, $response[1], 1)
        Write-Host "Your $driveLetter drive is now mapped to $($response[1])."
        Start-Sleep -s 3
        exit
    } else {
        Write-Host "No changes have been made to your $driveLetter drive."
        Start-Sleep -s 3
        exit
    }
}


if (!$driveMap) {
    $isMapped = "n"
} else {
    $isMapped = $driveMap.ProviderName
}


mapDrive $isMapped $driveLetter