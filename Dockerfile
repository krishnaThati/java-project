# Use a Maven image for building
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the project source files
COPY src ./src

# Package the application
RUN mvn clean package

# List files for debugging
RUN ls -la /app/target

# Use Tomcat image
FROM tomcat:9.0-jdk17

# Remove the default webapps (optional, clean start)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built .war file from the previous build stage into Tomcat's webapps directory
#COPY --from=build /app/target/my-app.war /usr/local/tomcat/webapps/my-app.war
COPY --from=build target/*.war /usr/local/tomcat/webapps/ROOT.war
# Expose port 8080 for Tomcat
EXPOSE 8080
