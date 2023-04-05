f the depth is non-zero , continue processing
#echo "sstat 0x${tls_serial_0}"
[ "$1" -ne 0 ] && exit 0
issuer=/etc/pki/CA/ca.crt
CAfile=/etc/pki/CA/ca.crt
host=localhost
port=4444
if [ -n "${tls_serial_0}" ]
then
	status=$(openssl ocsp -issuer "${issuer}" -CAfile "${CAfile}" -host "${host}" -port "${port}"	-serial "${tls_serial_0}")
	#echo ${status} with openssl ocsp -issuer "${issuer}" -CAfile "${CAfile}" -host "${host}" -port "${port}" -serial "${tls_serial_0}"
	if [ $? -eq 0 ]
	then
		# debug:
		#echo "OCSP status: $status"
		if echo "$status" | grep -Fq "${tls_serial_0}: good"
		then
			#echo "We exit gracefully"
			exit 0
		fi
	else
		# debug:
		echo "openssl ocsp command failed!"
	fi
fi
exit 1

