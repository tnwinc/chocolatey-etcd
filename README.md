This package installs etcd as a service, and makes etcd-ctl.exe available in the path. 
	
etcd 2.0 no longer respects the -config parameter, all settings must be passed in on the command line. The package will pass package parameters to the service.
Example: `choco install etcd -y --params="-discovery https://discovery.etcd.io/tokengoeshere"`
	
The service is managed with NSSM, you can change the service parameters easily by running `nssm edit etcd`