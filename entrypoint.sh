#!/bin/bash

if [ -f /opt/spring-boot/mycert.crt ]; then 
    echo 'Applying custom certificate'
    keytool -import -trustcacerts -keystore cacerts -storepass changeit -noprompt -alias mycert -file /opt/spring-boot/mycert.crt
fi

if [[ -n "$APPLICATIONINSIGHTS_CONNECTION_STRING" ]]; then
    echo 'Enabling Application Insights Java agent'
    export JAVA_AGENT="-javaagent:/opt/spring-boot/applicationinsights-agent-3.5.1.jar"
fi

# Give control to the CMD in the Dockerfile
exec "$@"
