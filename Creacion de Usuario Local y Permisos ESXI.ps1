###Set parameters###
$User = "hostexplorer"
$Role = "readonly"
####################
#Get list of ESXi hosts
Connect-VIServer -Server sapl8433.desintra.banesco.com -user Administrator@vsphere.local -password Banesco2021..
$hosts = @()
#$hosts = "sinfra504.desintra.banesco.com"
Get-VMHost | sort Name | % { $hosts += $_.Name }

Disconnect-VIServer sapl8433.desintra.banesco.com -confirm:$false

foreach ($vmhost in $hosts) {
    write-host "Connecting to $vmhost..." -foregroundcolor "yellow"
    Connect-VIServer -Server $vmhost -user root -password !PLz1VmS6t2f
    New-VMHostAccount -ID hostexplorer -Password Banesco.2020 -UserAccount
	write-host "Assigning $Role permissions to $User" -foregroundcolor "yellow"
    $rootFolder = Get-Folder -NoRecursion
    New-VIPermission -Entity $rootFolder -Principal $User -Role $Role
	Disconnect-VIServer * -confirm:$false
}
