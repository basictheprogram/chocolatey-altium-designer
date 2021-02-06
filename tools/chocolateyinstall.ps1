$ErrorActionPreference = 'Stop';

# Login as your altium.com user
# Navigate to https://www.altium.com/products/downloads
# Right side, you should see the Offline downloads
#
# https://s3.amazonaws.com/altium-release-manager/Altium_Designer_21/OfflineSetup_Altium_Designer_Public_21_1_0.zip
# https://s3.amazonaws.com/altium-release-manager/Altium_Designer_21/OfflineSetup_Altium_Designer_Public_21_0_8.zip
#
$packageName = $env:ChocolateyPackageName
$fullPackage = "OfflineSetup_Altium_Designer_Public_21_1_0.zip"
$url64 = 'https://s3.amazonaws.com/altium-release-manager/Altium_Designer_21/' + $fullPackage
$checksum64 = '27be3b0db54bba4777ad03b0b08a284511a51e6caad362bb27ec78e508a19dec'

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
