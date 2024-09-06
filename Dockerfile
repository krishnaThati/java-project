# Use Tomcat image
FROM tomcat:9.0-jdk17

# Remove the default webapps (optional, clean start)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built .war file from the build context into Tomcat's webapps directory
#COPY krishna.war /usr/local/tomcat/webapps/krishna.war
COPY /home/runner/work/java-project/java-project/target/krishna.war /usr/local/tomcat/webapps/krishna.war

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
