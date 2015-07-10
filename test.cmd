@echo off
del *.nupkg
choco pack
choco install etcd -fvy -s "%cd%" --params="-discovery https://discovery.etcd.io/cb50ee4abf32b526d1157006af20adea"
