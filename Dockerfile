# Stage 1: Build the application
FROM ubuntu:latest AS build
RUN apt-get update && \
    apt-get install openjdk-17-jdk -y
WORKDIR /app
COPY . .
RUN ./mvnw clean install

# Stage 2: Create a lightweight image with only JRE and the application JAR
FROM openjdk:17-jdk-slim
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/target/assignment.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
