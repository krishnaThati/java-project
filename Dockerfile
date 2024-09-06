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

# Use a lightweight JRE image to run the application
FROM openjdk:17-jdk-slim

# Copy the built .jar file from the previous build stage
COPY --from=build /app/target/my-app.jar /app/my-app.jar

# Expose the necessary port
EXPOSE 8080

# Define the command to run the application
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]
