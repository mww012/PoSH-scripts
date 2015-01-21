clear-variable i, downPorts
$downPorts = Import-Csv "C:\Users\user\file.csv"
$hshSwitches = @{}
$devName = "Device Name"

foreach ($i in $downPorts){
    $switch = $i.$devName
    if ($hshSwitches.ContainsKey($switch)){
        $count = $hshSwitches.get_Item($switch)
        $count += 1
        $hshSwitches.set_Item($switch, $count)
    }
    else {
        $hshSwitches.Add($switch, 1)
    }
}
foreach ($x in $hshSwitches.GetEnumerator() | Sort Value) {
    $x
}