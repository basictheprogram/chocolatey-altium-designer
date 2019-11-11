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

$autoitExe = 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe'
$autoitFile = Join-Path $toolsDir 'altium-designer-uninstaller.au3'
$uninstaller = 'C:\Program Files\Altium\AD19\System\Installation\AltiumInstaller.exe'

Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $packageArgs['file']"
