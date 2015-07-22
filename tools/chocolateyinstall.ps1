# stop on all errors
$ErrorActionPreference = 'Stop';


$packageName = 'etcd' # arbitrary name for the package, used in messages
$url = '' # etcd is 64bit only ... this is intended to fail on 32 bit systems
$url64 = "https://github.com/coreos/etcd/releases/download/v$($env:chocolateyPackageVersion)/etcd-v$($env:chocolateyPackageVersion)-windows-amd64.zip"
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = "C:\ProgramData\etcd"

Install-ChocolateyZipPackage "$packageName" "$url" "$installDir" "$url64"

#remove the service if it exists
if ((Get-Service | Where-Object { $_.Name -eq "etcd" }).length)
{
	Get-Service etcd | Stop-Service
	&nssm remove etcd confirm
}

Copy-Item "C:\ProgramData\etcd\etcd-v$($env:chocolateyPackageVersion)-windows-amd64\*" C:\ProgramData\etcd -Recurse -Force
Remove-Item "C:\ProgramData\etcd\etcd-v$($env:chocolateyPackageVersion)-windows-amd64" -Recurse -Force

#older versions of etcd didn't put EXE on the binary
if (Test-Path C:\ProgramData\etcd\etcd) { copy-item C:\ProgramData\etcd\etcd C:\ProgramData\etcd\etcd.exe -force; remove-item C:\ProgramData\etcd\etcd }
if (Test-Path C:\ProgramData\etcd\etcdctl) { copy-item C:\ProgramData\etcd\etcdctl C:\ProgramData\etcd\etcdctl.exe -force; remove-item C:\ProgramData\etcd\etcdctl }

Copy-Item C:\ProgramData\etcd\etcdctl.exe $toolsDir -Force
&nssm install etcd C:\ProgramData\etcd\etcd.exe "$($env:chocolateyPackageParameters)"
&nssm set etcd Start SERVICE_AUTO_START