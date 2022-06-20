#
# For support or general questions go to:
#
# https://support.microsoft.com/en-us/help/4026305/sql-contact-microsoft-azure-support
#
FROM mcr.microsoft.com/openjdk/jdk:11-ubuntu

# Set the working directory to '/opt/spring-boot' directory
WORKDIR /opt/spring-boot

# Download the Application Insights Agent JAR
RUN apt update && \
    apt install -y curl && \
    curl -L -O https://github.com/microsoft/ApplicationInsights-Java/releases/download/3.0.0-PREVIEW.3/applicationinsights-agent-3.0.0-PREVIEW.3.jar

# Expose the ports we're interested in
EXPOSE 8080

# Make Java 8 obey container resource limits, improve performance
ENV JAVA_OPTS='-Djava.awt.headless=true'

# Set the container up with an entrypoint so we can make sure any runtime
# customizations happen at the appropriate time.
COPY entrypoint.sh .
ENTRYPOINT ["/opt/spring-boot/entrypoint.sh"]
RUN chmod a+x entrypoint.sh

# Set the default command to run on boot
CMD java $JAVA_AGENT -jar spring-boot.jar

# Copy the JAR file
COPY spring-boot-pet-clinic.jar /opt/spring-boot/spring-boot.jar 
