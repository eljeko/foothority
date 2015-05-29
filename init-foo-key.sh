if [ -d "foothority-private-key" ]; then
	echo "Delete current key? (yes|no): "
	read answer
	if [ "$answer" == "yes" ]; then
		rm -rf foothority-private-key/*
	   	#openssl genrsa -des3 -out foothority-private-key/private.key 2048
	   	openssl genrsa -out foothority-private-key/private.key 4096
		echo "key generated"
	 exit;
	fi
fi