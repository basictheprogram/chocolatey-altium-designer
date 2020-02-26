$ErrorActionPreference = 'Stop'; 

# https://s3.amazonaws.com/altium-release-manager/Altium_Designer_19/OfflineSetup_Altium_Designer_Public_19_1_9.zip
#
$packageName = $env:ChocolateyPackageName
$fullPackage = "OfflineSetup_Altium_Designer_Public_19_1_9.zip"
$url64 = 'https://s3.amazonaws.com/altium-release-manager/Altium_Designer_19/' + $fullPackage
$checksum64 = 'd2e98bfa4acc936e6bd5b19bd7608500c00357d8d205540e5f55c8ef2fedb564'

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
$fileFullPath = Join-Path $workSpace "AltiumDesigner19Setup.exe"

Write-Debug "AutoIt: `t$autoitExe"
Write-Debug "AutoItFile: `t$autoitFile"
Write-Debug "FileFullPath `t$fileFullPath"

#$autoitProc = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile $fileFullPath" -PassThru
Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $fileFullPath"
