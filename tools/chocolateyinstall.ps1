$ErrorActionPreference = 'Stop'; 

$packageName = $env:ChocolateyPackageName
$fullPackage = "AltiumDesignerSetup_17_1_9.exe"
$url64 = 'http://gold-images.int.celadonsystems.com/Altium/AltiumDesignerSetup_17_1_9.exe'
$checksum64 = 'dded5f40d3c64fe311903e2acf1ede305797ef4b539a7441d1e51813fc6fff19'
$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$WebFileArgs = @{
  packageName         = $packageName
  FileFullPath        = Join-Path $WorkSpace $fullPackage
  Url64bit            = $url64
  Checksum64          = $checkSum64
  ChecksumType        = 'sha256'
  GetOriginalFileName = $true
}

#$PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

$UnzipArgs = @{
  PackageName  = $packageName
  FileFullPath = $PackedInstaller
  Destination  = $WorkSpace
}

# Get-ChocolateyUnzip @UnzipArgs

# silent install requires AutoIT
#
$autoitExe = 'AutoIt3.exe'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$autoitFile = Join-Path $toolsDir 'altium-designer.au3'
$fileFullPath = Join-Path $workSpace $fullPackage

$autoitProcess = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile $fileFullPath" -PassThru

$InstallArgs = @{
  packageName  = $packageName
  file         = Join-Path $WorkSpace $fullPackage
  url          = $url
  checksum     = $checkSum
  checksumType = 'sha256'
  fileType     = 'exe'
  # silentArgs     = '/S /v/qn'
  # validExitCodes = @(0, 3010, 1641)
  softwareName = 'altium-designer*'
}

Install-ChocolateyInstallPackage @InstallArgs
