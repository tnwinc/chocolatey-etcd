# stop on all errors
$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if ((Get-Service | Where-Object { $_.Name -eq "etcd" }).length)
{
	Get-Service etcd | Stop-Service
	&nssm remove etcd confirm
}

Remove-Item C:\ProgramData\etcd -Recurse -Force
Remove-Item "$toolsDir\etcdctl.exe"