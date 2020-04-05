$ErrorActionPreference = 'Stop'; 

$packageName = $env:ChocolateyPackageName
$fullPackage = "OfflineSetup_Altium_Designer_Public_20_0_13.zip"
$url64 = 'https://s3.amazonaws.com/altium-release-manager/Altium_Designer_20/' + $fullPackage
$checksum64 = '7aa979f9fd93d15e9e516482ad079af1fcb4d61df617b7c1d441ce632c1d4bd1'

$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$WebFileArgs = @{
  packageName         = $packageName
  FileFullPath        = Join-Path $WorkSpace $fullPackage
  Url64bit            = $url64
  Checksum64          = $checkSum64
  ChecksumType        = 'sha256'
  GetOriginalFileName = $true
}

$PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

$UnzipArgs = @{
  PackageName  = $packageName
  FileFullPath = $PackedInstaller
  Destination  = $WorkSpace
}

Get-ChocolateyUnzip @UnzipArgs


# unattended install requires AutoIT
#
$autoitExe = 'C:\Program Files (x86)\AutoIt3\AutoIt3.exe'
$autoitFile = Join-Path $toolsDir 'altium-designer.au3'
$fileFullPath = Join-Path $workSpace "AltiumDesigner20Setup.exe"

Write-Debug "AutoIt: `t$autoitExe"
Write-Debug "AutoItFile: `t$autoitFile"
Write-Debug "FileFullPath `t$fileFullPath"

Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $fileFullPath"
