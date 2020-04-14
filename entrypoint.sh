#!/bin/sh

if [ -f /opt/spring-boot/custom/mycert.crt ]; then 
    echo 'Applying custom certificate'
    keytool -import -trustcacerts -keystore cacerts -storepass changeit -noprompt -alias mycert -file /opt/spring-boot/custom/mycert.crt
fi

# Give control to the CMD in the Dockerfile
exec "$@"
