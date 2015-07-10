#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

# stop on all errors
$ErrorActionPreference = 'Stop';


$packageName = 'etcd' # arbitrary name for the package, used in messages
$registryUninstallerKeyName = 'etcd' #ensure this is the value in the registry
$installerType = 'EXE_MSI_OR_MSU' #only one of these: exe, msi, msu
$url = '' # download url
$url64 = 'https://github.com/coreos/etcd/releases/download/v2.0.13/etcd-v2.0.13-windows-amd64.zip' # 64bit URL here or remove - if installer decides, then use $url
$silentArgs = '' # "/s /S /q /Q /quiet /silent /SILENT /VERYSILENT" # try any of these to get the silent installer #msi is always /quiet
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = "C:\ProgramData\etcd"

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir"
