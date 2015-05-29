if [ -d "foothority-ca" ]; then
	echo "Delete current ca? (yes|no): "
	read answer
	if [ "$answer" == "yes" ]; then
		rm -rf foothority-ca/*
		openssl req -new -x509 -days 1826 -key foothority-private-key/private.key -out foothority-ca/wizard-ca.crt  -subj "/C=OZ/ST=Land of Oz/L=Emerald City/O=Wizards/CN=The Widzard Of Oz CA" -passout pass:123456

		echo "CA generated"
	 exit;
	fi
fi