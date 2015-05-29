#!/bin/bash

if [ -d "foothority-keystore" ]; then
	echo "Delete current keystore? (yes|no): "
	read answer
	echo "Server name? (default emerald.server.oz): "
	read servername	
	if [ -z "$servername"  ]; then	
		export servername='emerald.server.oz'
	fi	
	
	echo "Your server name is: ["$servername"]"
	
	if [ "$answer" == "yes" ]; then		
		rm -rf foothority-keystore/*
		rm -rf foothority-p12/emerald-cert.p12
		
		keytool -genkey -alias mydomain -keyalg RSA -keystore foothority-keystore/emerald-keystore.jks -keysize 2048 -dname "CN=Demo Server, OU=Development, O=server, L=Rome, S=Lazio, C=IT" -storepass 123456 -keypass 123456

		echo "Created Keystore"

		#empty keystore
		keytool -keystore foothority-keystore/emerald-keystore.jks -delete -alias mydomain -storepass 123456

		echo "Keystore now empty"

		openssl req -new -key foothority-private-key/private.key -out foothority-keystore/servercustom-cert-req.csr -subj "/C=OZ/ST=Land of Oz/L=Emerald City/O=Emerald Servers/CN=$servername" -passout pass:123456

		echo "Certificate REQ done"

		openssl x509 -req -days 730 -in foothority-keystore/servercustom-cert-req.csr  -CA foothority-ca/wizard-ca.crt -CAkey foothority-private-key/private.key -set_serial 01 -out foothority-keystore/servercustom-cert.crt

		echo "Signed REQ done"

		openssl pkcs12 -export -out foothority-p12/emerald-cert.p12 -inkey foothority-private-key/private.key -in foothority-keystore/servercustom-cert.crt -chain -CAfile foothority-ca/wizard-ca.crt -passout pass:123456

		echo "P12 generated"

		keytool -importkeystore -srckeystore foothority-p12/emerald-cert.p12 -srcstoretype PKCS12 -destkeystore  foothority-keystore/emerald-keystore.jks -deststoretype JKS -deststorepass 123456 -srcstorepass 123456

		echo "IMPORT p12 done"

		keytool  -changealias -alias 1 -destalias emerald-key -keystore  foothority-keystore/emerald-keystore.jks  -storepass 123456

		echo "Moved Alias"

		keytool --list -keystore  foothority-keystore/emerald-keystore.jks -storepass 123456

		echo "Keystore populated"
	 exit;
	fi
fi
