#
# Officially supported Zulu JDK 
#
# For support or general questions go to:
#
# https://support.microsoft.com/en-us/help/4026305/sql-contact-microsoft-azure-support
#
FROM mcr.microsoft.com/java/jdk:8-zulu-centos

# Set the working directory to '/opt/spring-boot' directory
WORKDIR /opt/spring-boot

# Expose the ports we're interested in
EXPOSE 8080

# Make Java 8 obey container resource limits, improve performance
ENV JAVA_OPTS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+UseG1GC -Djava.awt.headless=true"

# Set the container up with an entrypoint so we can make sure any runtime
# customizations happen at the appropriate time.
COPY entrypoint.sh .
ENTRYPOINT ["/opt/spring-boot/entrypoint.sh"]
RUN chmod a+x entrypoint.sh

# Set the default command to run on boot
CMD ["java", "-jar", "spring-boot.jar"]

# Copy the JAR file
COPY target/spring-boot-container-quickstart.jar /opt/spring-boot/spring-boot.jar 
