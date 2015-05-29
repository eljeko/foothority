#!/bin/bash

export certfile

echo "Certificate CN? (default Dorothy Gale): "
read certname	
if [ -z "$certname"  ]; then
	export certname='Dorothy Gale'
fi	

export certfile=$(awk 'BEGIN{OFS="_"} {for (i=1; i<NF; i++) printf "%s%s",$i,OFS; printf "%s\n", $NF}' <<< "$certname")

echo "Your Certificate CN is: ["$certname"]"
echo "Your Certificate File will be: ["$certfile"-cert.p12]"

if [ -d "foothority-p12" ]; then
	echo "Delete current keystore? (yes|no): "
	read answer
	
	echo "Your server name is: ["$servername"]"
	if [ "$answer" == "yes" ]; then		
		rm -rf foothority-p12/*
		rm -rf foothority-p12/$certfile

		openssl req -new -key foothority-private-key/private.key -out foothority-p12/clientcert-cert-req.csr -subj "/C=OZ/ST=Land of Oz/L=Emerald City/O=People/CN=$certname" -passout pass:123456

		echo "Certificate REQ done"

		openssl x509 -req -days 730 -in foothority-p12/clientcert-cert-req.csr  -CA foothority-ca/wizard-ca.crt -CAkey foothority-private-key/private.key -set_serial 01 -out foothority-p12/clientcert-cert.crt

		echo "Signed REQ done"

		openssl pkcs12 -export -out foothority-p12/$certfile-cert.p12 -inkey foothority-private-key/private.key -in foothority-p12/clientcert-cert.crt -chain -CAfile foothority-ca/wizard-ca.crt -passout pass:123456

		echo "P12 generated"
	 exit;
	fi
fi