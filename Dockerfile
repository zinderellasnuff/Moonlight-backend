FROM gradle:8-jdk21 AS build
WORKDIR /app
COPY . .
RUN gradle build --no-daemon -x test

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/Moonlight-backend-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
