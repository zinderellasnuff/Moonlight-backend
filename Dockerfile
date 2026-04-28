FROM gradle:8-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle clean build --no-daemon -x test
RUN echo "=== JAR FILES ===" && ls -la /app/build/libs/

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
