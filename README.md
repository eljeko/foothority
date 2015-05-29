# foothority

A colletcion of scripts to generate test ca and certs.

Don't use this for production ;)

# setup the Foothority

1) Run 

	init-foo-key.sh

This will init your key	
	
2) run
		
	init-foo-ca.sh
	
This creates the ca:

	C=OZ
	ST=Land of Oz
	L=Emerald City
	O=Wizards
	CN=The Widzard Of Oz CA
	
## Create a p12 cert file

	create-p12-cert.sh
	
The script asks you for a Common Name for the certificate the default is *"Dorothy Gale"*

## Create a Java Server Keystore

	create-server-keystore.sh
	
The script asks you for a server name the default is *"emerald.server.oz"*	
	