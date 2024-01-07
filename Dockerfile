FROM ubuntu:latest AS build 
RUN apt-get update
RUN apt-get install openjdk-21-jdk -y
COPY . .

RUN ./mevan bootjar --no-daemon

FROM openjdk:21-jdk-slim 
EXPOSE 8080
COPY --from=build /build/lib/assignment-1.jar app.jar
ENTRYPOINT ["java", "jar", "app.jar"]