#
# For support or general questions go to:
#
# https://support.microsoft.com/en-us/help/4026305/sql-contact-microsoft-azure-support
#
FROM mcr.microsoft.com/openjdk/jdk:17-ubuntu

# Set the working directory to '/opt/spring-boot' directory
WORKDIR /opt/spring-boot

# Download the Application Insights Agent JAR
RUN apt update && \
    apt install -y curl && \
    curl -L -O https://github.com/microsoft/ApplicationInsights-Java/releases/download/3.5.1/applicationinsights-agent-3.5.1.jar

# Expose the ports we're interested in
EXPOSE 8080

# Set the container up with an entrypoint so we can make sure any runtime
# customizations happen at the appropriate time.
COPY entrypoint.sh .
ENTRYPOINT ["/opt/spring-boot/entrypoint.sh"]
RUN chmod a+x entrypoint.sh

# Set the default command to run on boot
CMD java $JAVA_AGENT -jar spring-boot.jar

# Copy the JAR file
COPY spring-boot-pet-clinic.jar /opt/spring-boot/spring-boot.jar 
