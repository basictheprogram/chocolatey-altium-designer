$ErrorActionPreference = 'Stop'; 

# https://s3.amazonaws.com/altium-release-manager/Altium_Designer_19/OfflineSetup_Altium_Designer_Public_19_1_8.zip
# altium_designer_offline_installer_19_1_8.zip
# https://s3.amazonaws.com/altium-release-manager/Altium_Designer_19/OfflineSetup_Altium_Designer_Public_19_1_8.zip?response-content-disposition=attachment;%20filename=%22altium_designer_offline_installer_19_1_8.zip%22&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAI5TSRXSMZE33ALGA/20191017/us-east-1/s3/aws4_request&X-Amz-Date=20191017T175959Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Signature=d1524ba989315041d071f1d2885a046a23fd59a638ad050ed44dbe5750c9ae67

$packageName = $env:ChocolateyPackageName
#$fullPackage = "AltiumDesignerSetup_19_1_8.exe"
#$url64 = 'https://s3.amazonaws.com/altium-release-manager/Altium_Designer_19/' + $fullPackage
#$checksum64 = '0b3b206090b4c6b51544090404487901dc9af7ed7b9322835ccfe76c6eaf7c61'

$fullPackage = "OfflineSetup_Altium_Designer_Public_19_1_8.zip"
$url64 = 'https://s3.amazonaws.com/altium-release-manager/Altium_Designer_19/' + $fullPackage
$checksum64 = '24ae930e4c02bc6b6228fdde9ad28fdf6756bed9da636ecec4aafeeb62519791'

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
