$ErrorActionPreference = 'Stop';

# https://s3.amazonaws.com/altium-release-manager/Altium_Designer_21/OfflineSetup_Altium_Designer_Public_21_0_8.zip
#
$packageName = $env:ChocolateyPackageName
$fullPackage = "OfflineSetup_Altium_Designer_Public_21_0_8.zip"
$url64 = 'https://s3.amazonaws.com/altium-release-manager/Altium_Designer_21/' + $fullPackage
$checksum64 = 'e12670cfb6ca764e0e6cc87f3e3ba2c2280764171e01e8d57f9485da858e3668'

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
$fileFullPath = Join-Path $workSpace "AltiumDesigner21Setup.exe"

Write-Debug "AutoIt: `t$autoitExe"
Write-Debug "AutoItFile: `t$autoitFile"
Write-Debug "FileFullPath `t$fileFullPath"

Start-ChocolateyProcessAsAdmin  -ExeToRun $autoitExe -Statements "$autoitFile $fileFullPath"
