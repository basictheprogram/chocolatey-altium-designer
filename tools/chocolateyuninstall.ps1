$ErrorActionPreference = 'Stop'

$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  softwareName = 'altium*'
  #  fileType       = 'exe'
  silentArgs   = ''
  #  validExitCodes = @(0)
}

# '"C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe" -Uninstall -UniqueID:"{21C9C7CD-410D-4925-8CC2-07CD746FF012}"' 

#[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
#Write-Warning "$($key) is the key"
#
#$key | % { 
#  $packageArgs['file'] = "$($_.UninstallString)"
#  $str = $packageArgs | Out-String
#  Write-Warning "$str is the packageArgs"
#  Uninstall-ChocolateyPackage @packageArgs
#}

$autoitExe = 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe'
$autoitFile = Join-Path $toolsDir 'altium-designer-uninstaller.au3'
# $uninstaller = 'C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe -Uninstall -UniqueID:"{21C9C7CD-410D-4925-8CC2-07CD746FF012}"'
$uninstaller = 'C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe'

Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $packageArgs['file']"
